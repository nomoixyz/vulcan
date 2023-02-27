//// SPDX-License-Identifier: MIT
pragma solidity >=0.8.13 <0.9.0;

import {Test, expect, config, Rpc, console} from "../src/test.sol";

contract ConfigTest is Test {
    function testItCanObtainRpcUrls() external {
        string memory key = "fake";

        expect(config.rpcUrl(key)).toEqual("https://my-fake-rpc-url");
    }

    function testItCanObtainAllRpcUrls() external {
        string[2][] memory rpcs = config.rpcUrls();

        expect(rpcs.length).toEqual(2);
        expect(rpcs[0][0]).toEqual("fake");
        expect(rpcs[0][1]).toEqual("https://my-fake-rpc-url");
        expect(rpcs[1][0]).toEqual("solana-rulz");
        expect(rpcs[1][1]).toEqual("https://solana-rulz.gg");
    }

    function testItCanObtainAllRpcUrlsAsStructs() external {
        Rpc[] memory rpcs = config.rpcUrlStructs();

        expect(rpcs.length).toEqual(2);
        expect(rpcs[0].name).toEqual("fake");
        expect(rpcs[0].url).toEqual("https://my-fake-rpc-url");
        expect(rpcs[1].name).toEqual("solana-rulz");
        expect(rpcs[1].url).toEqual("https://solana-rulz.gg");
    }
}
