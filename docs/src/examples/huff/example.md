## Examples
### How to compile `huff` code

How to compile `huff` code using the `huff` module (Requires to have `huff` installed)

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, expect, huff, CommandOutput} from "vulcan/test.sol";

contract HuffExample is Test {
    function test() external {
        CommandOutput memory result = huff.create().setFilePath("./test/mocks/Getter.huff").compile().unwrap();
        expect(result.stdout.length).toBeGreaterThan(0);
    }
}

```

