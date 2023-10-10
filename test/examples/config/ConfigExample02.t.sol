// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, expect, config} from "vulcan/test.sol";

/// @title Obtain all the RPC URLs
/// @dev Read all the RPC URLs from the foundry configuration
contract ConfigExample is Test {
    function test() external {
        string[2][] memory rpcs = config.rpcUrls();

        expect(rpcs.length).toEqual(2);
        expect(rpcs[0][0]).toEqual("arbitrum");
        expect(rpcs[0][1]).toEqual("https://arbitrum.rpc.io");
        expect(rpcs[1][0]).toEqual("mainnet");
        expect(rpcs[1][1]).toEqual("https://mainnet.rpc.io");
    }
}
