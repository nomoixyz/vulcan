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

## `broadcast()`

## `broadcast(from)`

## `broadcast(privKey)`

## `startBroadcast()`

## `startBroadcast(from)`

## `startBroadcast(privKey)`

## `assume(condition)`

## `pauseGasMetering()`

## `resumeGasMetering()`

## `isStaticcall()`

## `setBlockTimestamp(ctx, timestamp)`
## `setBlockTimestamp(timestamp)`


## `setBlockNumber(ctx, blockNumber)`
## `setBlockNumber(blockNumber)`


## `setBlockBaseFee(ctx, baseFee)`
## `setBlockBaseFee(baseFee)`

## `setBlockDifficulty(ctx, difficulty)`
## `setBlockDifficulty(difficulty)`

## `setChainId(ctx, chainId)`
## `setChainId(chainId)`

## `setBlockCoinbase(ctx, coinbase)`
## `setBlockCoinbase(coinbase)`

## `expectRevert()`

## `expectEmit(checkTopic1, checkTopic2, checkTopic3, checkData, emitter?)`

## `mockCall(callee, data, returnData)`
## `mockCall(callee, msgValue, data, returnData)`

## `clearMockedCalls()`

## `expectCall(callee, data)`

## `expectCall(callee, msgValue, data)`

## `snapshot(ctx?)`

## `revertToSnapshot(ctx, snapshotId)`
## `revertToSnapshot(snapshotId)`
