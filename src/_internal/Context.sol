// SPDX-License-Identifier: MIT
pragma solidity >=0.8.13 <0.9.0;

import {vulcan} from "./Vulcan.sol";
import {accountsUnsafe as accounts} from "./Accounts.sol";
import {strings} from "./Strings.sol";
import {println, formatError} from "./Utils.sol";

type Context is bytes32;

interface IMutator {
    function mutate() external pure;
}

library ctxSafe {
    function broadcast() internal {
        vulcan.hevm.broadcast();
    }

    function broadcast(address from) internal {
        vulcan.hevm.broadcast(from);
    }

    function broadcast(uint256 privKey) internal {
        vulcan.hevm.broadcast(privKey);
    }

    function startBroadcast() internal {
        vulcan.hevm.startBroadcast();
    }

    function startBroadcast(address from) internal {
        vulcan.hevm.startBroadcast(from);
    }

    function startBroadcast(uint256 privKey) internal {
        vulcan.hevm.startBroadcast(privKey);
    }

    function stopBroadcast() internal {
        vulcan.hevm.stopBroadcast();
    }

    function assume(bool condition) internal pure {
        vulcan.hevm.assume(condition);
    }

    function pauseGasMetering() internal {
        vulcan.hevm.pauseGasMetering();
    }

    function resumeGasMetering() internal {
        vulcan.hevm.resumeGasMetering();
    }

    function startGasReport(string memory name) internal {
        if (bytes(name).length > 32) {
            revert(_formatError("startGasReport", "Gas report name can't have more than 32 characters"));
        }

        bytes32 b32Name = bytes32(bytes(name));
        bytes32 slot = keccak256(bytes("vulcan.ctx.gasReport.name"));
        accounts.setStorage(address(vulcan.hevm), slot, b32Name);
        bytes32 valueSlot = keccak256(abi.encodePacked("vulcan.ctx.gasReport", b32Name));
        accounts.setStorage(address(vulcan.hevm), valueSlot, bytes32(gasleft()));
    }

    function endGasReport() internal view {
        uint256 gas = gasleft();
        bytes32 slot = keccak256(bytes("vulcan.ctx.gasReport.name"));
        bytes32 b32Name = accounts.readStorage(address(vulcan.hevm), slot);
        bytes32 valueSlot = keccak256(abi.encodePacked("vulcan.ctx.gasReport", b32Name));
        uint256 prevGas = uint256(accounts.readStorage(address(vulcan.hevm), valueSlot));
        if (gas > prevGas) {
            revert(_formatError("endGasReport", "Gas used can't have a negative value"));
        }
        println(string.concat("gas(", string(abi.encodePacked(b32Name)), "):", strings.toString(prevGas - gas)));
    }

    function _formatError(string memory func, string memory message) private pure returns (string memory) {
        return formatError("ctx", func, message);
    }
}

/// @dev Contract used to check if a call is static or not.
contract CallContext {
    uint256 private val = 0;

    /// @dev Function used to check if the call can mutate the storage.
    function mutate() external {
        val = 0;
    }

    /// @dev Function to check if the current call is a staticcall.
    function isStaticcall() external view returns (bool) {
        try IMutator(address(this)).mutate() {
            return true;
        } catch {
            return false;
        }
    }
}

