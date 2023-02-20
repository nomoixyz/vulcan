// SPDX-License-Identifier: MIT
pragma solidity >=0.8.13 <0.9.0;

import "./Vulcan.sol";
import "./Events.sol";
import "./Accounts.sol";
import "./Context.sol";
import "./Console.sol";

struct Call {
    bytes callData;
    bool success;
    bytes returnData;
    Log[] logs;
}

library watchers {
    using watchers for *;

    bytes32 constant WATCHERS_MAGIC = keccak256("vulcan.watchers.magic");

    function watcherAddress(address target) internal pure returns (address) {
        // Not sure if this is the best way but whatever
        return address(uint160(uint256(uint160(target)) + uint256(WATCHERS_MAGIC)));
    }

    function targetAddress(address _watcher) internal pure returns (address) {
        return address(uint160(uint256(uint160(_watcher)) - uint256(WATCHERS_MAGIC)));
    }

    function watcher(address target) internal view returns (Watcher) {
        address _watcher = watcherAddress(target);
        require(_watcher.code.length != 0, "Address doesn't have a watcher");

        return Watcher(_watcher);
    }

    function watch(address target) internal returns (Watcher) {
        address _watcher = watcherAddress(target);
        require(_watcher.code.length == 0, "Address already has a watcher");

        accounts.setCode(_watcher, type(Watcher).runtimeCode);

        WatcherProxy proxy = new WatcherProxy();

        bytes memory targetCode = target.code;

        // Switcheroo
        accounts.setCode(target, address(proxy).code);
        accounts.setCode(address(proxy), targetCode);

        Watcher(_watcher).setImplementationAddress(address(proxy));

        return Watcher(_watcher);
    }

    function stop(address target) internal {
        target.stopWatcher();
    }

    function stopWatcher(address target) internal {
        watcher(target).stop();
    }

    function calls(address target) internal view returns (Call[] memory) {
        return watcher(target).calls();
    }

    function getCall(address target, uint256 index) internal view returns (Call memory) {
        return watcher(target).getCall(index);
    }

    function firstCall(address target) internal view returns (Call memory) {
        return watcher(target).firstCall();
    }

    function lastCall(address target) internal view returns (Call memory) {
        return watcher(target).lastCall();
    }

    function captureReverts(address target) internal returns (Watcher) {
        Watcher _watcher = watcher(target);
        _watcher.captureReverts();
        return _watcher;
    }

    function disableCaptureReverts(address target) internal returns (Watcher) {
        Watcher _watcher = watcher(target);
        _watcher.disableCaptureReverts();
        return _watcher;
    }
}

contract Watcher {
    bool public shouldCaptureReverts;
    address public implementation;

    Call[] private _calls;

    function storeCall(bytes memory _callData, bool _success, bytes memory _returnData, Log[] memory _logs) external {
        Call storage call = _calls.push();
        call.callData = _callData;
        call.success = _success;
        call.returnData = _returnData;

        Log[] storage logs = call.logs;

        for (uint256 i; i < _logs.length; ++i) {
            logs.push(_logs[i]);
        }
    }

    function calls() external view returns (Call[] memory) {
        return _calls;
    }

    function getCall(uint256 index) external view returns (Call memory) {
        return _calls[index];
    }

    function firstCall() external view returns (Call memory) {
        return _calls[0];
    }

    function lastCall() external view returns (Call memory) {
        Call[] memory currentCalls = _calls;

        return currentCalls[currentCalls.length - 1];
    }

    function captureReverts() external {
        shouldCaptureReverts = true;
    }

    function disableCaptureReverts() external {
        shouldCaptureReverts = false;
    }

    function stop() external {
        address target = watchers.targetAddress(address(this));
        accounts.setCode(target, implementation.code);
        selfdestruct(payable(address(0)));
    }

    function setImplementationAddress(address _implementation) external {
        implementation = _implementation;
    }
}

contract WatcherProxy {
    using vulcan for *;

    address private immutable _target;

    constructor() {
        _target = address(this);
    }

    fallback(bytes calldata _callData) external payable returns (bytes memory) {
        vulcan.pauseGasMetering();
        bool isStatic = ctx.isStaticcall();

        if (!isStatic) {
            events.recordLogs();
        }

        vulcan.resumeGasMetering();

        (bool success, bytes memory returnData) = _target.delegatecall(_callData);

        vulcan.pauseGasMetering();

        // TODO: ugly, try to clean up
        if (!isStatic) {
            Log[] memory logs = events.getRecordedLogs();

            // Filter logs by address and replace in place
            uint256 watcherLogCount = 0;
            for (uint256 i = 0; i < logs.length; i++) {
                if (logs[i].emitter == address(this)) {
                    logs[watcherLogCount] = logs[i];
                    watcherLogCount++;
                }
            }

            Log[] memory filteredLogs = new Log[](watcherLogCount);

            // Add logs to call
            for (uint256 i = 0; i < watcherLogCount; i++) {
                filteredLogs[i] = logs[i];
            }

            Watcher watcher = watchers.watcher(address(this));
            watcher.storeCall(_callData, success, returnData, filteredLogs);

            if (!watcher.shouldCaptureReverts() && !success) {
                vulcan.resumeGasMetering();
                assembly {
                    revert(add(returnData, 32), mload(returnData))
                }
            }
        } else if (!success) {
            vulcan.resumeGasMetering();
            assembly {
                revert(add(returnData, 32), mload(returnData))
            }
        }

        vulcan.resumeGasMetering();

        return returnData;
    }
}
