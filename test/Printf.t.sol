//// SPDX-License-Identifier: MIT
pragma solidity >=0.8.13 <0.9.0;

import {Test, expect, config, Rpc, console} from "../src/test.sol";
import {abiDecode, Type} from "../src/Printf.sol";

contract PrintfTest is Test {
    function testThing() external {
        Type[] memory types = new Type[](7);
        types[0] = Type.Uint256;
        types[1] = Type.Uint256;
        types[2] = Type.Address;
        types[3] = Type.String;
        types[4] = Type.Uint256;
        types[5] = Type.Address;
        types[6] = Type.String;

        string[] memory result = abiDecode(types, abi.encode(1, 2, address(3), "hello", 4, address(5), "world"));

        for (uint256 i = 0; i < result.length; i++) {
            console.log(result[i]);
        }
    }
}
