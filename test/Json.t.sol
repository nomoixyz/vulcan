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
        JsonObject memory jsonObject = json.create('{"foo":"bar"}');
        Foo memory obj = abi.decode(json.parseObject(jsonObject), (Foo));
        expect(obj.foo).toEqual("bar");
    }

    function testSerializeString() external {
        JsonObject memory obj = json.create();
        obj.serialize("foo", string("bar"));
        expect(obj.serialized).toEqual('{"foo":"bar"}');
    }
}
