## Examples
### Log values

Use the `console` function to log values.

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, expect, console} from "vulcan/test.sol";

contract ConsoleExample is Test {
    function test() external pure {
        string memory foo = "foo";
        string memory bar = "bar";

        uint256 oneTwoThree = 123;
        uint256 threeTwoOne = 321;

        bool isTrue = true;

        console.log(foo);
        console.log(foo, bar);
        console.log(foo, bar, threeTwoOne);
        console.log(foo, bar, threeTwoOne, isTrue);
        console.log(threeTwoOne, oneTwoThree);
        console.log(threeTwoOne + oneTwoThree);
        console.log(1 > 0);
    }
}

```

