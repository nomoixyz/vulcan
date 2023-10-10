// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, expect, accounts} from "vulcan/test.sol";

/// @title Create multiple addresses
/// @dev Creating multiple addresses
contract AccountsExample is Test {
    function test() external {
        address[] memory addresses = accounts.createMany(10);

        expect(addresses.length).toEqual(10);
    }
}
