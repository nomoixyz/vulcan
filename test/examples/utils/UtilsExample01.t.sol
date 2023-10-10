// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, expect, println} from "vulcan/test.sol";

/// @title Using println
/// @dev Using the println function to log formatted data
contract UtilsExample is Test {
    function test() external view {
        println("Log a simple string");

        string memory someString = "someString";
        println("This is a string: {s}", abi.encode(someString));

        uint256 aNumber = 123;
        println("This is a uint256: {u}", abi.encode(aNumber));

        println("A string: {s} and a number: {u}", abi.encode(someString, aNumber));
    }
}
