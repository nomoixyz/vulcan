pragma solidity >=0.8.13 <0.9.0;

import {Test, expect, strings, console} from "../src/test.sol";

contract StringsTest is Test {
    using strings for *;

    function testItCanTransformAddressToString() external {
        address addr = address(1);

        expect(addr.toString()).toEqual(string("0x0000000000000000000000000000000000000001"));
    }

    function testItCanTransformBytesToString() external {
        bytes memory value = abi.encode(uint256(1));

        expect(value.toString()).toEqual(string("0x0000000000000000000000000000000000000000000000000000000000000001"));
    }

    function testItCanTransformBytes32ToString() external {
        bytes32 value = bytes32(uint256(1));

        expect(value.toString()).toEqual(string("0x0000000000000000000000000000000000000000000000000000000000000001"));
    }

    function testItCanTransformBoolToString() external {
        expect(true.toString()).toEqual(string("true"));
        expect(false.toString()).toEqual(string("false"));
    }

    function testItCanTransformUintToString() external {
        expect(uint256(1337).toString()).toEqual("1337");
    }

    function testItCanTransformIntToString() external {
        expect(int256(-1).toString()).toEqual("-1");
        expect(int256(1).toString()).toEqual("1");
    }

    function testItCanParseBytes() external {
        string memory value = "0x0000000000000000000000000000000000000000000000000000000000000002";

        expect(value.parseBytes()).toEqual(abi.encode(uint256(2)));
    }

    function testItCanParseAddress() external {
        string memory value = "0x0000000000000000000000000000000000000001";

        expect(value.parseAddress()).toEqual(address(1));
    }

    function testItCanParseUint() external {
        string memory value = "1337";

        expect(value.parseUint()).toEqual(uint256(1337));
    }

    function testItCanParseInt() external {
        string memory value = "-1";

        expect(value.parseInt()).toEqual(int256(-1));
    }

    function testItCanParseBytes32() external {
        string memory value = "0x0000000000000000000000000000000000000000000000000000000000000003";

        expect(value.parseBytes32()).toEqual(bytes32(uint256(3)));
    }

    function testItCanParseBool() external {
        string memory value = "true";

        expect(value.parseBool()).toBeTrue();

        value = "false";

        expect(value.parseBool()).toBeFalse();
    }
}
