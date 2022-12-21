pragma solidity ^0.8.13;

import { Test, expect, _T } from  "../src/Sest.sol";

library TestExtension {
    function increaseTime(_T memory self, uint256 increase) internal returns(_T memory) {
        self.setBlockTimestamp(block.timestamp + increase);
        return self;
    }
}

contract ExampleTest is Test {
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
