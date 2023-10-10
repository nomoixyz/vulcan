// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, expect, format} from "vulcan/test.sol";

/// @title Using format
/// @dev Using the format function to format data
contract FormatExample is Test {
    function test() external {
        uint256 uno = 1;

        string memory formatted = format("is {u} greater than 0? {bool}", abi.encode(uno, uno > 0));

        expect(formatted).toEqual("is 1 greater than 0? true");
    }
}
