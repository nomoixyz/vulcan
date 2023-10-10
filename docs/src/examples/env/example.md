## Examples
### Set and get environment variables

Use the `env` module to set and read environment variables

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, expect, env} from "vulcan/test.sol";

contract EnvExample is Test {
    function test() external {
        env.set("SomeString", "foo");
        env.set("SomeUint", "100000000000000000000000");
        env.set("SomeBool", "true");
        env.set("SomeArray", "1,2,3,4");

        expect(env.getString("SomeString")).toEqual("foo");
        expect(env.getUint("SomeUint")).toEqual(100_000_000_000_000_000_000_000);
        expect(env.getBool("SomeBool")).toBeTrue();
        expect(env.getUintArray("SomeArray", ",")[0]).toEqual(1);
        expect(env.getUintArray("SomeArray", ",")[1]).toEqual(2);
        expect(env.getUintArray("SomeArray", ",")[2]).toEqual(3);
        expect(env.getUintArray("SomeArray", ",")[3]).toEqual(4);
    }
}

```

