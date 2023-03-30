//// SPDX-License-Identifier: MIT
pragma solidity >=0.8.13 <0.9.0;

import {Test, expect, config, Rpc, console} from "../src/test.sol";
import {abiDecode, Type, parseTemplate, Placeholder, _format, format} from "../src/Printf.sol";

contract PrintfTest is Test {
    function testFormatParser() external {
        string memory template = "{address} {string}";

        Placeholder[] memory result = parseTemplate(template);

        expect(uint256(result[0].t)).toEqual(uint256(Type.Address));
        expect(uint256(result[1].t)).toEqual(uint256(Type.String));
    }

    function testInternalFormat() external {
        string memory template = "{address} hello {string} world {bool}";
        Placeholder[] memory placeholders = new Placeholder[](3);
        placeholders[0] = Placeholder(0, 9, Type.Address); // 9
        placeholders[1] = Placeholder(16, 24, Type.String); // 8
        placeholders[2] = Placeholder(31, 37, Type.Bool); // 6
        string[] memory decoded = new string[](3);
        decoded[0] = "test";
        decoded[1] = "test";
        decoded[2] = "test";
        string memory result = _format(template, decoded, placeholders);
        expect(result).toEqual("test hello test world test");
    }

    function testFormat() external {
        string memory template = "{address} hello {string} world {bool}";
        string memory result = format(template, abi.encode(address(123), "foo", true));

        
        expect(result).toEqual("0x000000000000000000000000000000000000007B hello foo world true");
    }
}
