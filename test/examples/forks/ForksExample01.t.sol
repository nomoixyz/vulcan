// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, expect, vulcan} from "vulcan/test.sol";
import {forks, Fork} from "vulcan/test/Forks.sol";
import {ctx} from "vulcan/test/Context.sol";

/// @title How to use forks
/// @dev How to use forks. This example assumes there is a JSON RPC server running at `localhost:8545`
contract ForksExample is Test {
    string constant RPC_URL = "http://localhost:8545";

    function test() external {
        forks.create(RPC_URL).select();

        expect(block.chainid).toEqual(31337);
    }
}
