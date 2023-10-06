// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, expect, StringResult, Ok} from "vulcan/test.sol";

/// @title Working with result values
/// @dev This example shows different ways of getting the underlyng value of a `Result`
contract ResultExample01 is Test {
    function test() external {
        StringResult result = Ok(string("foo"));

        // Use unwrap to get the value or revert if the result is an `Error`
        string memory unwrapValue = result.unwrap();
        expect(unwrapValue).toEqual("foo");

        // Use expect to get the value or revert with a custom message if
        // the result is an `Error`
        string memory expectValue = result.expect("Result failed");
        expect(expectValue).toEqual("foo");

        // Safely getting the value
        if (result.isOk()) {
            string memory value = result.toValue();
            expect(value).toEqual("foo");
        }
    }
}
