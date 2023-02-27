# Context

Functionality to interact with the current runtime context:
- Block data
- Gas metering
- Forge's `expectRevert`, `expectEmit` and `mockCall` (for an alternative, see `watchers`)
- Vm state snapshots

```solidity
import { Test, ctx } from "vulcan/test.sol";

contract TestMyContract is Test {
    function testMyContract() external {
        ctx.setBlockTimestamp(123).setBlockNumber(456).setBlockDifficulty(789);

        uint256 snapshotId = ctx.snapshot();
        ctx.revertToSnapshot(snapshotId);
    }
}
```
