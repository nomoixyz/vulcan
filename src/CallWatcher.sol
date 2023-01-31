// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.7.0;

library CallWatcherLib {
    bytes32 constant STORAGE_SLOT = keccak256("vulcan.callwatcher.slot");

    struct CallResult {
        bool success;
        bytes data;
    }

    struct Storage {
        address target;
        CallResult[] results;
    }

    function getStorage() internal pure returns (Storage storage s) {
        bytes32 slot = STORAGE_SLOT;

        assembly {
            s.slot := slot
        }
    }

    function resultWasSuccess(Storage storage s, uint256 _index) internal view returns (bool) {
        return s.results[_index].success;
    }

    function setTarget(Storage storage s, address _target) internal returns (Storage storage) {
        s.target = _target;

        return s;
    }

    function addResult(Storage storage s, bool _success, bytes memory _data) internal returns (Storage storage) {
        CallResult memory result = CallResult(_success, _data);

        s.results.push(result);

        return s;
    }
}

contract CallWatcher {
    using CallWatcherLib for *;

    function wasSuccess(uint256 _callIndex) external view returns (bool) {
        return CallWatcherLib.getStorage().resultWasSuccess(_callIndex);
    }

    function setTarget(address _target) external {
        CallWatcherLib.getStorage().setTarget(_target);
    }

    fallback(bytes calldata _callData) external payable returns (bytes memory) {
        CallWatcherLib.Storage storage s = CallWatcherLib.getStorage();

        (bool success, bytes memory data) = s.target.delegatecall(_callData);

        s.addResult(success, data);

        return data;
    }
}
