// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, expect, accounts} from "vulcan/test.sol";

/// @title Create a labeled address
/// @dev Creating an address labeled as "Alice"
contract AccountsExample is Test {
    function test() external {
        address alice = accounts.create("Alice");

        expect(alice).not.toEqual(address(0));
    }
}
