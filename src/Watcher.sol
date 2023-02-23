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

    /// @dev Magic.
    bytes32 constant WATCHERS_MAGIC = keccak256("vulcan.watchers.magic");

    /// @dev Obtains the address of the watcher for `target`.
    /// @param target The address for which we need to get the watcher address.
    /// @return The address of the watcher.
    function watcherAddress(address target) internal pure returns (address) {
        return address(uint160(uint256(uint160(target)) ^ uint256(WATCHERS_MAGIC)));
    }

    /// @dev Obtains the address of the target for `_target`.
    /// @param _watcher The address for which we need to get the target address.
    /// @return The address of the target.
    function targetAddress(address _watcher) internal pure returns (address) {
        return address(uint160(uint256(uint160(_watcher)) ^ uint256(WATCHERS_MAGIC)));
    }

    /// @dev Obtains the Watcher implementation for the `target` address.
    /// @param target The address used to obtain the watcher implementation address.
    /// @return The Watcher implementation.
    function watcher(address target) internal view returns (Watcher) {
        address _watcher = watcherAddress(target);
        require(_watcher.code.length != 0, "Address doesn't have a watcher");

        return Watcher(_watcher);
    }

    /// @dev Starts watching a `target` address.
    /// @param target The address to watch.
    /// @return The Watcher implementation.
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

    /// @dev Stops watching the `target` address.
    /// @param target The address to stop watching.
    function stop(address target) internal {
        target.stopWatcher();
    }

    /// @dev Stops watching the `target` address.
    /// @param target The address to stop watching.
    function stopWatcher(address target) internal {
        watcher(target).stop();
    }

    /// @dev Obtains all the calls made to the `target` address.
    /// @param target The address of the target contract to query.
    /// @return An array of `Call` structs, each containing information about a call.
    function calls(address target) internal view returns (Call[] memory) {
        return watcher(target).calls();
    }

    /// @dev Obtains an specific call made to the `target` address at an specific index.
    /// @param target The address of the target contract to query.
    /// @param index The index of the call to query.
    /// @return A `Call` struct that contains the information about the call.
    function getCall(address target, uint256 index) internal view returns (Call memory) {
        return watcher(target).getCall(index);
    }

    /// @dev Obtains the first call made to the `target` address.
    /// @param target The address of the target contract to query.
    /// @return A `Call` struct that contains the information about the call.
    function firstCall(address target) internal view returns (Call memory) {
        return watcher(target).firstCall();
    }

    /// @dev Obtains the last call made to the `target` address.
    /// @param target The address of the target contract to query.
    /// @return A `Call` struct that contains the information about the call.
    function lastCall(address target) internal view returns (Call memory) {
        return watcher(target).lastCall();
    }

    /// @dev Starts capturing reverts for the `target` address. This will prevent the `target` contract to
    /// revert until `disableCaptureReverts` is called. This is meant to be used in conjunction with the `toHaveReverted` and
    /// `toHaveRevertedWith` functions from the expect library.
    /// @param target The address for which the reverts are going to be captured.
    /// @return The Watcher implementation.
    function captureReverts(address target) internal returns (Watcher) {
        Watcher _watcher = watcher(target);
        _watcher.captureReverts();
        return _watcher;
    }

    /// @dev Stops capturing reverts for the `target` address.
    /// @param target The target address.
    /// @return The Watcher implementation.
    function disableCaptureReverts(address target) internal returns (Watcher) {
        Watcher _watcher = watcher(target);
        _watcher.disableCaptureReverts();
        return _watcher;
    }
}

contract Watcher {
    /// @dev Whether to capture reverts or not.
    bool public shouldCaptureReverts;
    /// @dev The address of the implementation.
    address public implementation;

    /// @dev Stores all the calls made.
    Call[] private _calls;

    /// @dev Stores a call.
    /// @param _callData The data for the call.
    /// @param _success True if the call succeeded, false otherwise.
    /// @param _returnData The data that was returned from the call.
    /// @param _logs The logs that were emitted on the call.
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

    /// @dev Returns all the calls that were made to the `implementation` contract.
    /// @return An array of `Call` structs, each containing information about a call.
    function calls() external view returns (Call[] memory) {
        return _calls;
    }

    /// @dev Returns a specific call that was made to the `implementation` contract.
    /// @return A `Call` struct containing information about a call.
    function getCall(uint256 index) external view returns (Call memory) {
        return _calls[index];
    }

    /// @dev Returns the first call that was made to the `implementation` contract.
    /// @return A `Call` struct containing information about a call.
    function firstCall() external view returns (Call memory) {
        return _calls[0];
    }

    /// @dev Returns the last call that was made to the `implementation` contract.
    /// @return A `Call` struct containing information about a call.
    function lastCall() external view returns (Call memory) {
        Call[] memory currentCalls = _calls;

        return currentCalls[currentCalls.length - 1];
    }

    /// @dev Starts capturing reverts for the `implementation` contract.
    function captureReverts() external {
        shouldCaptureReverts = true;
    }

    /// @dev Stops capturing reverts for the `implementation` contract.
    function disableCaptureReverts() external {
        shouldCaptureReverts = false;
    }

    /// @dev Stops watching calls for the `implementation` contract.
    function stop() external {
        address target = watchers.targetAddress(address(this));
        accounts.setCode(target, implementation.code);
        selfdestruct(payable(address(0)));
    }

    /// @dev Sets the address of the `implementation` contract.
    /// @param _implementation The address of the implementation contract.
    function setImplementationAddress(address _implementation) external {
        implementation = _implementation;
    }
}

contract WatcherProxy {
    using vulcan for *;

    /// @dev The target contract
    address private immutable _target;

    constructor() {
        _target = address(this);
    }

    /// @dev A fallback function that will capture every call made to this contract and proxy them
    /// to `_target`.
    /// @param _callData The call data.
    /// @return The data returnded from the `_target` contract proxied call.
    fallback(bytes calldata _callData) external payable returns (bytes memory) {
        ctx.pauseGasMetering();
        bool isStatic = ctx.isStaticcall();

        if (!isStatic) {
            events.recordLogs();
        }

        ctx.resumeGasMetering();

        (bool success, bytes memory returnData) = _target.delegatecall(_callData);

        ctx.pauseGasMetering();

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
                ctx.resumeGasMetering();
                assembly {
                    revert(add(returnData, 32), mload(returnData))
                }
            }
        } else if (!success) {
            ctx.resumeGasMetering();
            assembly {
                revert(add(returnData, 32), mload(returnData))
            }
        }

        ctx.resumeGasMetering();

        return returnData;
    }
}
