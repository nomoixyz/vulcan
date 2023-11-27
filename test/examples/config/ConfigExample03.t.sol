// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, expect, config, RpcConfig} from "vulcan/test.sol";

/// @title Obtain all the RPC URLs using structs
/// @dev Read all the RPC URL from the foundry configuration as structs
contract ConfigExample is Test {
    function test() external {
        RpcConfig[] memory rpcs = config.rpcUrlStructs();

        expect(rpcs.length).toEqual(2);
        expect(rpcs[0].name).toEqual("arbitrum");
        expect(rpcs[0].url).toEqual("https://arbitrum.rpc.io");
        expect(rpcs[1].name).toEqual("mainnet");
        expect(rpcs[1].url).toEqual("https://mainnet.rpc.io");
    }
}
