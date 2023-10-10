## Examples
### Measuring gas

Obtain the gas cost of a operation

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, expect, gas} from "vulcan/test.sol";

contract GasExample is Test {
    function test() external {
        // Start recording gas usage
        gas.record("example");

        payable(0).transfer(1e18);

        // Stop recording and obtain the amount of gas used
        uint256 used = gas.stopRecord("example");

        expect(used).toBeGreaterThan(0);
    }
}

```

