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
}
