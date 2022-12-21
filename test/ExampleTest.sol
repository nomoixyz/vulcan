pragma solidity ^0.8.13;

import { Test, expect, _T } from  "../src/Sest.sol";

library TestExtension {
    function increaseBlockTimestamp(_T storage self, uint256 increase) internal returns(_T memory) {
        self.setBlockTimestamp(block.timestamp + increase);
        return self;
    }
}

using TestExtension for _T;

contract ExampleTest is Test {
    function testIncreaseTime() external {
        uint256 increase = 1000;
        uint256 current = block.timestamp;
        test.increaseBlockTimestamp(increase);

        expect(block.timestamp).toEqual(current + increase);
    }

    function testSetBlockNumber() external {
        uint256 blockNumber = block.number + 1000;
        test.setBlockNumber(blockNumber);

        expect(block.number).toEqual(blockNumber);
    }

    function testBoolExpectation() external pure {
        expect(true).toBeTrue();
        expect(false).toBeFalse();
        expect(true).toEqual(true);
        expect(false).toEqual(false);
    }
}
