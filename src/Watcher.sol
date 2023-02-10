// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.13 <0.9.0;

import "./Vulcan.sol";
import "./Events.sol";
import "./Accounts.sol";

struct Call {
    bytes callData;
    bool success;
    bytes returnData;
    Log[] logs;
}

library watchers {
    using watchers for *;

    bytes32 constant WATCHERS_MAGIC = keccak256("vulcan.watchers.magic");

    function watcherAddress(address target) internal view returns (address) {
        return address(uint160(uint256(keccak256(abi.encodePacked(target, WATCHERS_MAGIC)))));
    }

    function watcher(address target) internal returns (Watcher memory) {
        address _watcher = watcherAddress(target);
        require(_watcher.code != bytes(0), "Address doesn't have a watcher");

        return Watcher(_watcher);
    }

    function watch(address target) internal returns (Watcher memory) {
        address _watcher = watcherAddress(target);
        require(_watcher.code == bytes(0), "Address already has a watcher");

        accounts.setCode(_watcher, type(Watcher).runtimeBytecode);

        WatcherProxy proxy = new WatcherProxy(_watcher);

        bytes memory targetCode = target.code;

        // Switcheroo
        vulcan.hevm.etch(target, address(proxy).code);
        vulcan.hevm.etch(address(proxy), targetCode);

        return Watcher(_watcher);
    }

    function stop(address target) internal {
        target.stopWatcher();
    }

    function stopWatcher(address target) internal {
        watcher(target).stop();
    }

    function stop(Watcher self) internal {
        require(address(self.watcherStorage) != address(0), "Address doesn't have a watcher");

        address proxy = self.watcherStorage.proxy();
        address target = self.watcherStorage.target();

        // reverse-Switcheroo
        vulcan.hevm.etch(proxy, target.code);
        vulcan.hevm.etch(target, "");
    }

    function calls(address target) internal view returns (Call[] memory) {
        return watcher(target).calls();
    }

    function getCall(address target, uint256 index) internal view returns (Call memory) {
        return watcher(target).getCall(index);
    }

    function firstCall(address target) internal view returns(Call memory) {
        return watcher(target).firstCall();
    }

    function lastCall(address target) internal view returns(Call memory) {
        return watcher(target).lastCall();
    }

    function captureReverts(address target) internal returns (Watcher) {
        return watcher(target).captureReverts();
    }

    function disableCaptureReverts(address target) internal returns (Watcher) {
        return watcher(target).disableCaptureReverts();
    }
}

contract Watcher {
    address public proxy;
    address public target;
    bool public shouldCaptureReverts;
    Call[] _calls;

    function storeCall(
        bytes memory _callData,
        bool _success,
        bytes memory _returnData,
        Log[] memory _logs
    ) external {
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

    function setTarget(address _target) external {
        target = _target;
    }

    function setProxy(address _proxy) external {
        proxy = _proxy;
    }
}

contract WatcherProxy {
    using vulcan for *;

    address immutable _target;

    constructor() {
        _target = address(this);
    }

    fallback(bytes calldata _callData) external payable returns (bytes memory) {
        events.recordLogs();

        (bool success, bytes memory returnData) = _target.delegatecall(_callData);

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
            assembly {
                revert(add(returnData, 32), mload(returnData))
            }
        }
        
        return returnData;
    }
}

using watchers for Watcher global;
