// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, expect, accounts} from "vulcan/test.sol";

/// @title Create multiple labeled addresses with a prefix
/// @dev This example shows how to create multiple addresses labeled with the prefix `Account`
contract AccountsExample04 is Test {
    function test() external {
        address[] memory addresses = accounts.createMany(10, "Account");

        expect(addresses.length).toEqual(10);
    }
}
