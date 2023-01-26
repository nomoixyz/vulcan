pragma solidity ^0.8.13;

import { Test, expect, _T, vm, console, TestLib } from  "../src/Sest.sol";
import {Sender} from "./mocks/Sender.sol";

library TestExtension {
    function increaseBlockTimestamp(_T self, uint256 increase) internal returns(_T) {
        self.setBlockTimestamp(block.timestamp + increase);
        return self;
    }
}

using TestExtension for _T;

contract ExampleTest is Test {
    using TestLib for _T;

    function beforeEach() internal view override {
        console.log("before each");
    }

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

    function testImpersonateOnce() external {
        address expectedSender = address(1337);
        address expectedOrigin = address(7331);
        Sender sender = new Sender();

        vm.impersonateOnce(expectedSender);
        expect(sender.get()).toEqual(expectedSender);
        expect(sender.get()).toEqual(address(this));

        vm.impersonateOnce(expectedSender, expectedOrigin);
        (address resultSender, address resultOrigin) = sender.getWithOrigin();
        expect(resultSender).toEqual(expectedSender);
        expect(resultOrigin).toEqual(expectedOrigin);
        (resultSender, resultOrigin) = sender.getWithOrigin();
        expect(resultSender).toEqual(address(this));
        expect(resultOrigin).toEqual(tx.origin);

        vm.impersonate(expectedSender);
        expect(sender.get()).toEqual(expectedSender);
        expect(sender.get()).toEqual(expectedSender);
        expect(sender.get()).toEqual(expectedSender);
        vm.stopImpersonate();

        expect(sender.get()).toEqual(address(this));

        vm.impersonate(expectedSender, expectedOrigin);
        (resultSender, resultOrigin) = sender.getWithOrigin();
        expect(resultSender).toEqual(expectedSender);
        expect(resultOrigin).toEqual(expectedOrigin);
        (resultSender, resultOrigin) = sender.getWithOrigin();
        expect(resultSender).toEqual(expectedSender);
        expect(resultOrigin).toEqual(expectedOrigin);
        (resultSender, resultOrigin) = sender.getWithOrigin();
        expect(resultSender).toEqual(expectedSender);
        expect(resultOrigin).toEqual(expectedOrigin);
        vm.stopImpersonate();

        (resultSender, resultOrigin) = sender.getWithOrigin();
        expect(resultSender).toEqual(address(this));
        expect(resultOrigin).toEqual(tx.origin);
    }
}
