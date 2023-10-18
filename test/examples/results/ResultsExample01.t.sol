// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, expect, StringResult} from "vulcan/test.sol";
// This import is just to demonstration, it's not meant to be imported on projects using Vulcan
import {Ok} from "vulcan/_internal/Result.sol";

/// @title Working with result values
/// @dev Different methods of getting the underlyng value of a `Result`
contract ResultExample is Test {
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
