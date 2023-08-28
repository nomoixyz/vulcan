// SPDX-License-Identifier: MIT
pragma solidity >=0.8.13 <0.9.0;

import {Vm as Hevm} from "forge-std/Vm.sol";
import "./Vulcan.sol";

library events {
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
