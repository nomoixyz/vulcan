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

### broadcast


```solidity
function broadcast() internal;
```

### broadcast


```solidity
function broadcast(address from) internal;
```

### broadcast


```solidity
function broadcast(uint256 privKey) internal;
```

### startBroadcast


```solidity
function startBroadcast() internal;
```

### startBroadcast


```solidity
function startBroadcast(address from) internal;
```

### startBroadcast


```solidity
function startBroadcast(uint256 privKey) internal;
```

### stopBroadcast


```solidity
function stopBroadcast() internal;
```

### assume


```solidity
function assume(bool condition) internal pure;
```

### pauseGasMetering


```solidity
function pauseGasMetering() internal;
```

### resumeGasMetering


```solidity
function resumeGasMetering() internal;
```

### isStaticcall

*Checks whether the current call is a static call or not.*


```solidity
function isStaticcall() internal view returns (bool);
```
**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`bool`|True if the current call is a static call, false otherwise.|


### setBlockTimestamp

*sets the `block.timestamp` to `ts`*


```solidity
function setBlockTimestamp(Context self, uint256 ts) internal returns (Context);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`self`|`Context`||
|`ts`|`uint256`|the new block timestamp|


### setBlockTimestamp

*sets the `block.timestamp` to `ts`*


```solidity
function setBlockTimestamp(uint256 ts) internal returns (Context);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`ts`|`uint256`|the new block timestamp|


### setBlockNumber

*sets the `block.number` to `blockNumber`*


```solidity
function setBlockNumber(Context self, uint256 blockNumber) internal returns (Context);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`self`|`Context`||
|`blockNumber`|`uint256`|the new block number|


### setBlockNumber

*sets the `block.number` to `blockNumber`*


```solidity
function setBlockNumber(uint256 blockNumber) internal returns (Context);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`blockNumber`|`uint256`|the new block number|


### setBlockBaseFee

*sets the `block.basefee` to `baseFee`*


```solidity
function setBlockBaseFee(Context self, uint256 baseFee) internal returns (Context);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`self`|`Context`||
|`baseFee`|`uint256`|the new block base fee|


### setBlockBaseFee

*sets the `block.basefee` to `baseFee`*


```solidity
function setBlockBaseFee(uint256 baseFee) internal returns (Context);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`baseFee`|`uint256`|the new block base fee|


### setBlockDifficulty

*sets the `block.difficulty` to `difficulty`*


```solidity
function setBlockDifficulty(Context self, uint256 difficulty) internal returns (Context);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`self`|`Context`||
|`difficulty`|`uint256`|the new block difficulty|


### setBlockDifficulty

*sets the `block.difficulty` to `difficulty`*


```solidity
function setBlockDifficulty(uint256 difficulty) internal returns (Context);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`difficulty`|`uint256`|the new block difficulty|


### setChainId

*sets the `block.chainid` to `chainId`*


```solidity
function setChainId(Context self, uint64 chainId) internal returns (Context);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`self`|`Context`||
|`chainId`|`uint64`|the new block chain id|


### setChainId

*sets the `block.chainid` to `chainId`*


```solidity
function setChainId(uint64 chainId) internal returns (Context);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`chainId`|`uint64`|the new block chain id|


### setBlockCoinbase

*Sets the block coinbase to `who`.*


```solidity
function setBlockCoinbase(Context self, address who) internal returns (Context);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`self`|`Context`|The context.|
|`who`|`address`|The address to set as the block coinbase.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`Context`|The same context in order to allow function chaining.|


### setBlockCoinbase

*Sets the block coinbase to `who`.*


```solidity
function setBlockCoinbase(address who) internal returns (Context);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`who`|`address`|The address to set as the block coinbase.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`Context`|The same context to allow function chaining.|


### expectRevert

*Function used to check whether the next call reverts or not.*


