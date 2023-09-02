pragma solidity >=0.8.13 <0.9.0;

import {Test, expect, println, json, JsonObject, vulcan} from "../../src/test.sol";

contract JsonTest is Test {
    using vulcan for *;

    struct Foo {
        string foo;
    }

    function testParseImmutable() external {
        Foo memory obj = abi.decode(json.create('{"foo":"bar"}').parse(), (Foo));
        expect(obj.foo).toEqual("bar");
    }

    function testParse() external {
        JsonObject memory jsonObject = json.create().set("foo", string("bar")).unwrap();
        Foo memory obj = abi.decode(jsonObject.parse(), (Foo));
        expect(obj.foo).toEqual("bar");
    }

    function testGetUint() external {
        expect(json.create('{"foo":123}').getUint(".foo")).toEqual(123);
    }

    function testGetUintArray() external {
        uint256[] memory arr = json.create('{"foo":[123]}').getUintArray(".foo");
        expect(arr.length).toEqual(1);
        expect(arr[0]).toEqual(123);
    }

    function testGetInt() external {
        expect(json.create('{"foo":-123}').getInt(".foo")).toEqual(-123);
    }

    function testGetIntArray() external {
        int256[] memory arr = json.create('{"foo":[-123]}').getIntArray(".foo");
        expect(arr.length).toEqual(1);
        expect(arr[0]).toEqual(-123);
    }

    function testGetBool() external {
        expect(json.create('{"foo":true}').getBool(".foo")).toEqual(true);
    }

    function testGetBoolArray() external {
        bool[] memory arr = json.create('{"foo":[true]}').getBoolArray(".foo");
        expect(arr.length).toEqual(1);
        expect(arr[0]).toEqual(true);
    }

    function testGetAddress() external {
        expect(json.create('{"foo":"0x0000000000000000000000000000000000000001"}').getAddress(".foo")).toEqual(
            address(1)
        );
    }

    function testGetAddressArray() external {
        address[] memory arr =
            json.create('{"foo":["0x0000000000000000000000000000000000000001"]}').getAddressArray(".foo");
        expect(arr.length).toEqual(1);
        expect(arr[0]).toEqual(address(1));
    }

    function testGetString() external {
        expect(json.create('{"foo":"bar"}').getString(".foo")).toEqual("bar");
    }

    function testGetStringArray() external {
        string[] memory arr = json.create('{"foo":["bar"]}').getStringArray(".foo");
        expect(arr.length).toEqual(1);
        expect(arr[0]).toEqual("bar");
    }

    function testGetBytes() external {
        expect(json.create('{"foo":"0x1234"}').getBytes(".foo")).toEqual(hex"1234");
    }

    function testGetBytesArray() external {
        bytes[] memory arr = json.create('{"foo":["0x1234"]}').getBytesArray(".foo");
        expect(arr.length).toEqual(1);
        expect(arr[0]).toEqual(hex"1234");
    }

    function testGetBytes32() external {
        expect(
            json.create('{"foo":"0x0000000000000000000000000000000000000000000000000000000000000001"}').getBytes32(
                ".foo"
            )
        ).toEqual(bytes32(uint256(1)));
    }

    function testGetBytes32Array() external {
        bytes32[] memory arr = json.create(
            '{"foo":["0x0000000000000000000000000000000000000000000000000000000000000001"]}'
        ).getBytes32Array(".foo");
        expect(arr.length).toEqual(1);
        expect(arr[0]).toEqual(bytes32(uint256(1)));
    }

    function testSetBool() external {
        JsonObject memory obj = json.create();
        obj.set("foo", true);
        expect(obj.serialized).toEqual('{"foo":true}');
    }

    function testSetUint() external {
        JsonObject memory obj = json.create();
        obj.set("foo", uint256(123));
        expect(obj.serialized).toEqual('{"foo":123}');
    }

    function testSetInt() external {
        JsonObject memory obj = json.create();
        obj.set("foo", int256(-123));
        expect(obj.serialized).toEqual('{"foo":-123}');
    }

    function testSetAddress() external {
        JsonObject memory obj = json.create();
        obj.set("foo", address(1));
        expect(obj.serialized).toEqual('{"foo":"0x0000000000000000000000000000000000000001"}');
    }

    function testSetBytes32() external {
        JsonObject memory obj = json.create();
        obj.set("foo", bytes32(uint256(1)));
        expect(obj.serialized).toEqual('{"foo":"0x0000000000000000000000000000000000000000000000000000000000000001"}');
    }

    function testSetString() external {
        JsonObject memory obj = json.create();
        obj.set("foo", string("bar"));
        expect(obj.serialized).toEqual('{"foo":"bar"}');
    }

    function testSetBytes() external {
        JsonObject memory obj = json.create();
        obj.set("foo", abi.encodePacked(uint256(1)));
        expect(obj.serialized).toEqual('{"foo":"0x0000000000000000000000000000000000000000000000000000000000000001"}');
    }

    function testSetObject() external {
        JsonObject memory a = json.create();
        JsonObject memory b = json.create();
        a.set("foo", abi.encodePacked(uint256(1)));
        b.set("bar", a);
        expect(b.serialized).toEqual(
            '{"bar":{"foo":"0x0000000000000000000000000000000000000000000000000000000000000001"}}'
        );
    }
}
