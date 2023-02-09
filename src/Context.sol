// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.13 <0.9.0;

import "./Vulcan.sol";

type Context is bytes32;

library ctx {
    /// @dev sets the `block.timestamp` to `ts`
    /// @param ts the new block timestamp
    function setBlockTimestamp(Context self, uint256 ts) internal returns(Context) {
        vulcan.hevm.warp(ts);
        return self;
    }

    /// @dev sets the `block.timestamp` to `ts`
    /// @param ts the new block timestamp
    function setBlockTimestamp(uint256 ts) internal returns(Context) {
        return setBlockTimestamp(Context.wrap(0), ts);
    }

    /// @dev sets the `block.number` to `blockNumber`
    /// @param blockNumber the new block number
    function setBlockNumber(Context self, uint256 blockNumber) internal returns(Context) {
        vulcan.hevm.roll(blockNumber);
        return self;
    }

    /// @dev sets the `block.number` to `blockNumber`
    /// @param blockNumber the new block number
    function setBlockNumber(uint256 blockNumber) internal returns(Context) {
        return setBlockNumber(Context.wrap(0), blockNumber);
    }

    /// @dev sets the `block.basefee` to `baseFee`
    /// @param baseFee the new block base fee
    function setBlockBaseFee(Context self, uint256 baseFee) internal returns(Context) {
        vulcan.hevm.fee(baseFee);
        return self;
    }

    /// @dev sets the `block.basefee` to `baseFee`
    /// @param baseFee the new block base fee
    function setBlockBaseFee(uint256 baseFee) internal returns(Context) {
        return setBlockBaseFee(Context.wrap(0), baseFee);
    }

    /// @dev sets the `block.difficulty` to `difficulty`
    /// @param difficulty the new block difficulty
    function setBlockDifficulty(Context self, uint256 difficulty) internal returns(Context) {
        vulcan.hevm.difficulty(difficulty);
        return self;
    }

    /// @dev sets the `block.difficulty` to `difficulty`
    /// @param difficulty the new block difficulty
    function setBlockDifficulty(uint256 difficulty) internal returns(Context) {
        return setBlockDifficulty(Context.wrap(0), difficulty);
    }

    /// @dev sets the `block.chainid` to `chainId`
    /// @param chainId the new block chain id
    function setChainId(Context self, uint256 chainId) internal returns(Context){
        vulcan.hevm.chainId(chainId);
        return self;
    }

    /// @dev sets the `block.chainid` to `chainId`
    /// @param chainId the new block chain id
    function setChainId(uint256 chainId) internal returns(Context){
        return setChainId(Context.wrap(0), chainId);
    }

    function setBlockCoinbase(Context self, address who) internal returns (Context){
        vulcan.hevm.coinbase(who);
        return self;
    }

    function setBlockCoinbase(address who) internal returns (Context){
        return setBlockCoinbase(Context.wrap(0), who);
    }

    function expectRevert(bytes memory revertData) internal {
        vulcan.hevm.expectRevert(revertData);
    }

    function expectRevert(bytes4 revertData) internal {
        vulcan.hevm.expectRevert(revertData);
    }

    function expectRevert() external {
        vulcan.hevm.expectRevert();
    }

    function expectEmit(bool checkTopic1, bool checkTopic2, bool checkTopic3, bool checkData) internal {
        vulcan.hevm.expectEmit(checkTopic1, checkTopic2, checkTopic3, checkData);
    }
    function expectEmit(bool checkTopic1, bool checkTopic2, bool checkTopic3, bool checkData, address emitter)
        internal
    {
        vulcan.hevm.expectEmit(checkTopic1, checkTopic2, checkTopic3, checkData, emitter);
    }

    function mockCall(address callee, bytes memory data, bytes memory returnData) internal {
        vulcan.hevm.mockCall(callee, data, returnData);
    }

    function mockCall(address callee, uint256 msgValue, bytes memory data, bytes memory returnData) internal {
        vulcan.hevm.mockCall(callee, msgValue, data, returnData);
    }

    function clearMockedCalls() internal {
        vulcan.hevm.clearMockedCalls();
    }

    function expectCall(address callee, bytes memory data) internal {
        vulcan.hevm.expectCall(callee, data);
    }

    function expectCall(address callee, uint256 msgValue, bytes memory data) internal {
        vulcan.hevm.expectCall(callee, msgValue, data);
    }
    
    function snapshot(Context) internal returns (uint256) {
        return vulcan.hevm.snapshot();
    }

    function revertToSnapshot(Context, uint256 snapshotId) internal returns (bool) {
        return vulcan.hevm.revertTo(snapshotId);
    }
}

using ctx for Context global;