## Examples
### How to use forks

How to use forks. This example assumes there is a JSON RPC server running at `localhost:8545`

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, expect, vulcan} from "vulcan/test.sol";
import {forks, Fork} from "vulcan/test/Forks.sol";
import {ctx} from "vulcan/test/Context.sol";

contract ForksExample is Test {
    string constant RPC_URL = "http://localhost:8545";

    function test() external {
        forks.create(RPC_URL).select();

        expect(block.chainid).toEqual(31337);
    }
}

```

