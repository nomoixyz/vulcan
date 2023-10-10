## Examples
### How to compile `fe` code

How to compile `fe` using the `fe` module (Requires to have `fe` installed)

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, expect, fe, Fe} from "vulcan/test.sol";

contract FeExample is Test {
    function test() external {
        Fe memory feCmd = fe.create().setFilePath("./test/mocks/guest_book.fe").setOverwrite(true);

        feCmd.build().unwrap();

        string memory expectedBytecode = "600180600c6000396000f3fe00";

        expect(string(feCmd.getBytecode("A").toValue())).toEqual(expectedBytecode);
    }
}

```

