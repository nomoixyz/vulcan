// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, expect, strings} from "vulcan/test.sol";

/// @title Transforming and parsing
/// @dev Transform values to strings and parse strings to values
contract StringsExample is Test {
    using strings for *;

    function test() external {
        uint256 uintValue = 123;
        string memory uintString = uintValue.toString();
        expect(uintString).toEqual("123");
        expect(uintString.parseUint()).toEqual(uintValue);

        bool boolValue = true;
        string memory boolString = boolValue.toString();
        expect(boolString).toEqual("true");
        expect(boolString.parseBool()).toEqual(true);

        bytes32 bytes32Value = bytes32(uintValue);
        string memory bytes32String = bytes32Value.toString();
        expect(bytes32String).toEqual("0x000000000000000000000000000000000000000000000000000000000000007b");
        expect(bytes32String.parseBytes32()).toEqual(bytes32Value);
    }
}
