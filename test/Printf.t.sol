//// SPDX-License-Identifier: MIT
pragma solidity >=0.8.13 <0.9.0;

import {Test, expect, config, Rpc, console} from "../src/test.sol";
import {abiDecode, Type} from "../src/Printf.sol";

contract PrintfTest is Test {
    function testThing() external {
        Type[] memory types = new Type[](10);
        types[0] = Type.Uint256;
        types[1] = Type.Bytes;
        types[2] = Type.Address;
        types[3] = Type.String;
        types[4] = Type.Uint256;
        types[5] = Type.Address;
        types[6] = Type.String;
        types[7] = Type.Int256;
        types[8] = Type.Bool;
        types[9] = Type.Bool;

        string[] memory result = abiDecode(types, abi.encode(1, abi.encodePacked(uint8(123)), address(3), "hello", 4, address(5), "world", -6, true, false));

        for (uint256 i = 0; i < result.length; i++) {
            console.log(result[i]);
        }
    }
}
