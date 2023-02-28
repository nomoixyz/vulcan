pragma solidity >=0.8.13 <0.9.0;

import {Test, expect, commands, accounts, console} from "../src/test.sol";
import {Sender} from "./mocks/Sender.sol";

contract AccountsTest is Test {
    using accounts for *;

    function testItCanGetTheNonce() external {
        address addr = address(1);

        expect(addr.getNonce()).toEqual(0);
    }

    function testItCanSetTheNonce() external {
        address addr = address(1);
        uint64 nonce = 1337;

        addr.setNonce(nonce);

        expect(addr.getNonce()).toEqual(nonce);
    }

    function testItCanSetTheBalance(address addr, uint256 balance) external {
        addr.setBalance(balance);

        expect(addr.balance).toEqual(balance);
    }

    function testItCanSetTheCode() external {
        address addr = address(1);

        Sender sender = new Sender();

        addr.setCode(address(sender).code);

        expect(addr.code).toEqual(address(sender).code);
    }

    function testItCanReadTheStorage() external {
        StorageMock mock = new StorageMock();

        uint256 expectedValue = 69;
        bytes32 slot = bytes32(0);

        expect(address(mock).readStorage(slot)).toEqual(bytes32(expectedValue));
    }

    function testItCanSetTheStorage(uint256 newValue) external {
        StorageMock mock = new StorageMock();

        bytes32 slot = bytes32(0);

        address(mock).setStorage(slot, bytes32(newValue));

        expect(address(mock).readStorage(slot)).toEqual(bytes32(newValue));
    }

    function testItCanDeriveAnAddress() external {
        // from https://privatekeyfinder.io/private-keys/ethereum/
        uint256 privateKey = uint256(0x0000000000000000000000000000000000000000000000000000000000000001);
        address expectedAddress = 0x7E5F4552091A69125d5DfCb7b8C2659029395Bdf;

        expect(accounts.derive(privateKey)).toEqual(expectedAddress);
    }

    function testItCanDeriveAPrivateKey() external {
        string memory mnemonic =
            "secret never hurt wife tenant spawn conduct arena disagree fold lamp december huge gloom bomb evolve page cigar pool little ensure gentle patrol drop";
        // from https://iancoleman.io/bip39/
        uint256 expectedKey = uint256(0xc65435a2e284fd482ef1e53b28bc7c19d6fdabb19236068cd676a18519f88b5d);

        expect(accounts.deriveKey(mnemonic, 0)).toEqual(expectedKey);
    }

    function testItCanDeriveAPrivateKeyWithPath() external {
        string memory mnemonic =
            "secret never hurt wife tenant spawn conduct arena disagree fold lamp december huge gloom bomb evolve page cigar pool little ensure gentle patrol drop";
        string memory derivationPath = "m/44'/60'/1'/0";
        // from https://iancoleman.io/bip39/
        uint256 expectedKey = uint256(0x406de23ee0077ad30b6d7dfd949c1d83254b73bfdaa497c352fbb7f36a20f990);

        expect(accounts.deriveKey(mnemonic, derivationPath, 0)).toEqual(expectedKey);
    }

    function testItCanImpersonateOnce(address addr) external {
        Sender sender = new Sender();

        addr.impersonateOnce();

        expect(sender.get()).toEqual(addr);
        expect(sender.get()).toEqual(address(this));
    }

    function testItCanImpersonateOnceWithOrigin(address addr, address origin) external {
        Sender sender = new Sender();

        addr.impersonateOnce(origin);

        (address msgSender, address txOrigin) = sender.getWithOrigin();

        expect(msgSender).toEqual(addr);
        expect(txOrigin).toEqual(origin);

        (msgSender, txOrigin) = sender.getWithOrigin();

        expect(msgSender).toEqual(address(this));
    }

    function testItCanImpersonate(address addr) external {
        Sender sender = new Sender();

        addr.impersonate();

        expect(sender.get()).toEqual(addr);
        expect(sender.get()).toEqual(addr);
        expect(sender.get()).toEqual(addr);
        expect(sender.get()).toEqual(addr);

        accounts.stopImpersonate();

        expect(sender.get()).toEqual(address(this));
    }

    function testItCanImpersonateWithOrigin(address addr, address origin) external {
        Sender sender = new Sender();

        addr.impersonate(origin);

        (address msgSender, address txOrigin) = sender.getWithOrigin();
        expect(msgSender).toEqual(addr);
        expect(txOrigin).toEqual(origin);

        (msgSender, txOrigin) = sender.getWithOrigin();
        expect(msgSender).toEqual(addr);
        expect(txOrigin).toEqual(origin);

        (msgSender, txOrigin) = sender.getWithOrigin();
        expect(msgSender).toEqual(addr);
        expect(txOrigin).toEqual(origin);

        accounts.stopImpersonate();

        (msgSender, txOrigin) = sender.getWithOrigin();
        expect(msgSender).toEqual(address(this));
    }

    function testItCanImpersonateMultipleTimes() external {
        address addr1 = address(1);
        address addr2 = address(2);

        Sender sender = new Sender();

        addr1.impersonate();
        expect(sender.get()).toEqual(addr1);
        expect(sender.get()).toEqual(addr1);
        addr2.impersonate();
        expect(sender.get()).toEqual(addr2);
        expect(sender.get()).toEqual(addr2);
        addr1.impersonateOnce();
        expect(sender.get()).toEqual(addr1);
    }

    function testItCanUpdateTheTokenBalance(address user, uint256 balance) external {
        TestToken token = new TestToken();

        user.setTokenBalance(address(token), balance);

        expect(token.balanceOf(user)).toEqual(balance);
        expect(token.totalSupply()).toEqual(0);
    }

    function testItCanMintTokens(address user, uint128 firstMint, uint128 secondMint) external {
        TestToken token = new TestToken();

        user.mintToken(address(token), firstMint);

        expect(token.balanceOf(user)).toEqual(firstMint);
        expect(token.totalSupply()).toEqual(firstMint);

        user.mintToken(address(token), secondMint);

        expect(token.balanceOf(user)).toEqual(uint256(firstMint) + uint256(secondMint));
        expect(token.totalSupply()).toEqual(uint256(firstMint) + uint256(secondMint));
    }

    function testItCanBurnTokens(address user, uint128 firstBurn, uint128 secondBurn) external {
        TestToken token = new TestToken();

        user.mintToken(address(token), type(uint256).max);

        uint256 totalSupply = token.totalSupply();
        uint256 balance = token.balanceOf(user);

        user.burnToken(address(token), firstBurn);

        expect(token.balanceOf(user)).toEqual(balance - firstBurn);
        expect(token.totalSupply()).toEqual(totalSupply - firstBurn);

        user.burnToken(address(token), secondBurn);

        expect(token.balanceOf(user)).toEqual(balance - firstBurn - secondBurn);
        expect(token.totalSupply()).toEqual(totalSupply - firstBurn - secondBurn);
    }
}

contract TestToken {
    mapping(address => uint256) public balanceOf;
    uint256 public totalSupply;

    constructor() {}
}

contract StorageMock {
    uint256 value = 69;
}
