// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, expect, accounts} from "vulcan/test.sol";

/// @title Create an address
/// @dev How to create a simple address
contract AccountsExample is Test {
    function test() external {
        address alice = accounts.create();

        expect(alice).not.toEqual(address(0));
    }
}
