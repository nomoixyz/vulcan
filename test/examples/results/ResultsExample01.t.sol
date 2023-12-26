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
        string memory value = result.unwrap();
        expect(value).toEqual("foo");

        // Use expect to get the value or revert with a custom message if
        // the result is an `Error`
        value = result.expect("Result failed");
        expect(value).toEqual("foo");

        // Safely handling the result
        if (result.isOk()) {
            value = result.toValue();
            expect(value).toEqual("foo");
        }
    }
}
