# Forks

Forking functionality.

```solidity
import { Test, forks, Fork } from "vulcan/test.sol";

contract TestMyContract is Test {
    function testMyContract() external {
        // Alternatively an endpoint can be passed directly.
        Fork fork = forks.create("mainnet");

        // The fork can be created at an specific block
        fork = forks.createAtBlock("mainnet", 16736036);

        // Or right before a transaction
        fork = forks.createBeforeTx("mainnet", 0x9cad524afce3fcd2e84b8ac30c57ba085fcae053e9bf3ee449cd36d511c10f43);
    }
}
```
[**Forks API reference**](../reference/modules/forks.md)
