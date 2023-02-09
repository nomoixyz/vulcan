pragma solidity >=0.8.13 <0.9.0;

import {Test, expect, accounts, ctx, console, vulcan, accounts, AccountsLib, watchers, Watcher} from "../src/lib.sol";
import {Sender} from "./mocks/Sender.sol";
import {commands, Command} from "src/Command.sol";

contract ExampleTest is Test {
    using vulcan for *;
    using AccountsLib for *;
    using watchers for *;

    function beforeEach() internal view override {
        // console.log("before each");
    }

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
        uint256 chainId = 1337;
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

    function testNamespacedWatchers() external {
        Sender sender = new Sender();
        uint256 senderCode = uint256(keccak256(address(sender).code));

        Watcher memory watcher = watchers.watch(address(sender));

        uint256 watcherProxyCode = uint256(keccak256(watcher.watcherStorage.proxy().code));
        uint256 watcherTargetCode = uint256(keccak256(watcher.watcherStorage.target().code));

        // The target of the watcher should have the sender code
        expect(watcherTargetCode).toEqual(senderCode);
        // The sender code should have the watcher code
        expect(uint256(keccak256(address(sender).code))).toEqual(watcherProxyCode);

        watchers.stop(address(sender));

        // The sender code should be the original sender code
        expect(uint256(keccak256(address(sender).code))).toEqual(senderCode);
    }

    function testVmWatchers() external {
        Sender sender = new Sender();
        uint256 senderCode = uint256(keccak256(address(sender).code));

        Watcher memory watcher = watchers.watch(address(sender));

        uint256 watcherProxyCode = uint256(keccak256(watcher.watcherStorage.proxy().code));
        uint256 watcherTargetCode = uint256(keccak256(watcher.watcherStorage.target().code));

        // The target of the watcher should have the sender code
        expect(watcherTargetCode).toEqual(senderCode);
        // The sender code should have the watcher code
        expect(uint256(keccak256(address(sender).code))).toEqual(watcherProxyCode);

        watchers.stop(address(sender));

        // The sender code should be the original sender code
        expect(uint256(keccak256(address(sender).code))).toEqual(senderCode);
    }

    function testVmWatchersFromAddress() external {
        Sender sender = new Sender();
        uint256 senderCode = uint256(keccak256(address(sender).code));

        Watcher memory watcher = address(sender).watch();

        uint256 watcherProxyCode = uint256(keccak256(watcher.watcherStorage.proxy().code));
        uint256 watcherTargetCode = uint256(keccak256(watcher.watcherStorage.target().code));

        // The target of the watcher should have the sender code
        expect(watcherTargetCode).toEqual(senderCode);
        // The sender code should have the watcher code
        expect(uint256(keccak256(address(sender).code))).toEqual(watcherProxyCode);

        address(sender).stopWatcher();

        // The sender code should be the original sender code
        expect(uint256(keccak256(address(sender).code))).toEqual(senderCode);
    }

    function testCommand() external {
        string[] memory inputs = new string[](2);
        inputs[0] = "echo";
        inputs[1] = "'Hello, World!'";

        expect(string(commands.run(inputs))).toEqual("'Hello, World!'");
        expect(string(commands.create(inputs).run())).toEqual("'Hello, World!'");

        Command memory cmd = commands.create(inputs);
        expect(string(cmd.run())).toEqual("'Hello, World!'");
    }
}