library ctxUnsafe {
    /// @dev Deterministic address that will hold the code of the `CallContext` contract.
    address internal constant CALL_CONTEXT_ADDRESS = address(uint160(uint256(keccak256("vulcan.ctx.callContext"))));

    /// @dev Function to initialize and set the code of `CALL_CONTEXT_ADDRESS`.
    function init() internal {
        accounts.setCode(CALL_CONTEXT_ADDRESS, type(CallContext).runtimeCode);
    }

    function broadcast() internal {
        ctxSafe.broadcast();
    }

    function broadcast(address from) internal {
        ctxSafe.broadcast(from);
    }

    function broadcast(uint256 privKey) internal {
        ctxSafe.broadcast(privKey);
    }

    function startBroadcast() internal {
        ctxSafe.startBroadcast();
    }

    function startBroadcast(address from) internal {
        ctxSafe.startBroadcast(from);
    }

    function startBroadcast(uint256 privKey) internal {
        ctxSafe.startBroadcast(privKey);
    }

    function stopBroadcast() internal {
        ctxSafe.stopBroadcast();
    }

    function assume(bool condition) internal pure {
        ctxSafe.assume(condition);
    }

    function pauseGasMetering() internal {
        ctxSafe.pauseGasMetering();
    }

    function resumeGasMetering() internal {
        ctxSafe.resumeGasMetering();
    }

    function startGasReport(string memory name) internal {
        ctxSafe.startGasReport(name);
    }

    function endGasReport() internal view {
        ctxSafe.endGasReport();
    }

    /// @dev Checks whether the current call is a static call or not.
    /// @return True if the current call is a static call, false otherwise.
    function isStaticcall() internal view returns (bool) {
        return CallContext(CALL_CONTEXT_ADDRESS).isStaticcall();
    }

    /// @dev sets the `block.timestamp` to `ts`
    /// @param ts the new block timestamp
    function setBlockTimestamp(Context self, uint256 ts) internal returns (Context) {
        vulcan.hevm.warp(ts);
        return self;
    }

    /// @dev sets the `block.timestamp` to `ts`
    /// @param ts the new block timestamp
    function setBlockTimestamp(uint256 ts) internal returns (Context) {
        return setBlockTimestamp(Context.wrap(0), ts);
    }

    /// @dev sets the `block.number` to `blockNumber`
    /// @param blockNumber the new block number
    function setBlockNumber(Context self, uint256 blockNumber) internal returns (Context) {
        vulcan.hevm.roll(blockNumber);
        return self;
    }

    /// @dev sets the `block.number` to `blockNumber`
    /// @param blockNumber the new block number
    function setBlockNumber(uint256 blockNumber) internal returns (Context) {
        return setBlockNumber(Context.wrap(0), blockNumber);
    }

    /// @dev sets the `block.basefee` to `baseFee`
    /// @param baseFee the new block base fee
    function setBlockBaseFee(Context self, uint256 baseFee) internal returns (Context) {
        vulcan.hevm.fee(baseFee);
        return self;
    }

    /// @dev sets the `block.basefee` to `baseFee`
    /// @param baseFee the new block base fee
    function setBlockBaseFee(uint256 baseFee) internal returns (Context) {
        return setBlockBaseFee(Context.wrap(0), baseFee);
    }

    /// @dev Sets block.prevrandao.
    /// @param newPrevrandao The new `block.prevrandao`.
    function setBlockPrevrandao(Context self, bytes32 newPrevrandao) internal returns (Context) {
        vulcan.hevm.prevrandao(newPrevrandao);
        return self;
    }

    /// @dev Sets block.prevrandao.
    /// @param newPrevrandao The new `block.prevrandao`.
    function setBlockPrevrandao(bytes32 newPrevrandao) internal returns (Context) {
        return setBlockPrevrandao(Context.wrap(0), newPrevrandao);
    }

    /// @dev sets the `block.chainid` to `chainId`
    /// @param chainId the new block chain id
    function setChainId(Context self, uint64 chainId) internal returns (Context) {
        vulcan.hevm.chainId(chainId);
        return self;
    }

    /// @dev sets the `block.chainid` to `chainId`
    /// @param chainId the new block chain id
    function setChainId(uint64 chainId) internal returns (Context) {
        return setChainId(Context.wrap(0), chainId);
    }

    /// @dev Sets the block coinbase to `who`.
    /// @param self The context.
    /// @param who The address to set as the block coinbase.
    /// @return The same context in order to allow function chaining.
    function setBlockCoinbase(Context self, address who) internal returns (Context) {
        vulcan.hevm.coinbase(who);
        return self;
    }

    /// @dev Sets the block coinbase to `who`.
    /// @param who The address to set as the block coinbase.
    /// @return The same context to allow function chaining.
    function setBlockCoinbase(address who) internal returns (Context) {
        return setBlockCoinbase(Context.wrap(0), who);
    }

    /// @dev Sets the transaction gas price.
    /// @param newGasPrice The new transaction gas price.
    function setGasPrice(Context self, uint256 newGasPrice) internal returns (Context) {
        vulcan.hevm.txGasPrice(newGasPrice);
        return self;
    }

    /// @dev Sets the transaction gas price.
    /// @param newGasPrice The new transaction gas price.
    function setGasPrice(uint256 newGasPrice) internal returns (Context) {
        return setGasPrice(Context.wrap(0), newGasPrice);
    }

    /// @dev Function used to check whether the next call reverts or not.
    /// @param revertData The function call data that that is expected to fail.
    function expectRevert(bytes memory revertData) internal {
        vulcan.hevm.expectRevert(revertData);
    }

    /// @dev Function used to check whether the next call reverts or not.
    /// @param revertData The function call signature that that is expected to fail.
    function expectRevert(bytes4 revertData) internal {
        vulcan.hevm.expectRevert(revertData);
    }

    /// @dev Function used to check whether the next call reverts or not.
    function expectRevert() internal {
        vulcan.hevm.expectRevert();
    }

    /// @dev Checks if an event was emitted with the given properties.
    /// @param checkTopic1 Whether to check the first topic match.
    /// @param checkTopic2 Whether to check the second topic match.
    /// @param checkTopic3 Whether to check the third topic match.
    /// @param checkData Whether to check the data field match.
    function expectEmit(bool checkTopic1, bool checkTopic2, bool checkTopic3, bool checkData) internal {
        vulcan.hevm.expectEmit(checkTopic1, checkTopic2, checkTopic3, checkData);
    }

    /// @dev Checks if an event was emitted with the given properties.
    /// @param checkTopic1 Whether to check the first topic match.
    /// @param checkTopic2 Whether to check the second topic match.
    /// @param checkTopic3 Whether to check the third topic match.
    /// @param checkData Whether to check the data field match.
    /// @param emitter The address of the expected emitter.
    function expectEmit(bool checkTopic1, bool checkTopic2, bool checkTopic3, bool checkData, address emitter)
        internal
    {
        vulcan.hevm.expectEmit(checkTopic1, checkTopic2, checkTopic3, checkData, emitter);
    }

    /// @dev Function to mock a call to a specified address.
    /// @param callee The address for which the call should be mocked.
    /// @param data The data for which the call should be mocked.
    /// @param returnData The data that should be returned if `data` matches the provided call data.
    function mockCall(address callee, bytes memory data, bytes memory returnData) internal {
        vulcan.hevm.mockCall(callee, data, returnData);
    }

    /// @dev Function to mock a call to a specified address.
    /// @param callee The address for which the call should be mocked.
    /// @param msgValue The `msg.value` for which the call should be mocked.
    /// @param data The data for which the call should be mocked.
    /// @param returnData The data that should be returned if `data` matches the provided call data.
    function mockCall(address callee, uint256 msgValue, bytes memory data, bytes memory returnData) internal {
        vulcan.hevm.mockCall(callee, msgValue, data, returnData);
    }

    /// @dev Function to clear all the mocked calls.
    function clearMockedCalls() internal {
        vulcan.hevm.clearMockedCalls();
    }

    /// @dev Used to check if a call to `callee` with `data` was made.
    /// @param callee The address that is expected to be called.
    /// @param data The call data that is expected to be used.
    function expectCall(address callee, bytes memory data) internal {
        vulcan.hevm.expectCall(callee, data);
    }

    /// @dev Used to check if a call to `callee` with `data` and `msgValue` was made.
    /// @param callee The address that is expected to be called.
    /// @param msgValue The `msg.value` that is expected to be sent.
    /// @param data The call data that is expected to be used.
    function expectCall(address callee, uint256 msgValue, bytes memory data) internal {
        vulcan.hevm.expectCall(callee, msgValue, data);
    }

    /// @dev Expect a call to an address with the specified msg.value and calldata, and a minimum amount of gas.
    /// @param callee The address that is expected to be called.
    /// @param msgValue The `msg.value` that is expected to be sent.
    /// @param minGas The expected minimum amount of gas for the call.
    /// @param data The call data that is expected to be used.
    function expectCallMinGas(address callee, uint256 msgValue, uint64 minGas, bytes calldata data) internal {
        vulcan.hevm.expectCallMinGas(callee, msgValue, minGas, data);
    }

    /// @dev Expect a number call to an address with the specified msg.value and calldata, and a minimum amount of gas.
    /// @param callee The address that is expected to be called.
    /// @param msgValue The `msg.value` that is expected to be sent.
    /// @param minGas The expected minimum amount of gas for the call.
    /// @param data The call data that is expected to be used.
    /// @param count The number of calls that are expected.
    function expectCallMinGas(address callee, uint256 msgValue, uint64 minGas, bytes calldata data, uint64 count)
        external
    {
        vulcan.hevm.expectCallMinGas(callee, msgValue, minGas, data, count);
    }

    /// @dev Allows to  write on memory only between [0x00, 0x60) and [min, max) in the current.
    /// subcontext.
    /// @param min The lower limit of the allowed memory slot.
    /// @param max The upper limit of the allowed memory slot.
    function expectSafeMemory(uint64 min, uint64 max) external {
        vulcan.hevm.expectSafeMemory(min, max);
    }

    /// @dev Allows to  write on memory only between [0x00, 0x60) and [min, max) in the next
    // subcontext.
    /// @param min The lower limit of the allowed memory slot.
    /// @param max The upper limit of the allowed memory slot.
    function expectsafememorycall(uint64 min, uint64 max) external {
        vulcan.hevm.expectSafeMemoryCall(min, max);
    }

    /// @dev Takes a snapshot of the current state of the vm and returns an identifier.
    /// @return The snapshot identifier.
    function snapshot(Context) internal returns (uint256) {
        return vulcan.hevm.snapshot();
    }

    /// @dev Takes a snapshot of the current state of the vm and returns an identifier.
    /// @return The snapshot identifier.
    function snapshot() internal returns (uint256) {
        return snapshot(Context.wrap(0));
    }

    /// @dev Reverts the state of the vm to the snapshot with id `snapshotId`.
    /// @param snapshotId The id of the snapshot to revert to.
    /// @return true if the vm was reverted to the selected snapshot.
    function revertToSnapshot(Context, uint256 snapshotId) internal returns (bool) {
        return vulcan.hevm.revertTo(snapshotId);
    }

    /// @dev Reverts the state of the vm to the snapshot with id `snapshotId`.
    /// @param snapshotId The id of the snapshot to revert to.
    /// @return true if the vm was reverted to the selected snapshot.
    function revertToSnapshot(uint256 snapshotId) internal returns (bool) {
        return revertToSnapshot(Context.wrap(0), snapshotId);
    }

    /// @dev Creates a breakpoint to jump to in the debugger.
    /// @param name The name of the breakpoint.
    function addBreakpoint(Context self, string memory name) internal returns (Context) {
        vulcan.hevm.breakpoint(name);
        return self;
    }

    /// @dev Creates a breakpoint to jump to in the debugger.
    /// @param name The name of the breakpoint.
    function addBreakpoint(string memory name) internal returns (Context) {
        return addBreakpoint(Context.wrap(0), name);
    }

    /// @dev Creates a breakpoint to jump to in the debugger.
    /// @param name The name of the breakpoint.
    /// @param condition The condition that needs to be fulfilled in order to add the breakpoint.
    function addConditionalBreakpoint(Context self, string memory name, bool condition) internal returns (Context) {
        vulcan.hevm.breakpoint(name, condition);
        return self;
    }

    /// @dev Creates a breakpoint to jump to in the debugger.
    /// @param name The name of the breakpoint.
    /// @param condition The condition that needs to be fulfilled in order to add the breakpoint.
    function addConditionalBreakpoint(string memory name, bool condition) internal returns (Context) {
        return addConditionalBreakpoint(Context.wrap(0), name, condition);
    }
}

using ctxUnsafe for Context global;
