pragma solidity >=0.8.13 <0.9.0;

import {Test, expect, VulcanVm, console, json, JsonObject, vulcan, Watcher} from "../src/lib.sol";

contract JsonTest is Test {
    using vulcan for *;

    struct Foo {
        string foo;
    }

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
