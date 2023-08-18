# Context

#### **`broadcast()`**


#### **`broadcast(address from)`**


#### **`broadcast(uint256 privKey)`**


#### **`startBroadcast()`**


#### **`startBroadcast(address from)`**


#### **`startBroadcast(uint256 privKey)`**


#### **`stopBroadcast()`**


#### **`assume(bool condition)`**


#### **`pauseGasMetering()`**


#### **`resumeGasMetering()`**

#### **`isStaticcall() → (bool)`**

Checks whether the current call is a static call or not.

#### **`setBlockTimestamp(Context self, uint256 ts) → (Context)`**

sets the `block.timestamp` to `ts`

#### **`setBlockTimestamp(uint256 ts) → (Context)`**

sets the `block.timestamp` to `ts`

#### **`setBlockNumber(Context self, uint256 blockNumber) → (Context)`**

sets the `block.number` to `blockNumber`

#### **`setBlockNumber(uint256 blockNumber) → (Context)`**

sets the `block.number` to `blockNumber`

#### **`setBlockBaseFee(Context self, uint256 baseFee) → (Context)`**

sets the `block.basefee` to `baseFee`

#### **`setBlockBaseFee(uint256 baseFee) → (Context)`**

sets the `block.basefee` to `baseFee`

#### **`setBlockPrevrandao(Context self, bytes32 newPrevrandao) → (Context)`**

sets the `block.prevrandao` to `newPrevrandao`

#### **`setBlockPrevrandao(bytes32 newPrevrandao) → (Context)`**

sets the `block.prevrandao` to `newPrevrandao`

#### **`setChainId(Context self, uint64 chainId) → (Context)`**

sets the `block.chainid` to `chainId`

#### **`setChainId(uint64 chainId) → (Context)`**

sets the `block.chainid` to `chainId`

#### **`setBlockCoinbase(Context self, address who) → (Context)`**

Sets the block coinbase to `who`.

#### **`setBlockCoinbase(address who) → (Context)`**

Sets the block coinbase to `who`.

#### **`setGasPrice(Context self, address newGasPrice) → (Context)`**

Sets the gas price to `newGasPrice`.

#### **`setGasPrice(address newGasPrice) → (Context)`**

Sets the gas price to `newGasPrice`.

#### **`expectRevert(bytes revertData)`**

Function used to check whether the next call reverts or not.

#### **`expectRevert(bytes4 revertData)`**

Function used to check whether the next call reverts or not.

#### **`expectRevert()`**

Function used to check whether the next call reverts or not.

#### **`expectEmit(bool checkTopic1, bool checkTopic2, bool checkTopic3, bool checkData)`**

Checks if an event was emitted with the given properties.

#### **`expectEmit(bool checkTopic1, bool checkTopic2, bool checkTopic3, bool checkData, address emitter)`**

Checks if an event was emitted with the given properties.

#### **`mockCall(address callee, bytes data, bytes returnData)`**

Function to mock a call to a specified address.

#### **`mockCall(address callee, uint256 msgValue, bytes data, bytes returnData)`**

Function to mock a call to a specified address.

#### **`clearMockedCalls()`**

Function to clear all the mocked calls.

#### **`expectCall(address callee, bytes data)`**

Used to check if a call to `callee` with `data` was made.

#### **`expectCall(address callee, uint256 msgValue, bytes data)`**

Used to check if a call to `callee` with `data` and `msgValue` was made.

#### **`expectCallMinGas(address callee, uint256 msgValue, uint64 minGas, bytes calldata data)`**

Expect a call from `callee` with the specified `msgValue` and `data`, and a minimum amount of gas `minGas`.

#### **`expectCallMinGas(address callee, uint256 msgValue, uint64 minGas, bytes calldata data, uint64 count)`**

Expect a number of calls `count` from `callee` with the specified `msgValue` and `data`, and a minimum amount of gas `minGas`.

#### **`expectSafeMemory(uint64 min, uint64 max)`**

Allows to  write on memory only between [0x00, 0x60) and [`min`, `max`) in the current subcontext

#### **`expectsafememorycall(uint64 min, uint64 max)`**

Allows to  write on memory only between [0x00, 0x60) and [`min`, `max`) in the next subcontext

#### **`snapshot(Context) → (uint256)`**

Takes a snapshot of the current state of the vm and returns an identifier.

#### **`snapshot() → (uint256)`**

Takes a snapshot of the current state of the vm and returns an identifier.

#### **`revertToSnapshot(Context, uint256 snapshotId) → (bool)`**

Reverts the state of the vm to the snapshot with id `snapshotId`.

#### **`revertToSnapshot(uint256 snapshotId) → (bool)`**

Reverts the state of the vm to the snapshot with id `snapshotId`.

#### **`addBreakpoint(Context self, string memory name)`**

Creates a breakpoint to jump to in the debugger with `name`.

#### **`addBreakpoint(string memory name)`**

Creates a breakpoint to jump to in the debugger with `name`.

#### **`addConditionalBreakpoint(Context self, string memory name, bool condition)`**

Creates a conditional breakpoint to jump to in the debugger with name `name` and condition `condition`.

#### **`addConditionalBreakpoint(string memory name, bool condition)`**

Creates a conditional breakpoint to jump to in the debugger with name `name` and condition `condition`.

