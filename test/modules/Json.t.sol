// SPDX-License-Identifier: MIT
pragma solidity >=0.8.13 <0.9.0;

import {Test} from "../../src/test.sol";
import {expect} from "src/test/Expect.sol";
import {json, JsonObject} from "src/test/Json.sol";
import {vulcan} from "src/test/Vulcan.sol";

contract JsonTest is Test {
    using vulcan for *;

    struct Foo {
        string foo;
    }

    function testParseImmutable() external {
        Foo memory obj = abi.decode(json.create('{"foo":"bar"}').unwrap().parse(), (Foo));
        expect(obj.foo).toEqual("bar");
    }

    function testParse() external {
        JsonObject memory jsonObject = json.create().set("foo", string("bar"));
        Foo memory obj = abi.decode(jsonObject.parse(), (Foo));
        expect(obj.foo).toEqual("bar");
    }

    function testIsValid() external {
        expect(json.isValid('{"foo":"bar"}')).toEqual(true);
        expect(json.isValid("{}")).toEqual(true);
        expect(json.isValid("[]")).toEqual(true);
        expect(json.isValid('{"foo":"bar"')).toEqual(false);
        expect(json.isValid('{"foo":bar"}')).toEqual(false);
        expect(json.isValid("asdfasf")).toEqual(false);
    }

    function testContainsKey() external {
        JsonObject memory obj = json.create('{"foo":"bar"}').unwrap();
        expect(obj.containsKey(".foo")).toEqual(true);
        expect(obj.containsKey(".bar")).toEqual(false);
    }

    function testGetMaxUint() external {
        uint256 i = json.create('{"foo":"0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff"}').unwrap()
            .getUint(".foo");
        expect(i).toEqual(type(uint256).max);
    }

    function testGetUint() external {
        expect(json.create('{"foo":123}').unwrap().getUint(".foo")).toEqual(123);
    }

    function testGetUintArray() external {
        uint256[] memory arr = json.create('{"foo":[123]}').unwrap().getUintArray(".foo");
        expect(arr.length).toEqual(1);
        expect(arr[0]).toEqual(123);
    }

    function testGetInt() external {
        expect(json.create('{"foo":-123}').unwrap().getInt(".foo")).toEqual(-123);
    }

    function testGetIntArray() external {
        int256[] memory arr = json.create('{"foo":[-123]}').unwrap().getIntArray(".foo");
        expect(arr.length).toEqual(1);
        expect(arr[0]).toEqual(-123);
    }

    function testGetBool() external {
        expect(json.create('{"foo":true}').unwrap().getBool(".foo")).toEqual(true);
    }

    function testGetBoolArray() external {
        bool[] memory arr = json.create('{"foo":[true]}').unwrap().getBoolArray(".foo");
        expect(arr.length).toEqual(1);
        expect(arr[0]).toEqual(true);
    }

    function testGetAddress() external {
        expect(json.create('{"foo":"0x0000000000000000000000000000000000000001"}').unwrap().getAddress(".foo")).toEqual(
            address(1)
        );
    }

    function testGetAddressArray() external {
        address[] memory arr =
            json.create('{"foo":["0x0000000000000000000000000000000000000001"]}').unwrap().getAddressArray(".foo");
        expect(arr.length).toEqual(1);
        expect(arr[0]).toEqual(address(1));
    }

    function testGetString() external {
        expect(json.create('{"foo":"bar"}').unwrap().getString(".foo")).toEqual("bar");
    }

    function testGetStringArray() external {
        string[] memory arr = json.create('{"foo":["bar"]}').unwrap().getStringArray(".foo");
        expect(arr.length).toEqual(1);
        expect(arr[0]).toEqual("bar");
    }

    function testGetBytes() external {
        expect(json.create('{"foo":"0x1234"}').unwrap().getBytes(".foo")).toEqual(hex"1234");
    }

    function testGetBytesArray() external {
        bytes[] memory arr = json.create('{"foo":["0x1234"]}').unwrap().getBytesArray(".foo");
        expect(arr.length).toEqual(1);
        expect(arr[0]).toEqual(hex"1234");
    }

    function testGetBytes32() external {
        expect(
            json.create('{"foo":"0x0000000000000000000000000000000000000000000000000000000000000001"}').unwrap()
                .getBytes32(".foo")
        ).toEqual(bytes32(uint256(1)));
    }

    function testGetBytes32Array() external {
        bytes32[] memory arr = json.create(
            '{"foo":["0x0000000000000000000000000000000000000000000000000000000000000001"]}'
        ).unwrap().getBytes32Array(".foo");
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

    function testGetKeys() external {
        JsonObject memory obj = json.create('{"foo": {"bar": "baz"}}').unwrap();

        string[] memory outerKeys = obj.getKeys();

        string[] memory innerKeys = obj.getKeys(".foo");

        expect(outerKeys[0]).toEqual("foo");
        expect(innerKeys[0]).toEqual("bar");
    }
}
