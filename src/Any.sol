pragma solidity >=0.8.13 <0.9.0;

library AnyLib {
    struct _AnyData {
        uint256 count;
        mapping(bytes32 => bool) used;
    }

    function value() internal returns (bytes32) {
        return _any();
    }

    function check(bytes32 val) internal returns (bool res) {
        _AnyData storage data = _getData();
        res = data.used[val];
        delete data.used[val];
    }

    function _getData() private pure returns (_AnyData storage data) {
        uint256 slot = uint256(keccak256("any"));
        assembly {
            data.slot := slot
        }
    }

    function _any() private returns (bytes32 val) {
        _AnyData storage data = _getData();
        val = keccak256(abi.encode(msg.data, data.count++));
        data.used[val] = true;
    }
}

function any() returns (bytes32) {
    return AnyLib.value();
}
