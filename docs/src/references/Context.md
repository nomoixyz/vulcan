# Context

## Custom types

### Context

```solidity
type Context is bytes32;
```



## ctxSafe



### **broadcast()**



### **broadcast(address from)**



### **broadcast(uint256 privKey)**



### **startBroadcast()**



### **startBroadcast(address from)**



### **startBroadcast(uint256 privKey)**



### **stopBroadcast()**



### **assume(bool condition)**



### **pauseGasMetering()**



### **resumeGasMetering()**



### **startGasReport(string name)**



### **endGasReport()**



## ctxUnsafe



### **init()**

Function to initialize and set the code of `CALL_CONTEXT_ADDRESS`.

### **broadcast()**



### **broadcast(address from)**



### **broadcast(uint256 privKey)**



### **startBroadcast()**



### **startBroadcast(address from)**



### **startBroadcast(uint256 privKey)**



### **stopBroadcast()**



### **assume(bool condition)**



### **pauseGasMetering()**



### **resumeGasMetering()**



### **startGasReport(string name)**



### **endGasReport()**



### **isStaticcall() &rarr; (bool)**

Checks whether the current call is a static call or not.

### **setBlockTimestamp(Context self, uint256 ts) &rarr; (Context)**

sets the `block.timestamp` to `ts`

### **setBlockTimestamp(uint256 ts) &rarr; (Context)**

sets the `block.timestamp` to `ts`

### **setBlockNumber(Context self, uint256 blockNumber) &rarr; (Context)**

sets the `block.number` to `blockNumber`

### **setBlockNumber(uint256 blockNumber) &rarr; (Context)**

sets the `block.number` to `blockNumber`

### **setBlockBaseFee(Context self, uint256 baseFee) &rarr; (Context)**

sets the `block.basefee` to `baseFee`

### **setBlockBaseFee(uint256 baseFee) &rarr; (Context)**

sets the `block.basefee` to `baseFee`

### **setBlockPrevrandao(Context self, bytes32 newPrevrandao) &rarr; (Context)**

Sets block.prevrandao.

### **setBlockPrevrandao(bytes32 newPrevrandao) &rarr; (Context)**

Sets block.prevrandao.

### **setChainId(Context self, uint64 chainId) &rarr; (Context)**

sets the `block.chainid` to `chainId`

### **setChainId(uint64 chainId) &rarr; (Context)**

sets the `block.chainid` to `chainId`

### **setBlockCoinbase(Context self, address who) &rarr; (Context)**

Sets the block coinbase to `who`.

### **setBlockCoinbase(address who) &rarr; (Context)**

Sets the block coinbase to `who`.

### **setGasPrice(Context self, uint256 newGasPrice) &rarr; (Context)**

Sets the transaction gas price.

### **setGasPrice(uint256 newGasPrice) &rarr; (Context)**

Sets the transaction gas price.

### **expectRevert(bytes revertData)**

Function used to check whether the next call reverts or not.

### **expectRevert(bytes4 revertData)**

Function used to check whether the next call reverts or not.

### **expectRevert()**

Function used to check whether the next call reverts or not.

### **expectEmit(bool checkTopic1, bool checkTopic2, bool checkTopic3, bool checkData)**

Checks if an event was emitted with the given properties.

### **expectEmit(bool checkTopic1, bool checkTopic2, bool checkTopic3, bool checkData, address emitter)**

Checks if an event was emitted with the given properties.

### **mockCall(address callee, bytes data, bytes returnData)**

Function to mock a call to a specified address.

### **mockCall(address callee, uint256 msgValue, bytes data, bytes returnData)**

Function to mock a call to a specified address.

### **clearMockedCalls()**

Function to clear all the mocked calls.

### **expectCall(address callee, bytes data)**

Used to check if a call to `callee` with `data` was made.

### **expectCall(address callee, uint256 msgValue, bytes data)**

Used to check if a call to `callee` with `data` and `msgValue` was made.

### **expectCallMinGas(address callee, uint256 msgValue, uint64 minGas, bytes data)**

Expect a call to an address with the specified msg.value and calldata, and a minimum amount of gas.

### **expectCallMinGas(address callee, uint256 msgValue, uint64 minGas, bytes data, uint64 count)**

Expect a number call to an address with the specified msg.value and calldata, and a minimum amount of gas.

### **expectSafeMemory(uint64 min, uint64 max)**

Allows to  write on memory only between [0x00, 0x60) and [min, max) in the current.
subcontext.

### **expectsafememorycall(uint64 min, uint64 max)**

Allows to  write on memory only between [0x00, 0x60) and [min, max) in the next

### **snapshot(Context) &rarr; (uint256)**

Takes a snapshot of the current state of the vm and returns an identifier.

### **snapshot() &rarr; (uint256)**

Takes a snapshot of the current state of the vm and returns an identifier.

### **revertToSnapshot(Context, uint256 snapshotId) &rarr; (bool)**

Reverts the state of the vm to the snapshot with id `snapshotId`.

### **revertToSnapshot(uint256 snapshotId) &rarr; (bool)**

Reverts the state of the vm to the snapshot with id `snapshotId`.

### **addBreakpoint(Context self, string name) &rarr; (Context)**

Creates a breakpoint to jump to in the debugger.

### **addBreakpoint(string name) &rarr; (Context)**

Creates a breakpoint to jump to in the debugger.

### **addConditionalBreakpoint(Context self, string name, bool condition) &rarr; (Context)**

Creates a breakpoint to jump to in the debugger.

### **addConditionalBreakpoint(string name, bool condition) &rarr; (Context)**

Creates a breakpoint to jump to in the debugger.

