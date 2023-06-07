# Utils

This module provides a set of utility functions that make use of other modules in Vulcan.

```solidity
import {Test, expect, println, format} from "vulcan/test.sol";

contract TestMyContract is Test {
    function testUtils() external {
        // Print a string
        println("Hello world!");

        // Print a formatted string - see Format module for more details
        println("Hello {string}!", abi.encode("world"));

        // Format a string
        expect(format("Hello {string}!", abi.encode("world"))).toEqual("Hello world!");
    }
}
```