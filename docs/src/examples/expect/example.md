## Examples
### Use different matchers

Using the `expect` function and its different matchers

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, expect} from "vulcan/test.sol";

contract ExpectExample is Test {
    function test() external {
        expect(string("foo")).toEqual(string("foo"));
        expect(string("foo")).not.toEqual(string("bar"));
        expect(string("foo bar")).toContain(string("foo"));
        expect(string("foo bar")).toContain(string("bar"));

        expect(uint256(1)).toEqual(uint256(1));
        expect(uint256(1)).not.toEqual(uint256(0));
        expect(uint256(1)).toBeGreaterThan(uint256(0));
        expect(uint256(1)).toBeGreaterThanOrEqual(uint256(1));
        expect(uint256(0)).toBeLessThan(uint256(1));
        expect(uint256(0)).toBeLessThanOrEqual(uint256(0));

        expect(address(1)).toEqual(address(1));
        expect(address(1)).not.toEqual(address(0));

        expect(true).toBeTrue();
        expect(false).toBeFalse();
        expect((10 % 5) == 0).toBeTrue();
        expect((10 % 6) == 4).toBeTrue();
    }
}

```

