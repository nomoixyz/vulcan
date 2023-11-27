// SPDX-License-Identifier: MIT
pragma solidity >=0.8.13 <0.9.0;

import {Test, expect} from "vulcan/test.sol";
import {rpc} from "vulcan/test/Rpc.sol";
import {Fork, forks} from "vulcan/test/Forks.sol";

contract RpcTest is Test {
    function testNetVersion() external {
        string memory rpcUrl = "https://rpc.mevblocker.io/fast";
        string memory method = "eth_chainId";
        string memory params = "[]";

        bytes memory data = rpc.call(rpcUrl, method, params);

        uint8 chainId;

        assembly {
            chainId := mload(add(data, 0x01))
        }

        expect(chainId).toEqual(block.chainid);
    }
}
