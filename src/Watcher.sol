// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.7.0;

import "./Vulcan.sol";

struct Call {
    bytes callData;
    bool success;
    bytes returnData;
    Log[] logs;
}

contract WatcherStorage {
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

    function callAt(uint256 index) external view returns (Call memory) {
        return _calls[index];
    }

    function firstCall() external view returns (Call memory) {
        return _calls[0];
    }

    function lastCall() external view returns (Call memory) {
        Call[] memory currentCalls = _calls;

        return currentCalls[currentCalls.length - 1];
    }

    function setCaptureReverts(bool _value) external {
        shouldCaptureReverts = _value;
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

    WatcherStorage immutable _storage;
    address immutable _target;

    constructor(WatcherStorage _watcherStorage) {
        _storage = _watcherStorage;
        _target = address(this);
    }

    fallback(bytes calldata _callData) external payable returns (bytes memory) {
        vulcan.vm.recordLogs();

        (bool success, bytes memory returnData) = _target.delegatecall(_callData);

        Log[] memory logs = vulcan.vm.getRecordedLogs();

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

        _storage.storeCall(_callData, success, returnData, filteredLogs);

        if (!_storage.shouldCaptureReverts() && !success) {
            assembly {
                revert(add(returnData, 32), mload(returnData))
            }
        }
        
        return returnData;
    }
}
