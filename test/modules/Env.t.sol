// SPDX-License-Identifier: MIT
pragma solidity >=0.8.13 <0.9.0;

import {Test} from "../../src/test.sol";
import {expect} from "src/test/Expect.sol";
import {json} from "src/test/Json.sol";
import {vulcan} from "src/test/Vulcan.sol";
import {env} from "src/test/Env.sol";

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
