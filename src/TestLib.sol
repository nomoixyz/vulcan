// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.7.0;

import "forge-std/Vm.sol";

// TODO: most variable names and comments are the ones provided by the forge-std library, figure out if we should change/improve/remove some of them
struct _T {
    uint8 t;
}

// @dev Main entry point to vm functionality
library TestLib {
    uint256 internal constant VM_SLOT = uint256(keccak256("sest.vm.slot")); 
    Vm internal constant DEFAULT_VM = Vm(address(bytes20(uint160(uint256(keccak256('hevm cheat code'))))));

    function vm() internal view returns(Vm _vm) {
        uint256 vmSlot = VM_SLOT;
        assembly {
            _vm := sload(vmSlot)
        }
    }

    function vm(_T memory) internal view returns(Vm) {
        return vm();
    }

    function setVm(_T memory self, Vm _vm) internal returns(_T memory) {
        uint256 vmSlot = VM_SLOT;
        assembly {
            sstore(vmSlot, _vm)
        }
        return self;
    }

    // Sets block.timestamp (newTimestamp)
    function setBlockTimestamp(_T memory self, uint256 newTimestamp) internal returns(_T memory) {
        vm().warp(newTimestamp);
        return self;
    }
    // Sets block.number (newNumber)
    function setBlockNumber(_T memory self, uint256 newNumber) internal returns(_T memory) {
        vm().roll(newNumber);
        return self;
    }
    // Sets block.basefee (newBasefee)
    function setBlockFee(_T memory self, uint256 newBasefee) internal returns(_T memory) {
        vm().fee(newBasefee);
        return self;
    }
    // Sets block.difficulty (newDifficulty)
    function setBlockDifficulty(_T memory self, uint256 newDifficulty) internal returns(_T memory) {
        vm().difficulty(newDifficulty);
        return self;
    }
    // Sets block.chainid
    function setChainId(_T memory self, uint256 chainId) internal returns(_T memory){
        vm().chainId(chainId);
        return self;
    }

    // Stores a value to an address' storage slot, (who, slot, value)
    function store(address self, bytes32 slot, bytes32 value) internal returns(address) {
        vm().store(self, slot, value);
        return self;
    }

    // Sets the nonce of an account; must be higher than the current nonce of the account
    function setNonce(_T memory, address addr, uint64 n) internal returns(address) {
        return setNonce(addr, n);
    }
    function setNonce(address self, uint64 n) internal returns(address) {
        vm().setNonce(self, n);
        return self;
    }

    // Sets an address' balance, (who, newBalance)
    function setBalance(address self, uint256 newBalance) internal returns(address) {
        vm().deal(self, newBalance);
        return self;
    }

     // Sets the *next* call's msg.sender to be the input address
    function impersonateOnce(address self) internal returns(address) {
        vm().prank(self);
        return self;
    }
    // Sets all subsequent calls' msg.sender to be the input address until `stopPrank` is called
    function impersonate(address self) internal returns(address) {
        vm().startPrank(self);
        return self;
    }

    // Sets the *next* call's msg.sender to be the input address, and the tx.origin to be the second input
    function impersonateOnce(address self, address origin) internal returns(address) {
        vm().prank(self, origin);
        return self;
    }
    // Sets all subsequent calls' msg.sender to be the input address until `stopPrank` is called, and the tx.origin to be the second input
    function impersonate(address self, address origin) internal returns(address) {
        vm().startPrank(self, origin);
        return self;
    }
    // Resets subsequent calls' msg.sender to be `address(this)`
    function stopImpersonate(_T memory) internal {
        vm().stopPrank();
    }
}

using TestLib for _T global;