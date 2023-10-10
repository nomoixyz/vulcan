## Examples
### Using println

Using the println function to log formatted data

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, expect, println} from "vulcan/test.sol";

contract UtilsExample is Test {
    function test() external view {
        println("Log a simple string");

        string memory someString = "someString";
        println("This is a string: {s}", abi.encode(someString));

        uint256 aNumber = 123;
        println("This is a uint256: {u}", abi.encode(aNumber));

        println("A string: {s} and a number: {u}", abi.encode(someString, aNumber));
    }
}

```

### Using format

Using the format function to format data

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, expect, format} from "vulcan/test.sol";

contract FormatExample is Test {
    function test() external {
        uint256 uno = 1;

        string memory formatted = format("is {u} greater than 0? {bool}", abi.encode(uno, uno > 0));

        expect(formatted).toEqual("is 1 greater than 0? true");
    }
}

```

