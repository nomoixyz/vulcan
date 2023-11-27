//// SPDX-License-Identifier: MIT
pragma solidity >=0.8.13 <0.9.0;

import {Test} from "../../src/test.sol";
import {expect} from "src/test/Expect.sol";
import {config, RpcConfig} from "src/test/Config.sol";

contract ConfigTest is Test {
    function testItCanObtainRpcUrls() external {
        string memory key = "mainnet";

        expect(config.rpcUrl(key)).toEqual("https://mainnet.rpc.io");
    }

    function testItCanObtainAllRpcUrls() external {
        string[2][] memory rpcs = config.rpcUrls();

        expect(rpcs.length).toEqual(2);
        expect(rpcs[0][0]).toEqual("arbitrum");
        expect(rpcs[0][1]).toEqual("https://arbitrum.rpc.io");
        expect(rpcs[1][0]).toEqual("mainnet");
        expect(rpcs[1][1]).toEqual("https://mainnet.rpc.io");
    }

    function testItCanObtainAllRpcUrlsAsStructs() external {
        RpcConfig[] memory rpcs = config.rpcUrlStructs();

        expect(rpcs.length).toEqual(2);
        expect(rpcs[0].name).toEqual("arbitrum");
        expect(rpcs[0].url).toEqual("https://arbitrum.rpc.io");
        expect(rpcs[1].name).toEqual("mainnet");
        expect(rpcs[1].url).toEqual("https://mainnet.rpc.io");
    }
}
