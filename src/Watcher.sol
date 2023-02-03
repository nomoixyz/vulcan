// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.7.0;

import "./Vulcan.sol";

struct Watcher {
    WatcherProxy proxy;
}

struct Call {
    bytes callData;
    bool success;
    bytes returnData;
    Log[] logs;
}

library WatcherLib {
    using WatcherLib for Watcher;

    struct Storage {
        mapping(WatcherProxy => WatcherStorage) storages;
    }

    bytes32 constant WATCHER_STORAGE_SLOT = keccak256("vulcan.watcher.storage.slot");

    function registerStorage(WatcherProxy proxy, WatcherStorage proxyStorage) internal {
       _internalStorage().storages[proxy]  = proxyStorage; 
    }

    function getStorage(Watcher memory self) internal view returns (WatcherStorage s) {
       return _internalStorage() .storages[self.proxy];
    }

    function calls(Watcher memory self, uint256 index) internal view returns (Call memory) {
        return self.getStorage().getCalls()[index];
    }

    function firstCall(Watcher memory self) internal view returns (Call memory) {
        return self.calls(0);
    }

    function lastCall(Watcher memory self) internal view returns (Call memory) {
        Call[] memory currentCalls = self.getStorage().getCalls();
        uint256 totalCalls = currentCalls.length;

        return currentCalls[totalCalls - 1];
    }

    function target(Watcher memory self) internal view returns (address) {
        return self.getStorage().target();
    }

    function setTarget(Watcher memory self, address _target) internal returns (Watcher memory) {
        self.getStorage().setTarget(_target);
    }

    function captureReverts(Watcher memory self) internal returns (Watcher memory) {
        self.getStorage().setCaptureReverts(true);
        return self;
    }
    
    function disableCaptureReverts(Watcher memory self) internal returns (Watcher memory) {
        self.getStorage().setCaptureReverts(false);
        return self;
    }

    function _internalStorage() private pure returns (Storage storage s) {
        bytes32 slot = WATCHER_STORAGE_SLOT;

        assembly {
            s.slot := slot
        }
    }
}

contract WatcherStorage {
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

    function getCalls() external view returns (Call[] memory) {
        return _calls;
    }

    function setCaptureReverts(bool _value) external {
        shouldCaptureReverts = _value;
    }

    function setTarget(address _target) external {
        target = _target;
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

using WatcherLib for Watcher global;
using WatcherLib for WatcherProxy;
