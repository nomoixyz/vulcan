# Context

This module includes functions to modify the test or script context.

## Example usage

```solidity
import {Test, expect, ctx} from "vulcan/test.sol";

contract ExampleTest is Test {
    function testFooBar() external {
        // We need to update the block timestamp and number
        ctx
            .setBlockTimestamp(1677680867)
            .setBlockNumber(16734349);

        // Now we need to go one hour into the future and change the chain id
        ctx
            .setBlockTimestamp(block.timestamp + 3600) // 1677680867 + 3600
            .setChainId(1337);
    }
}
```
