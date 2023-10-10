// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, expect, config} from "vulcan/test.sol";

/// @title Obtain a specific RPC URL
/// @dev Read a specific RPC URL from the foundry configuration
contract ConfigExample is Test {
    function test() external {
        string memory key = "mainnet";

        expect(config.rpcUrl(key)).toEqual("https://mainnet.rpc.io");
    }
}
