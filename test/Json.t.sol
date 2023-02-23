pragma solidity >=0.8.13 <0.9.0;

import {Test, expect, console, json, JsonObject, vulcan} from "../src/test.sol";

contract JsonTest is Test {
    using vulcan for *;

    struct Foo {
        string foo;
    }

    // function testCreate() external {
    //     JsonObject memory obj = json.create('{"foo":"bar"}');
    //     expect(obj.serialized).toEqual('{"foo":"bar"}');

    //     obj.serialize("hello", string("world"));
    //     // TODO: should parseString receive the actual struct?
    //     expect(json.parseString(obj.serialized, ".foo")).toEqual("bar");
    //     expect(json.parseString(obj.serialized, ".hello")).toEqual("world");
    // }

    function testParseObject() external {
        string memory jsonStr = '{"foo":"bar"}';
        Foo memory obj = abi.decode(json.parseObject(jsonStr), (Foo));
        expect(obj.foo).toEqual("bar");
    }

    function testParseObjectStruct() external {
        JsonObject memory jsonObject = json.create().serialize("foo", string("bar"));
        Foo memory obj = abi.decode(json.parseObject(jsonObject), (Foo));
        expect(obj.foo).toEqual("bar");
    }

    function testParseUint() external {
        expect(json.parseUint('{"foo":123}', ".foo")).toEqual(123);
    }

    function testParseUintArray() external {
        uint256[] memory arr = json.parseUintArray('{"foo":[123]}', ".foo");
        expect(arr.length).toEqual(1);
        expect(arr[0]).toEqual(123);
    }

    function testParseInt() external {
        expect(json.parseInt('{"foo":-123}', ".foo")).toEqual(-123);
    }

    function testParseIntArray() external {
        int256[] memory arr = json.parseIntArray('{"foo":[-123]}', ".foo");
        expect(arr.length).toEqual(1);
        expect(arr[0]).toEqual(-123);
    }

    function testParseBool() external {
        expect(json.parseBool('{"foo":true}', ".foo")).toEqual(true);
    }

    function testParseBoolArray() external {
        bool[] memory arr = json.parseBoolArray('{"foo":[true]}', ".foo");
        expect(arr.length).toEqual(1);
        expect(arr[0]).toEqual(true);
    }

    function testParseAddress() external {
        expect(json.parseAddress('{"foo":"0x0000000000000000000000000000000000000001"}', ".foo")).toEqual(address(1));
    }

    function testParseAddressArray() external {
        address[] memory arr = json.parseAddressArray('{"foo":["0x0000000000000000000000000000000000000001"]}', ".foo");
        expect(arr.length).toEqual(1);
        expect(arr[0]).toEqual(address(1));
    }

    function testParseString() external {
        expect(json.parseString('{"foo":"bar"}', ".foo")).toEqual("bar");
    }

    function testParseStringArray() external {
        string[] memory arr = json.parseStringArray('{"foo":["bar"]}', ".foo");
        expect(arr.length).toEqual(1);
        expect(arr[0]).toEqual("bar");
    }

    function testParseBytes() external {
        expect(json.parseBytes('{"foo":"0x1234"}', ".foo")).toEqual(hex"1234");
    }

    function testParseBytesArray() external {
        bytes[] memory arr = json.parseBytesArray('{"foo":["0x1234"]}', ".foo");
        expect(arr.length).toEqual(1);
        expect(arr[0]).toEqual(hex"1234");
    }

    function testParseBytes32() external {
        expect(
            json.parseBytes32('{"foo":"0x0000000000000000000000000000000000000000000000000000000000000001"}', ".foo")
        ).toEqual(bytes32(uint256(1)));
    }

    function testParseBytes32Array() external {
        bytes32[] memory arr = json.parseBytes32Array(
            '{"foo":["0x0000000000000000000000000000000000000000000000000000000000000001"]}', ".foo"
        );
        expect(arr.length).toEqual(1);
        expect(arr[0]).toEqual(bytes32(uint256(1)));
    }

    function testSerializeBool() external {
        JsonObject memory obj = json.create();
        obj.serialize("foo", true);
        expect(obj.serialized).toEqual('{"foo":true}');
    }

    function testSerializeUint() external {
        JsonObject memory obj = json.create();
        obj.serialize("foo", uint256(123));
        expect(obj.serialized).toEqual('{"foo":123}');
    }

    function testSerializeInt() external {
        JsonObject memory obj = json.create();
        obj.serialize("foo", int256(-123));
        expect(obj.serialized).toEqual('{"foo":-123}');
    }

    function testSerializeAddress() external {
        JsonObject memory obj = json.create();
        obj.serialize("foo", address(1));
        expect(obj.serialized).toEqual('{"foo":"0x0000000000000000000000000000000000000001"}');
    }

    function testSerializeBytes32() external {
        JsonObject memory obj = json.create();
        obj.serialize("foo", bytes32(uint256(1)));
        expect(obj.serialized).toEqual('{"foo":"0x0000000000000000000000000000000000000000000000000000000000000001"}');
    }

    function testSerializeString() external {
        JsonObject memory obj = json.create();
        obj.serialize("foo", string("bar"));
        expect(obj.serialized).toEqual('{"foo":"bar"}');
    }

    function testSerializeBytes() external {
        JsonObject memory obj = json.create();
        obj.serialize("foo", abi.encodePacked(uint256(1)));
        expect(obj.serialized).toEqual('{"foo":"0x0000000000000000000000000000000000000000000000000000000000000001"}');
    }
}
