// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, accounts, expect, fmt} from "vulcan/test.sol";

/// @title Formatting decimals
/// @dev Use the `{uint:dx}` placeholder to format numbers with decimals
contract FormatExample is Test {
    using accounts for address;

    function test() external {
        address target = address(1).setBalance(1e17);
        uint256 balance = target.balance;

        expect(fmt.format("The account {address} has {uint:d18} eth", abi.encode(target, balance))).toEqual(
            "The account 0x0000000000000000000000000000000000000001 has 0.1 eth"
        );
    }
}
