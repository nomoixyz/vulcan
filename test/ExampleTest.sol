pragma solidity >=0.8.13 <0.9.0;

import {Test, expect, accounts, ctx, console, vulcan, accounts} from "../src/test.sol";
import {Sender} from "./mocks/Sender.sol";

contract ExampleTest is Test {
    using vulcan for *;
    using accounts for *;

    function testSetBlockNumber() external {
        uint256 blockNumber = block.number + 1000;
        ctx.setBlockNumber(blockNumber);

        expect(block.number).toEqual(blockNumber);
    }

    function testBoolExpectation() external {
        expect(true).toBeTrue();
        expect(false).toBeFalse();
        expect(true).toEqual(true);
        expect(false).toEqual(false);
    }

    function testConsoleLog() external view {
        console.log("hello world");
    }

    function testGetNonce() external {
        expect(accounts.getNonce(address(1))).toEqual(0);
    }

    function testSetNonce() external {
        uint64 nonce = 1337;
        address target = address(1);

        expect(accounts.setNonce(target, nonce).getNonce()).toEqual(nonce);
    }

    function testChainedAddress() external {
        uint256 balance = 1e18;
        uint64 nonce = 1337;

        address alice = accounts.create("ALICE").setBalance(balance).setNonce(nonce);

        expect(alice.balance).toEqual(balance);
        expect(accounts.getNonce(alice)).toEqual(nonce);

        Sender sender = new Sender();
        address bob = accounts.create("BOB").impersonateOnce().setNonce(nonce).setBalance(balance);
        expect(sender.get()).toEqual(bob);
        expect(sender.get()).toEqual(address(this));
    }

    function testSetBlockBaseFee() external {
        uint256 baseFee = 1337;
        ctx.setBlockBaseFee(baseFee);

        expect(block.basefee).toEqual(baseFee);
    }

    function testSetBlockDifficulty() external {
        uint256 difficulty = 1337;
        ctx.setBlockDifficulty(difficulty);

        expect(block.difficulty).toEqual(difficulty);
    }

    function testSetChainId() external {
        uint64 chainId = 1337;
        ctx.setChainId(chainId);

        expect(block.chainid).toEqual(chainId);
    }

    function testImpersonateOnce() external {
        address expectedSender = address(1337);
        address expectedOrigin = address(7331);
        Sender sender = new Sender();

        accounts.impersonateOnce(expectedSender);
        expect(sender.get()).toEqual(expectedSender);
        expect(sender.get()).toEqual(address(this));

        accounts.impersonateOnce(expectedSender, expectedOrigin);
        (address resultSender, address resultOrigin) = sender.getWithOrigin();
        expect(resultSender).toEqual(expectedSender);
        expect(resultOrigin).toEqual(expectedOrigin);
        (resultSender, resultOrigin) = sender.getWithOrigin();
        expect(resultSender).toEqual(address(this));
        expect(resultOrigin).toEqual(tx.origin);

        accounts.impersonate(expectedSender);
        expect(sender.get()).toEqual(expectedSender);
        expect(sender.get()).toEqual(expectedSender);
        expect(sender.get()).toEqual(expectedSender);
        accounts.stopImpersonate();

        expect(sender.get()).toEqual(address(this));

        accounts.impersonate(expectedSender, expectedOrigin);
        (resultSender, resultOrigin) = sender.getWithOrigin();
        expect(resultSender).toEqual(expectedSender);
        expect(resultOrigin).toEqual(expectedOrigin);
        (resultSender, resultOrigin) = sender.getWithOrigin();
        expect(resultSender).toEqual(expectedSender);
        expect(resultOrigin).toEqual(expectedOrigin);
        (resultSender, resultOrigin) = sender.getWithOrigin();
        expect(resultSender).toEqual(expectedSender);
        expect(resultOrigin).toEqual(expectedOrigin);
        accounts.stopImpersonate();

        (resultSender, resultOrigin) = sender.getWithOrigin();
        expect(resultSender).toEqual(address(this));
        expect(resultOrigin).toEqual(tx.origin);
    }
}
