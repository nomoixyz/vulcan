// SPDX-License-Identifier: MIT
pragma solidity >=0.8.13 <0.9.0;

import "./Vulcan.sol";

library strings {
    /// @dev Transforms an address to a string.
    /// @param value The address to parse.
    /// @return The string representation of `value`.
    function toString(address value) internal pure returns (string memory) {
        return vulcan.hevm.toString(value);
    }

    /// @dev Transforms a byte array to a string.
    /// @param value The byte array to parse.
    /// @return The string representation of `value`.
    function toString(bytes memory value) internal pure returns (string memory) {
        return vulcan.hevm.toString(value);
    }

    /// @dev Transforms a bytes32 to a string.
    /// @param value The bytes32 to parse.
    /// @return The string representation of `value`.
    function toString(bytes32 value) internal pure returns (string memory) {
        return vulcan.hevm.toString(value);
    }

    /// @dev Transforms a boolean to a string.
    /// @param value The boolean to parse.
    /// @return The string representation of `value`.
    function toString(bool value) internal pure returns (string memory) {
        return vulcan.hevm.toString(value);
    }

    /// @dev Transforms an uint256 to a string.
    /// @param value The uint256 to parse.
    /// @return The string representation of `value`.
    function toString(uint256 value) internal pure returns (string memory) {
        return vulcan.hevm.toString(value);
    }

    /// @dev Transforms an int256 to a string.
    /// @param value The int256 to parse.
    /// @return The string representation of `value`.
    function toString(int256 value) internal pure returns (string memory) {
        return vulcan.hevm.toString(value);
    }

    /// @dev Parses a byte array string.
    /// @param value The string to parse.
    /// @return The parsed byte array.
    function parseBytes(string memory value) internal pure returns (bytes memory) {
        return vulcan.hevm.parseBytes(value);
    }

    /// @dev Parses an address string.
    /// @param value The string to parse.
    /// @return The parsed address.
    function parseAddress(string memory value) internal pure returns (address) {
        return vulcan.hevm.parseAddress(value);
    }

    /// @dev Parses an uint256 string.
    /// @param value The string to parse.
    /// @return The parsed uint256.
    function parseUint(string memory value) internal pure returns (uint256) {
        return vulcan.hevm.parseUint(value);
    }

    /// @dev Parses an int256 string.
    /// @param value The string to parse.
    /// @return The parsed int256.
    function parseInt(string memory value) internal pure returns (int256) {
        return vulcan.hevm.parseInt(value);
    }

    /// @dev Parses a bytes32 string.
    /// @param value The string to parse.
    /// @return The parsed bytes32.
    function parseBytes32(string memory value) internal pure returns (bytes32) {
        return vulcan.hevm.parseBytes32(value);
    }

    /// @dev Parses a boolean string.
    /// @param value The string to parse.
    /// @return The parsed boolean.
    function parseBool(string memory value) internal pure returns (bool) {
        return vulcan.hevm.parseBool(value);
    }
}
