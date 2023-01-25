pragma solidity ^0.8.13;

import { Test, expect, _T, vm, console, TestLib } from  "../src/Sest.sol";

library TestExtension {
    function increaseBlockTimestamp(_T self, uint256 increase) internal returns(_T) {
        self.setBlockTimestamp(block.timestamp + increase);
        return self;
    }
}

using TestExtension for _T;

contract ExampleTest is Test {
    using TestLib for _T;
    function testIncreaseTime() external {
        uint256 increase = 1000;
        uint256 current = block.timestamp;
        vm.increaseBlockTimestamp(increase);

        expect(block.timestamp).toEqual(current + increase);
    }

    function testSetBlockNumber() external {
        uint256 blockNumber = block.number + 1000;
        vm.setBlockNumber(blockNumber);

        expect(block.number).toEqual(blockNumber);
    }

    function testBoolExpectation() external {
        expect(true).toBeTrue();
        expect(false).toBeFalse();
        expect(true).toEqual(true);
        expect(false).toEqual(false);
        expect(false).toEqual(true);
    }

    function testConsoleLog() external view {
        console.log("hello world");
    }

    function testGetNonce() external {
        expect(vm.getNonce(address(1))).toEqual(0);
    }

    function testSetNonce() external {
        uint64 nonce = 1337;
        vm.setNonce(address(1), nonce);

        expect(vm.getNonce(address(1))).toEqual(nonce);
    }

    function testSetBlockBaseFee() external {
        uint256 baseFee = 1337;
        vm.setBlockBaseFee(baseFee);

        expect(block.basefee).toEqual(baseFee);
    }

    function testSetBlockDifficulty() external {
        uint256 difficulty = 1337;
        vm.setBlockDifficulty(difficulty);

        expect(block.difficulty).toEqual(difficulty);
    }

    function testSetChainId() external {
        uint256 chainId = 1337;
        vm.setChainId(chainId);

        expect(block.chainid).toEqual(chainId);
    }
}
