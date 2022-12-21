// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.7.0;

import "forge-std/Vm.sol";

/**
 * Design options:
 * 1. Use sest as the "root" object that is used directly (sest.setBlockTimestamp, sest.setBalance, sest.expectCall, etc). It's just a subset of Vm but with better names.
 * 2. Group things into "modules" (sest.block.setTimestamp, sest.account.setBalance, etc).
 * 3. A mix of the two.
 * 4. Use "using for" to add methods to existing types (someAddress.balance, someAddress.impersonate, etc). Might make it difficult to determine where the methods come from.
 * 5. Use chaining and custom types (similar to 2): sest.account(someAddress).balance(100).impersonate(), sest.block.timestamp(100).fee(100), etc.
 * 7. Use weird stuff like someContract.foo().from(owner())
 */


// TODO: most variable names and comments are the ones provided by the forge-std library, figure out if we should change/improve/remove some of them
// @dev Main entry point to vm functionality
library TestLib {
    struct _T {
        uint8 t;
    }
    // type Account is uint8;

    Vm constant vm = Vm(address(bytes20(uint160(uint256(keccak256('hevm cheat code'))))));

    // Sets block.timestamp (newTimestamp)
    function setBlockTimestamp(_T memory self, uint256 newTimestamp) internal returns(_T memory) {
        vm.warp(newTimestamp);
        return self;
    }
    // Sets block.height (newHeight)
    function setBlockHeight(_T memory self, uint256 newHeight) internal returns(_T memory) {
        vm.roll(newHeight);
        return self;
    }
    // Sets block.basefee (newBasefee)
    function setBlockFee(_T memory self, uint256 newBasefee) internal returns(_T memory) {
        vm.fee(newBasefee);
        return self;
    }
    // Sets block.difficulty (newDifficulty)
    function setBlockDifficulty(_T memory self, uint256 newDifficulty) internal returns(_T memory) {
        vm.difficulty(newDifficulty);
        return self;
    }
    // Sets block.chainid
    function setChainId(_T memory self, uint256 chainId) internal returns(_T memory){
        vm.chainId(chainId);
        return self;
    }

    // Stores a value to an address' storage slot, (who, slot, value)
    function store(address self, bytes32 slot, bytes32 value) internal returns(address) {
        vm.store(self, slot, value);
        return self;
    }
    // Sets the nonce of an account; must be higher than the current nonce of the account
    function setNonce(address self, uint64 n) internal returns(address) {
        vm.setNonce(self, n);
        return self;
    }

    // Sets an address' balance, (who, newBalance)
    // TODO: this can't be just "balance" because it conflicts with the `balance` field in the `address` type (unless we go for a custom type)
    function setBalance(address self, uint256 newBalance) internal returns(address) {
        vm.deal(self, newBalance);
        return self;
    }

     // Sets the *next* call's msg.sender to be the input address
    function impersonateOnce(address self) internal returns(address) {
        vm.prank(self);
        return self;
    }
    // Sets all subsequent calls' msg.sender to be the input address until `stopPrank` is called
    function impersonate(address self) internal returns(address) {
        vm.startPrank(self);
        return self;
    }

    // Sets the *next* call's msg.sender to be the input address, and the tx.origin to be the second input
    function impersonateOnce(address self, address origin) internal returns(address) {
        vm.prank(self, origin);
        return self;
    }
    // Sets all subsequent calls' msg.sender to be the input address until `stopPrank` is called, and the tx.origin to be the second input
    function impersonate(address self, address origin) internal returns(address) {
        vm.startPrank(self, origin);
        return self;
    }
    // Resets subsequent calls' msg.sender to be `address(this)`
    function stopImpersonate() internal {
        vm.stopPrank();
    }
}
