# Context

Functionality to interact with the current runtime context:
- Block data
- Gas metering
- Forge's `expectRevert`, `expectEmit` and `mockCall` (for an alternative, see
  [`watchers`](./watchers.md))
- Vm state snapshots

```solidity
import { Test, ctx } from "vulcan/test.sol";

contract TestMyContract is Test {
    function testMyContract() external {
        // Update block state
        ctx.setBlockTimestamp(123).setBlockNumber(456).setBlockDifficulty(789);

        // Use snapshots
        uint256 snapshotId = ctx.snapshot();
        ctx.revertToSnapshot(snapshotId);

        // Enable/disable gas metering
        ctx.pauseGasMetering();
        ctx.resumeGasMetering();

        // Use Forge's `expectRevert`
        ctx.expectRevert();
        myContract.mayRevert();
    }
}
```
