// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, expect, ctx} from "vulcan/test.sol";

/// @title Modify chain parameters using method chaining
/// @dev Use the context module to modify chain parameters using method chaining
contract ContextExample is Test {
    function test() external {
        ctx.setBlockTimestamp(1).setBlockNumber(123).setBlockBaseFee(99999).setBlockPrevrandao(bytes32(uint256(123)))
            .setChainId(666).setBlockCoinbase(address(1)).setGasPrice(1e18);

        expect(block.timestamp).toEqual(1);
        expect(block.number).toEqual(123);
        expect(block.basefee).toEqual(99999);
        expect(block.prevrandao).toEqual(uint256(bytes32(uint256(123))));
        expect(block.chainid).toEqual(666);
        expect(block.coinbase).toEqual(address(1));
        expect(tx.gasprice).toEqual(1e18);
    }
}
