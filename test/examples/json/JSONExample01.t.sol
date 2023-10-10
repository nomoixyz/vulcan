// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, expect, json, JsonObject} from "vulcan/test.sol";

/// @title Work with JSON objects
/// @dev Create a JSON object, populate it and read it
contract JSONExample is Test {
    function test() external {
        // Create an empty JsonObject
        JsonObject memory obj = json.create();

        string memory key = "foo";
        string memory value = "bar";

        obj.set(key, value);

        expect(obj.getString(".foo")).toEqual(value);

        // Create a populated JsonObject
        obj = json.create("{ \"foo\": { \"bar\": \"baz\" } }").unwrap();

        expect(obj.getString(".foo.bar")).toEqual("baz");
    }
}
