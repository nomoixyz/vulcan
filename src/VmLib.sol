// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.7.0;

import "forge-std/Vm.sol";

type _T is bytes32;

struct Log {
    bytes32[] topics;
    bytes data;
    address emitter;
}

struct Rpc {
    string name;
    string url;
}

// TODO: most variable names and comments are the ones provided by the forge-std library, figure out if we should change/improve/remove some of them
// @dev Main entry point to vm functionality
library VmLib {
    uint256 internal constant VM_SLOT = uint256(keccak256("sest.vm.slot")); 
    Vm internal constant DEFAULT_VM = Vm(address(bytes20(uint160(uint256(keccak256('hevm cheat code'))))));

    function underlying() internal view returns(Vm _vm) {
        uint256 vmSlot = VM_SLOT;
        assembly {
            _vm := sload(vmSlot)
        }
    }

    function underlying(_T) internal view returns(Vm) {
        return underlying();
    }

    function setUnderlying(_T self, Vm _vm) internal returns(_T) {
        uint256 vmSlot = VM_SLOT;
        assembly {
            sstore(vmSlot, _vm)
        }
        return self;
    }

    function readStorage(_T, address who, bytes32 slot) internal view returns(bytes32) {
        return underlying().load(who, slot);
    }

    function sign(_T, uint256 privKey, bytes32 digest) internal view returns (uint8, bytes32, bytes32) {
        return underlying().sign(privKey, digest);
    }

    function deriveAddress(_T, uint256 privKey) internal view returns (address) {
        return underlying().addr(privKey);
    }

    function getNonce(_T, address who) internal view returns (uint64) {
        return getNonce(who);
    }

    function getNonce(address who) internal view returns (uint64) {
        return underlying().getNonce(who);
    }

    // Performs a foreign function call via the terminal, (stringInputs) => (result)
    function runCommand(_T, string[] calldata inputs) internal returns (bytes memory) {
        return underlying().ffi(inputs);
    }

    function setEnv(_T, string calldata name, string calldata value) internal {
        underlying().setEnv(name, value);
    }

    // Reads environment variables, (name) => (value)
    function envBool(string calldata name) internal view returns (bool) {
        return underlying().envBool(name);
    }
    function envUint(string calldata name) internal view returns (uint256) {
        return underlying().envUint(name);
    }
    function envInt(string calldata name) internal view returns (int256) {
        return underlying().envInt(name);
    }
    function envAddress(string calldata name) internal view returns (address) {
        return underlying().envAddress(name);
    }
    function envBytes32(string calldata name) internal view returns (bytes32) {
        return underlying().envBytes32(name);
    }
    function envString(string calldata name) internal view returns (string memory) {
        return underlying().envString(name);
    }
    function envBytes(string calldata name) internal view returns (bytes memory) {
        return underlying().envBytes(name);
    }
    // Reads environment variables as arrays, (name, delim) => (value[])
    function envBool(string calldata name, string calldata delim) internal view returns (bool[] memory) {
        return underlying().envBool(name, delim);
    }
    function envUint(string calldata name, string calldata delim) internal view returns (uint256[] memory) {
        return underlying().envUint(name, delim);
    }
    function envInt(string calldata name, string calldata delim) internal view returns (int256[] memory) {
        return underlying().envInt(name, delim);
    }
    function envAddress(string calldata name, string calldata delim) internal view returns (address[] memory) {
        return underlying().envAddress(name, delim);
    }
    function envBytes32(string calldata name, string calldata delim) internal view returns (bytes32[] memory) {
        return underlying().envBytes32(name, delim);
    }
    function envString(string calldata name, string calldata delim) internal view returns (string[] memory) {
        return underlying().envString(name, delim);
    }
    function envBytes(string calldata name, string calldata delim) internal view returns (bytes[] memory) {
        return underlying().envBytes(name, delim);
    }

    function recordStorage(_T) internal {
        underlying().record();
    }

    function getStorageAccesses(address who) internal returns (bytes32[] memory reads, bytes32[] memory writes) {
        return underlying().accesses(who);
    }

    // Gets the _creation_ bytecode from an artifact file. Takes in the relative path to the json file
    function getCode(_T, string calldata path) internal view returns (bytes memory) {
        return underlying().getCode(path);
    }
    // Gets the _deployed_ bytecode from an artifact file. Takes in the relative path to the json file
    function getDeployedCode(_T, string calldata path) internal view returns (bytes memory) {
        return underlying().getDeployedCode(path);
    }
    function label(_T, address who, string calldata lbl) internal {
        underlying().label(who, lbl);
    }
    // Using the address that calls the test contract, has the next call (at this call depth only) create a transaction that can later be signed and sent onchain
    function broadcast(_T) internal {
        underlying().broadcast();
    }
    // Has the next call (at this call depth only) create a transaction with the address provided as the sender that can later be signed and sent onchain
    function broadcast(_T, address from) internal {
        underlying().broadcast(from);
    }
    // Has the next call (at this call depth only) create a transaction with the private key provided as the sender that can later be signed and sent onchain
    function broadcast(_T, uint256 privKey) internal {
        underlying().broadcast(privKey);
    }
    // Using the address that calls the test contract, has all subsequent calls (at this call depth only) create transactions that can later be signed and sent onchain
    function startBroadcast(_T) internal {
        underlying().startBroadcast();
    }
    // Has all subsequent calls (at this call depth only) create transactions with the address provided that can later be signed and sent onchain
    function startBroadcast(_T, address from) internal {
        underlying().startBroadcast(from);
    }
    // Has all subsequent calls (at this call depth only) create transactions with the private key provided that can later be signed and sent onchain
    function startBroadcast(_T, uint256 privKey) internal {
        underlying().startBroadcast(privKey);
    }

    function setBlockTimestamp(_T self, uint256 ts) internal returns(_T) {
        underlying().warp(ts);
        return self;
    }

    function setBlockNumber(_T self, uint256 blockNumber) internal returns(_T) {
        underlying().roll(blockNumber);
        return self;
    }
    function setBlockBaseFee(_T self, uint256 baseFee) internal returns(_T) {
        underlying().fee(baseFee);
        return self;
    }

    function setBlockDifficulty(_T self, uint256 difficulty) internal returns(_T) {
        underlying().difficulty(difficulty);
        return self;
    }

    function setChainId(_T self, uint256 chainId) internal returns(_T){
        underlying().chainId(chainId);
        return self;
    }

    function setStorage(address self, bytes32 slot, bytes32 value) internal returns(address) {
        underlying().store(self, slot, value);
        return self;
    }

    function setNonce(_T, address addr, uint64 n) internal returns(address) {
        return setNonce(addr, n);
    }
    function setNonce(address self, uint64 n) internal returns(address) {
        underlying().setNonce(self, n);
        return self;
    }

    function setBalance(address self, uint256 bal) internal returns(address) {
        underlying().deal(self, bal);
        return self;
    }

    function impersonateOnce(_T, address sender) internal returns(address) {
        return impersonateOnce(sender);
    }

    function impersonateOnce(address self) internal returns(address) {
        underlying().prank(self);
        return self;
    }

    // Sets all subsequent calls' msg.sender to be the input address until `stopPrank` is called
    function impersonate(_T, address sender) internal returns(address) {
        return impersonate(sender);
    }

    // Sets all subsequent calls' msg.sender to be the input address until `stopPrank` is called
    function impersonate(address self) internal returns(address) {
        underlying().startPrank(self);
        return self;
    }

    // Sets the *next* call's msg.sender to be the input address, and the tx.origin to be the second input
    function impersonateOnce(_T, address sender, address origin) internal returns(address) {
        return impersonateOnce(sender, origin);
    }

    // Sets the *next* call's msg.sender to be the input address, and the tx.origin to be the second input
    function impersonateOnce(address self, address origin) internal returns(address) {
        underlying().prank(self, origin);
        return self;
    }

    // Sets all subsequent calls' msg.sender to be the input address until `stopPrank` is called, and the tx.origin to be the second input
    function impersonate(_T, address sender, address origin) internal returns(address) {
        return impersonate(sender, origin);
    }

    // Sets all subsequent calls' msg.sender to be the input address until `stopPrank` is called, and the tx.origin to be the second input
    function impersonate(address self, address origin) internal returns(address) {
        underlying().startPrank(self, origin);
        return self;
    }

    // Resets subsequent calls' msg.sender to be `address(this)`
    function stopImpersonate(_T) internal {
        underlying().stopPrank();
    }

    function assume(_T, bool condition) internal view {
        underlying().assume(condition);
    }
}

_T constant vm = _T.wrap(bytes32(uint256(0)));

using VmLib for _T global;
