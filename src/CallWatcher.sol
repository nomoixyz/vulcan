// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.7.0;

contract CallWatcher {
    struct Result {
        bool success;
        bytes data;
    }

    bytes32 constant CALLS_SLOT = keccak256("vulcan.callwatcher.slot");
    address immutable target = address(this);

    function calls(uint256 _index) external view returns (Result memory) {
        return _getCalls()[_index];
    }

    fallback(bytes calldata _callData) external payable returns (bytes memory) {
        (bool success, bytes memory data) = target.delegatecall(_callData);

        _getCalls().push(Result(success, data));

        return data;
    }

    function _getCalls() internal pure returns (Result[] storage results) {
        bytes32 slot = CALLS_SLOT;

        assembly {
            results.slot := slot
        }
    }
}
