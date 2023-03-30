//// SPDX-License-Identifier: MIT
pragma solidity >=0.8.13 <0.9.0;

import {Test, expect, config, Rpc, console} from "../src/test.sol";
import {abiDecode, Type} from "../src/Printf.sol";

contract PrintfTest is Test {
    function testThing() external {
        Type[] memory types = new Type[](2);
        types[0] = Type.Uint256;
        types[1] = Type.Uint256;
        string[] memory result = abiDecode(types, abi.encode(1, 2));

        for (uint256 i = 0; i < result.length; i++) {
            console.log(result[i]);
        }
    }
}
