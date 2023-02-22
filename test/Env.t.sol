pragma solidity >=0.8.13 <0.9.0;

import {Test, expect, console, json, vulcan, env} from "../src/test.sol";

contract EnvTest is Test {
    using vulcan for *;

    function testSet() external {
        env.set("foo", "123");
        expect(env.getString("foo")).toEqual("123");
        expect(env.getUint("foo")).toEqual(123);
    }

    function testGetters() external {
        env.set("foo", "bar");
        // expect(env.getString("foo")).toEqual("bar");
        // expect(env.getUint("foo")).toEqual(0);
        // expect(env.getBool("foo")).toEqual(false);
    }
}
