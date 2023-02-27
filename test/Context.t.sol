pragma solidity >=0.8.13 <0.9.0;

import {Test, expect, commands, ctx} from "../src/test.sol";

contract ContextTest is Test {
    function testItCanSetTheBlockTimestamp(uint256 blockTimestamp) external {
        ctx.setBlockTimestamp(blockTimestamp);

        expect(block.timestamp).toEqual(blockTimestamp);
    }

    function testItCanSetTheBlockNumber(uint256 blockNumber) external {
        ctx.setBlockNumber(blockNumber);

        expect(block.number).toEqual(blockNumber);
    }

    function testItCanSetTheBlockBaseFee(uint256 baseFee) external {
        ctx.setBlockBaseFee(baseFee);

        expect(block.basefee).toEqual(baseFee);
    }

    function testItCanSetTheBlockDifficulty(uint256 difficulty) external {
        ctx.setBlockDifficulty(difficulty);

        expect(block.difficulty).toEqual(difficulty);
    }

    function testItCanSetTheChainId(uint64 chainId) external {
        ctx.setChainId(chainId);

        expect(block.chainid).toEqual(chainId);
    }

    function testItCanSetTheBlockCoinbase(address coinbase) external {
        ctx.setBlockCoinbase(coinbase);

        expect(block.coinbase).toEqual(coinbase);
    }

    function testItCanSnapshot() external {
        uint256 originalBlockTimestamp = 1337;

        ctx.setBlockTimestamp(originalBlockTimestamp);

        uint256 snapshotId = ctx.snapshot();

        ctx.setBlockTimestamp(originalBlockTimestamp + 69);

        expect(block.timestamp).toEqual(originalBlockTimestamp + 69);

        ctx.revertToSnapshot(snapshotId);

        expect(block.timestamp).toEqual(originalBlockTimestamp);
    }

    function testItCanExpectRevert() external {
        ctx.expectRevert();
        Revert.fail();
    }

    function testItCanExpectRevertWithMessage() external {
        ctx.expectRevert(bytes("Reverted"));
        Revert.failWithMessage();
    }

    function testItCanExpectRevertWithCustomErrror() external {
        ctx.expectRevert();
        Revert.failWithCustomError();
    }

    function testItCanExpectRevertWithCustomErrorSelector() external {
        ctx.expectRevert(Revert.Custom.selector);
        Revert.failWithCustomError();
    }

    function testItCanMockCalls() external {
        MockTarget target = new MockTarget();

        ctx.mockCall(address(target), abi.encodeWithSelector(MockTarget.truth.selector), abi.encode(false));

        expect(target.truth()).toBeFalse();

        ctx.mockCall(
            address(target), abi.encodeWithSelector(MockTarget.value.selector, uint256(1337)), abi.encode(false)
        );

        expect(target.value{value: uint256(1337)}()).toEqual(uint256(1337));
    }

    function testItCanExpectCalls() external {
        MockTarget target = new MockTarget();

        ctx.expectCall(address(target), abi.encodeWithSelector(MockTarget.truth.selector));

        target.truth();

        ctx.expectCall(address(target), uint256(1337), abi.encodeWithSelector(MockTarget.value.selector));

        target.value{value: uint256(1337)}();
    }
}

contract MockTarget {
    function truth() external pure returns (bool) {
        return true;
    }

    function value() external payable returns (uint256) {
        return msg.value;
    }
}

library Revert {
    function fail() external pure {
        revert();
    }

    function failWithMessage() external pure {
        revert("Reverted");
    }

    function failWithCustomError() external pure {
        revert Custom();
    }

    error Custom();
}
