// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.7.0;

import "forge-std/Vm.sol";

/**
 * Design options:
 * 1. Use sest as the "root" object that is used directly (sest.setBlockTimestamp, sest.setBalance, sest.expectCall, etc). It's just a subset of Vm but with better names.
 * 2. Group things into "modules" (sest.block.setTimestamp, sest.account.setBalance, etc).
 * 3. A mix of the two.
 * 4. Use "using for" to add methods to existing types (someAddress.setBalance, someAddress.impersonate, etc). I don't like this because it's not clear where the methods come from.
 * 5. Use chaining and custom types (similar to 2): sest.account(someAddress).balance(100).impersonate(), sest.block.timestamp(100).fee(100), etc.
 * 7. Use weird stuff like someContract.foo().from(owner())
 */

// TODO: most variable names and comments are the ones provided by the forge-std library, figure out if we should change/improve/remove some of them
// @dev Main entry point to vm functionality
library sest {
    Vm constant vm = Vm(address(bytes20(uint160(uint256(keccak256('hevm cheat code'))))));

    // Sets block.timestamp (newTimestamp)
    function setBlockTimestamp(uint256 newTimestamp) external {
        vm.warp(newTimestamp);
    }
    // Sets block.height (newHeight)
    function setBlockHeight(uint256 newHeight) external {
        vm.roll(newHeight);
    }
    // Sets block.basefee (newBasefee)
    function setBlockBaseFee(uint256 newBasefee) external {
        vm.fee(newBasefee);
    }
    // Sets block.difficulty (newDifficulty)
    function setBlockDifficulty(uint256 newDifficulty) external {
        vm.difficulty(newDifficulty);
    }
    // Sets block.chainid
    function setChainId(uint256 chainId) external {
        vm.chainId(chainId);
    }
    // Stores a value to an address' storage slot, (who, slot, value)
    function store(address who, bytes32 slot, bytes32 value) external {
        vm.store(who, slot, value);
    }
    // Sets the nonce of an account; must be higher than the current nonce of the account
    function setNonce(address who, uint64 nonce) external {
        vm.setNonce(who, nonce);
    }

     // Sets the *next* call's msg.sender to be the input address
    function impersonateOnce(address sender) external {
        vm.prank(sender);
    }
    // Sets all subsequent calls' msg.sender to be the input address until `stopPrank` is called
    function impersonate(address sender) external {
        vm.startPrank(sender);
    }
    // Sets the *next* call's msg.sender to be the input address, and the tx.origin to be the second input
    function impersonateOnce(address sender, address origin) external {
        vm.prank(sender, origin);
    }
    // Sets all subsequent calls' msg.sender to be the input address until `stopPrank` is called, and the tx.origin to be the second input
    function impersonate(address sender, address origin) external {
        vm.startPrank(sender, origin);
    }
    // Resets subsequent calls' msg.sender to be `address(this)`
    function stopImpersonate() external {
        vm.stopPrank();
    }
    // Sets an address' balance, (who, newBalance)
    function setBalance(address who, uint256 newBalance) external {
        vm.deal(who, newBalance);
    }

}
