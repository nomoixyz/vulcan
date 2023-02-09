// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.13 <0.9.0;

import "./Vulcan.sol";
import "./Events.sol";

struct Watcher {
    WatcherStorage watcherStorage;
}

struct Call {
    bytes callData;
    bool success;
    bytes returnData;
    Log[] logs;
}

library watchers {
    using watchers for *;

    bytes32 constant STORAGES_SLOT = keccak256("vulcan.watchers.storages.slot");

    function storages() internal pure returns (mapping(address => WatcherStorage) storage s) {
        bytes32 SLOT = STORAGES_SLOT;

        assembly {
            s.slot := SLOT
        }
    }

    function watcher(address target) internal returns (Watcher memory) {
        WatcherStorage watcherStorage = storages()[target];
        require(address(watcherStorage) != address(0), "Addess doesn't have a watcher");

        return Watcher(watcherStorage);
    }

    function watch(address target) internal returns (Watcher memory) {
        require(address(storages()[target]) == address(0), "Address already has a watcher");

        WatcherStorage proxyStorage = new WatcherStorage();

        WatcherProxy proxy = new WatcherProxy(proxyStorage);

        proxyStorage.setTarget(address(proxy));
        proxyStorage.setProxy(target);

        bytes memory targetCode = target.code;

        // Switcheroo
        vulcan.hevm.etch(target, address(proxy).code);
        vulcan.hevm.etch(address(proxy), targetCode);

        storages()[target] = proxyStorage;

        return Watcher(proxyStorage);
    }

    function stop(address target) internal {
        Watcher(storages()[target]).stop();
    }

    function stopWatcher(address target) internal {
        Watcher(storages()[target]).stop();
    }

    function stop(Watcher memory self) internal {
        require(address(self.watcherStorage) != address(0), "Address doesn't have a watcher");

        address proxy = self.watcherStorage.proxy();
        address target = self.watcherStorage.target();

        // reverse-Switcheroo
        vulcan.hevm.etch(proxy, target.code);
        vulcan.hevm.etch(target, proxy.code);

        delete storages()[target];
    }

    function calls(address target) internal view returns (Call[] memory) {
        return Watcher(storages()[target]).calls();
    }

    function calls(Watcher memory self) internal view returns (Call[] memory) {
        require(address(self.watcherStorage) != address(0), "Address doesn't have a watcher");
        return self.watcherStorage.calls();
    }

    function getCall(address target, uint256 index) internal view returns (Call memory) {
        return Watcher(storages()[target]).getCall(index);
    }

    function getCall(Watcher memory self, uint256 index) internal view returns(Call memory) {
        require(address(self.watcherStorage) != address(0), "Address doesn't have a watcher");
        return self.watcherStorage.getCall(index);
    }

    function firstCall(address target) internal view returns(Call memory) {
        return Watcher(storages()[target]).firstCall();
    }

    function firstCall(Watcher memory self) internal view returns(Call memory) {
        require(address(self.watcherStorage) != address(0), "Address doesn't have a watcher");
        return self.watcherStorage.firstCall();
    }

    function lastCall(address target) internal view returns(Call memory) {
        return Watcher(storages()[target]).lastCall();
    }

    function lastCall(Watcher memory self) internal view returns(Call memory) {
        require(address(self.watcherStorage) != address(0), "Address doesn't have a watcher");
        return self.watcherStorage.lastCall();
    }

    function captureReverts(address target) internal returns (Watcher memory) {
        return Watcher(storages()[target]).captureReverts();
    }

    function captureReverts(Watcher memory self) internal returns (Watcher memory) {
        require(address(self.watcherStorage) != address(0), "Address doesn't have a watcher");
        self.watcherStorage.setCaptureReverts(true);
        return self;
    }

    function disableCaptureReverts(address target) internal returns (Watcher memory) {
        return Watcher(storages()[target]).disableCaptureReverts();
    }

    function disableCaptureReverts(Watcher memory self) internal returns (Watcher memory) {
        require(address(self.watcherStorage) != address(0), "Address doesn't have a watcher");
        self.watcherStorage.setCaptureReverts(false);
        return self;
    }
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

        _storage.storeCall(_callData, success, returnData, filteredLogs);

        if (!_storage.shouldCaptureReverts() && !success) {
            assembly {
                revert(add(returnData, 32), mload(returnData))
            }
        }
        
        return returnData;
    }
}

