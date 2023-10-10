// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, expect, accounts} from "vulcan/test.sol";

/// @title Use method chaining on addresses
/// @dev Use method chaining on addresses to call multiple methods
contract AccountsExample05 is Test {
    using accounts for address;

    function test() external {
        address alice = accounts.create("Alice").setNonce(666).setBalance(100e18);

        address bob = accounts.create("Bob").setBalance(10e18).impersonateOnce();

        payable(alice).transfer(bob.balance);

        expect(alice.balance).toEqual(110e18);
        expect(alice.getNonce()).toEqual(666);
        expect(bob.balance).toEqual(0);
    }
}
