// SPDX-License-Identifier: MIT
pragma solidity >=0.8.13 <0.9.0;

import {Vm as Hevm} from "forge-std/Vm.sol";
import "./Vulcan.sol";

library events {
    /// @dev Transform a fixed array of `bytes32` to a dynamic array of `bytes32`.
    /// @param topics The fixed array to transform.
    /// @return _topics The dynamic array.
    function toDynamic(bytes32[1] memory topics) internal pure returns (bytes32[] memory _topics) {
        _topics = new bytes32[](1);
        _topics[0] = topics[0];
    }

    /// @dev Transform a fixed array of `bytes32` to a dynamic array of `bytes32`.
    /// @param topics The fixed array to transform.
    /// @return _topics The dynamic array.
    function toDynamic(bytes32[2] memory topics) internal pure returns (bytes32[] memory _topics) {
        _topics = new bytes32[](2);
        _topics[0] = topics[0];
        _topics[1] = topics[1];
    }

    /// @dev Transform a fixed array of `bytes32` to a dynamic array of `bytes32`.
    /// @param topics The fixed array to transform.
    /// @return _topics The dynamic array.
    function toDynamic(bytes32[3] memory topics) internal pure returns (bytes32[] memory _topics) {
        _topics = new bytes32[](3);
        _topics[0] = topics[0];
        _topics[1] = topics[1];
        _topics[2] = topics[2];
    }

    /// @dev Transform a fixed array of `bytes32` to a dynamic array of `bytes32`.
    /// @param topics The fixed array to transform.
    /// @return _topics The dynamic array.
    function toDynamic(bytes32[4] memory topics) internal pure returns (bytes32[] memory _topics) {
        _topics = new bytes32[](4);
        _topics[0] = topics[0];
        _topics[1] = topics[1];
        _topics[2] = topics[2];
        _topics[3] = topics[3];
    }

    /// @dev Obtains the topic representation of an `uint256` parameter.
    /// @param _param The `uint256` value.
    /// @return The representation of `_param` as an event topic.
    function topic(uint256 _param) internal pure returns (bytes32) {
        return bytes32(_param);
    }

    /// @dev Obtains the topic representation of a `string` parameter.
    /// @param _param The `string` value.
    /// @return The representation of `_param` as an event topic.
    function topic(string memory _param) internal pure returns (bytes32) {
        return keccak256(bytes(_param));
    }

    /// @dev Obtains the topic representation of an `address` parameter.
    /// @param _param The `address` value.
    /// @return The representation of `_param` as an event topic.
    function topic(address _param) internal pure returns (bytes32) {
        return bytes32(uint256(uint160(_param)));
    }

    /// @dev Obtains the topic representation of a `bytes32` parameter.
    /// @param _param The `bytes32` value.
    /// @return The representation of `_param` as an event topic.
    function topic(bytes32 _param) internal pure returns (bytes32) {
        return _param;
    }

    /// @dev Obtains the topic representation of a `bytes` parameter.
    /// @param _param The `bytes` value.
    /// @return The representation of `_param` as an event topic.
    function topic(bytes memory _param) internal pure returns (bytes32) {
        return keccak256(_param);
    }

    /// @dev Obtains the topic representation of a `bool` parameter.
    /// @param _param The `bool` value.
    /// @return The representation of `_param` as an event topic.
    function topic(bool _param) internal pure returns (bytes32) {
        return bytes32(uint256(_param ? 1 : 0));
    }

    /// @dev Obtains the topic representation of a `int256` parameter.
    /// @param _param The `int256` value.
    /// @return The representation of `_param` as an event topic.
    function topic(int256 _param) internal pure returns (bytes32) {
        // TODO: is this correct?
        return bytes32(uint256(_param));
    }

    /// @dev Starts recording all transactions logs.
    function recordLogs() internal {
        vulcan.hevm.recordLogs();
    }

    /// @dev Obtains all recorded transactions logs.
    function getRecordedLogs() internal returns (Log[] memory logs) {
        Hevm.Log[] memory recorded = vulcan.hevm.getRecordedLogs();
        assembly {
            logs := recorded
        }
    }
}
