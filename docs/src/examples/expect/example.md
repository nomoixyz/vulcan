## Examples
### Use different matchers

Using the `expect` function and its different matchers

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, accounts, expect} from "vulcan/test.sol";

contract ExpectExample is Test {
    function test() external {
        expect(string("foo")).toEqual("foo");
        expect(string("foo")).not.toEqual("bar");
        expect(string("foo bar")).toContain("foo");
        expect(string("foo bar")).toContain("bar");

        expect(uint256(1)).toEqual(1);
        expect(uint256(1)).not.toEqual(0);
        expect(uint256(1)).toBeGreaterThan(0);
        expect(uint256(1)).toBeGreaterThanOrEqual(1);
        expect(uint256(0)).toBeLessThan(1);
        expect(uint256(0)).toBeLessThanOrEqual(0);

        address alice = accounts.create("Alice");
        address bob = accounts.create("Bob");
        expect(alice).toEqual(alice);
        expect(alice).not.toEqual(bob);

        expect(true).toBeTrue();
        expect(false).toBeFalse();
        expect((10 % 5) == 0).toBeTrue();
        expect((10 % 6) == 4).toBeTrue();
    }
}

```