```solidity
function expectRevert(bytes memory revertData) internal;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`revertData`|`bytes`|The function call data that that is expected to fail.|


### expectRevert

*Function used to check whether the next call reverts or not.*


```solidity
function expectRevert(bytes4 revertData) internal;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`revertData`|`bytes4`|The function call signature that that is expected to fail.|


### expectRevert

*Function used to check whether the next call reverts or not.*


```solidity
function expectRevert() internal;
```

### expectEmit

*Checks if an event was emitted with the given properties.*


```solidity
function expectEmit(bool checkTopic1, bool checkTopic2, bool checkTopic3, bool checkData) internal;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`checkTopic1`|`bool`|Whether to check the first topic match.|
|`checkTopic2`|`bool`|Whether to check the second topic match.|
|`checkTopic3`|`bool`|Whether to check the third topic match.|
|`checkData`|`bool`|Whether to check the data field match.|


### expectEmit

*Checks if an event was emitted with the given properties.*


```solidity
function expectEmit(bool checkTopic1, bool checkTopic2, bool checkTopic3, bool checkData, address emitter) internal;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`checkTopic1`|`bool`|Whether to check the first topic match.|
|`checkTopic2`|`bool`|Whether to check the second topic match.|
|`checkTopic3`|`bool`|Whether to check the third topic match.|
|`checkData`|`bool`|Whether to check the data field match.|
|`emitter`|`address`|The address of the expected emitter.|


### mockCall

*Function to mock a call to a specified address.*


```solidity
function mockCall(address callee, bytes memory data, bytes memory returnData) internal;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`callee`|`address`|The address for which the call should be mocked.|
|`data`|`bytes`|The data for which the call should be mocked.|
|`returnData`|`bytes`|The data that should be returned if `data` matches the provided call data.|


### mockCall

*Function to mock a call to a specified address.*


```solidity
function mockCall(address callee, uint256 msgValue, bytes memory data, bytes memory returnData) internal;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`callee`|`address`|The address for which the call should be mocked.|
|`msgValue`|`uint256`|The `msg.value` for which the call should be mocked.|
|`data`|`bytes`|The data for which the call should be mocked.|
|`returnData`|`bytes`|The data that should be returned if `data` matches the provided call data.|


### clearMockedCalls

*Function to clear all the mocked calls.*


```solidity
function clearMockedCalls() internal;
```

### expectCall

*Used to check if a call to `callee` with `data` was made.*


```solidity
function expectCall(address callee, bytes memory data) internal;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`callee`|`address`|The address that is expected to be called.|
|`data`|`bytes`|The call data that is expected to be used.|


### expectCall

*Used to check if a call to `callee` with `data` and `msgValue` was made.*


```solidity
function expectCall(address callee, uint256 msgValue, bytes memory data) internal;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`callee`|`address`|The address that is expected to be called.|
|`msgValue`|`uint256`|The `msg.value` that is expected to be sent.|
|`data`|`bytes`|The call data that is expected to be used.|


### snapshot

*Takes a snapshot of the current state of the vm and returns an identifier.*


```solidity
function snapshot(Context) internal returns (uint256);
```
**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`uint256`|The snapshot identifier.|


### snapshot

*Takes a snapshot of the current state of the vm and returns an identifier.*


```solidity
function snapshot() internal returns (uint256);
```
**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`uint256`|The snapshot identifier.|


### revertToSnapshot

*Reverts the state of the vm to the snapshot with id `snapshotId`.*


```solidity
function revertToSnapshot(Context, uint256 snapshotId) internal returns (bool);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`Context`||
|`snapshotId`|`uint256`|The id of the snapshot to revert to.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`bool`|true if the vm was reverted to the selected snapshot.|


### revertToSnapshot

*Reverts the state of the vm to the snapshot with id `snapshotId`.*


```solidity
function revertToSnapshot(uint256 snapshotId) internal returns (bool);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`snapshotId`|`uint256`|The id of the snapshot to revert to.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`bool`|true if the vm was reverted to the selected snapshot.|


