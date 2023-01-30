// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.7.0;

library CallWatcherLib {
    bytes32 constant STORAGE_SLOT = keccak256("vulcan.callwatcher.slot");

    struct Storage {
        address target;
        bool success;
        bytes data;
    }

    function getStorage() internal pure returns (Storage storage s) {
        bytes32 slot = STORAGE_SLOT;

        assembly {
            s.slot := slot
        }
    }

    function setTarget(Storage storage s, address _target) internal returns (Storage storage) {
        s.target = _target;
        return s;
    }

    function setSuccess(Storage storage s, bool _success) internal returns (Storage storage) {
        s.success = _success;
        return s;
    }

    function setData(Storage storage s, bytes memory _data) internal returns (Storage storage) {
        s.data = _data;
        return s;
    }
}

contract CallWatcher {
    using CallWatcherLib for *;

    function wasSuccess() external view returns (bool) {
        return CallWatcherLib.getStorage().success;
    }

    function setTarget(address _target) external {
        CallWatcherLib.getStorage().setTarget(_target);
    }

    fallback(bytes calldata _callData) external payable returns (bytes memory) {
        CallWatcherLib.Storage storage s = CallWatcherLib.getStorage();

        (bool success, bytes memory data) = s.target.delegatecall(_callData);

        s.setSuccess(success).setData(data);

        return data;
    }
}
