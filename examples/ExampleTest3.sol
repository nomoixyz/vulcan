pragma solidity ^0.8.13;

import "../src/Test3.sol";

library TestExtension {
    function increaseTime(TestLib._T storage self, uint256 increase) internal returns(TestLib._T storage) {
        self.setBlockTimestamp(block.timestamp + increase);
        return self;
    }
}

contract ExampleTest is Test {
    function testSomething() external {
        test.setBlockFee(1).setBlockDifficulty(2).setBlockChainId(3);

        test.setBlockFee(1);
        test.setBlockDifficulty(2);
        test.setChainId(3);
    }
}
