// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.7.0;

import "forge-std/Vm.sol";

type _T is bytes32;

/// @notice struct that represent a log
struct Log {
    bytes32[] topics;
    bytes data;
    address emitter;
}

/// @notice struct that represents an RPC endpoint
struct Rpc {
    string name;
    string url;
}

// TODO: most variable names and comments are the ones provided by the forge-std library, figure out if we should change/improve/remove some of them
/// @dev Main entry point to vm functionality
library VmLib {
    /// @notice sest VM storage slot
    uint256 internal constant VM_SLOT = uint256(keccak256("sest.vm.slot")); 
    /// @notice forge-std VM
    Vm internal constant DEFAULT_VM = Vm(address(bytes20(uint160(uint256(keccak256('hevm cheat code'))))));

    /// @notice gets the underlying VM
    function underlying() internal view returns(Vm _vm) {
        uint256 vmSlot = VM_SLOT;
        assembly {
            _vm := sload(vmSlot)
        }
    }

    /// @notice extends the `_T` type so it can obtain the underlying VM
    function underlying(_T) internal view returns(Vm) {
        return underlying();
    }

    /// @notice sets the underlying VM
    /// @return `self` so other methods can be chained
    function setUnderlying(_T self, Vm _vm) internal returns(_T) {
        uint256 vmSlot = VM_SLOT;
        assembly {
            sstore(vmSlot, _vm)
        }
        return self;
    }

    /// @notice reads an storage slot from an adress and returns the content
    /// @param who the target address from which the storage slot will be read
    /// @param slot the storage slot to read
    /// @return the content of the storage at slot `slot` on the address `who`
    function readStorage(_T, address who, bytes32 slot) internal view returns(bytes32) {
        return underlying().load(who, slot);
    }

    /// @notice signs `digest` using `privKey`
    /// @param privKey the private key used to sign
    /// @param digest the data to sign
    /// @return signature in the form of (v, r, s)
    function sign(_T, uint256 privKey, bytes32 digest) internal view returns (uint8, bytes32, bytes32) {
        return underlying().sign(privKey, digest);
    }

    /// @notice obtains the address derived from `privKey`
    /// @param privKey the private key to derive
    /// @return the address derived from `privKey`
    function deriveAddress(_T, uint256 privKey) internal view returns (address) {
        return underlying().addr(privKey);
    }

    /// @notice obtains the nonce of the address `who`
    /// @param who the target address
    /// @return the nonce of address `who`
    function getNonce(_T, address who) internal view returns (uint64) {
        return getNonce(who);
    }

    /// @notice obtains the nonce of the address `who`
    /// @param who the target address
    /// @return the nonce of address `who`
    function getNonce(address who) internal view returns (uint64) {
        return underlying().getNonce(who);
    }

    /// @notice performs a foreign function call via the terminal, (stringInputs) => (result)
    /// @param inputs the command splitted into strings. eg ["mkdir", "-p", "tests"]
    /// @return the output of the command
    function runCommand(_T, string[] calldata inputs) internal returns (bytes memory) {
        return underlying().ffi(inputs);
    }

    /// @notice sets the value of the  environment variable with name `name` to `value`
    /// @param name the name of the environment variable
    /// @param value the new value of the environment variable
    function setEnv(_T, string calldata name, string calldata value) internal {
        underlying().setEnv(name, value);
    }

    /// @notice Reads the environment variable with name `name` and returns the value as `bool`
    /// @param name the name of the environment variable to read
    /// @return the value of the environment variable as `bool`
    function envBool(string calldata name) internal view returns (bool) {
        return underlying().envBool(name);
    }

    /// @notice Reads the environment variable with name `name` and returns the value as `uint256`
    /// @param name the name of the environment variable to read
    /// @return the value of the environment variable as `uint256`
    function envUint(string calldata name) internal view returns (uint256) {
        return underlying().envUint(name);
    }

    /// @notice Reads the environment variable with name `name` and returns the value as `int256`
    /// @param name the name of the environment variable to read
    /// @return the value of the environment variable as `int256`
    function envInt(string calldata name) internal view returns (int256) {
        return underlying().envInt(name);
    }

    /// @notice Reads the environment variable with name `name` and returns the value as `address`
    /// @param name the name of the environment variable to read
    /// @return the value of the environment variable as `address`
    function envAddress(string calldata name) internal view returns (address) {
        return underlying().envAddress(name);
    }

    /// @notice Reads the environment variable with name `name` and returns the value as `bytes32`
    /// @param name the name of the environment variable to read
    /// @return the value of the environment variable as `bytes32`
    function envBytes32(string calldata name) internal view returns (bytes32) {
        return underlying().envBytes32(name);
    }

    /// @notice Reads the environment variable with name `name` and returns the value as `string`
    /// @param name the name of the environment variable to read
    /// @return the value of the environment variable as `string`
    function envString(string calldata name) internal view returns (string memory) {
        return underlying().envString(name);
    }

    /// @notice Reads the environment variable with name `name` and returns the value as `bytes`
    /// @param name the name of the environment variable to read
    /// @return the value of the environment variable as `bytes`
    function envBytes(string calldata name) internal view returns (bytes memory) {
        return underlying().envBytes(name);
    }

    /// @notice Reads the environment variable with name `name` and returns the value as `bool[]`
    /// @param name the name of the environment variable to read
    /// @param delim the delimiter used to split the values 
    /// @return the value of the environment variable as `bool[]`
    function envBool(string calldata name, string calldata delim) internal view returns (bool[] memory) {
        return underlying().envBool(name, delim);
    }

    /// @notice Reads the environment variable with name `name` and returns the value as `uint256[]`
    /// @param name the name of the environment variable to read
    /// @param delim the delimiter used to split the values 
    /// @return the value of the environment variable as `uint256[]`
    function envUint(string calldata name, string calldata delim) internal view returns (uint256[] memory) {
        return underlying().envUint(name, delim);
    }

    /// @notice Reads the environment variable with name `name` and returns the value as `int256[]`
    /// @param name the name of the environment variable to read
    /// @param delim the delimiter used to split the values 
    /// @return the value of the environment variable as `int256[]`
    function envInt(string calldata name, string calldata delim) internal view returns (int256[] memory) {
        return underlying().envInt(name, delim);
    }

    /// @notice Reads the environment variable with name `name` and returns the value as `address[]`
    /// @param name the name of the environment variable to read
    /// @param delim the delimiter used to split the values 
    /// @return the value of the environment variable as `address[]`
    function envAddress(string calldata name, string calldata delim) internal view returns (address[] memory) {
        return underlying().envAddress(name, delim);
    }

    /// @notice Reads the environment variable with name `name` and returns the value as `bytes32[]`
    /// @param name the name of the environment variable to read
    /// @param delim the delimiter used to split the values 
    /// @return the value of the environment variable as `bytes32[]`
    function envBytes32(string calldata name, string calldata delim) internal view returns (bytes32[] memory) {
        return underlying().envBytes32(name, delim);
    }

    /// @notice Reads the environment variable with name `name` and returns the value as `string[]`
    /// @param name the name of the environment variable to read
    /// @param delim the delimiter used to split the values 
    /// @return the value of the environment variable as `string[]`
    function envString(string calldata name, string calldata delim) internal view returns (string[] memory) {
        return underlying().envString(name, delim);
    }

    /// @notice Reads the environment variable with name `name` and returns the value as `bytes[]`
    /// @param name the name of the environment variable to read
    /// @param delim the delimiter used to split the values 
    /// @return the value of the environment variable as `bytes[]`
    function envBytes(string calldata name, string calldata delim) internal view returns (bytes[] memory) {
        return underlying().envBytes(name, delim);
    }

    /// @notice records all storage reads and writes
    function recordStorage(_T) internal {
        underlying().record();
    }

    /// @notice obtains all reads and writes to the storage from address `who`
    /// @param who the target address to read all accesses to the storage
    /// @return reads and writes in the form of (bytes32[] reads, bytes32[] writes)
    function getStorageAccesses(address who) internal returns (bytes32[] memory reads, bytes32[] memory writes) {
        return underlying().accesses(who);
    }

    /// @notice Gets the creation bytecode from an artifact file. Takes in the relative path to the json file
    /// @param path the relative path to the json file
    /// @return the creation code
    function getCode(_T, string calldata path) internal view returns (bytes memory) {
        return underlying().getCode(path);
    }
    /// @notice Gets the deployed bytecode from an artifact file. Takes in the relative path to the json file
    /// @param path the relative path to the json file
    /// @return the deployed code
    function getDeployedCode(_T, string calldata path) internal view returns (bytes memory) {
        return underlying().getDeployedCode(path);
    }

    /// @notice labels the address `who` with label `lbl`
    /// @param who the address to label
    /// @param lbl the new label for address `who`
    function label(_T, address who, string calldata lbl) internal {
        underlying().label(who, lbl);
    }

    /// @notice Using the address that calls the test contract, has the next call (at this call depth only) create a transaction that can later be signed and sent onchain
    function broadcast(_T) internal {
        underlying().broadcast();
    }

    /// @notice Has the next call (at this call depth only) create a transaction with the address provided as the sender that can later be signed and sent onchain
    /// @param from the sender of the transaction
    function broadcast(_T, address from) internal {
        underlying().broadcast(from);
    }

    /// @notice Has the next call (at this call depth only) create a transaction with the private key provided as the sender that can later be signed and sent onchain
    /// @param privKey the sender of the transaction as a private key
    function broadcast(_T, uint256 privKey) internal {
        underlying().broadcast(privKey);
    }

    /// @notice Using the address that calls the test contract, has all subsequent calls (at this call depth only) create transactions that can later be signed and sent onchain
    function startBroadcast(_T) internal {
        underlying().startBroadcast();
    }

    /// @notice Has all subsequent calls (at this call depth only) create transactions with the address provided that can later be signed and sent onchain
    /// @param from the sender of the transactions
    function startBroadcast(_T, address from) internal {
        underlying().startBroadcast(from);
    }

    /// @notice Has all subsequent calls (at this call depth only) create transactions with the private key provided that can later be signed and sent onchain
    /// @param privKey the sender of the transactions as a private key
    function startBroadcast(_T, uint256 privKey) internal {
        underlying().startBroadcast(privKey);
    }

    /// @notice sets the `block.timestamp` to `ts`
    /// @param ts the new block timestamp
    function setBlockTimestamp(_T self, uint256 ts) internal returns(_T) {
        underlying().warp(ts);
        return self;
    }

    /// @notice sets the `block.number` to `blockNumber`
    /// @param blockNumber the new block number
    function setBlockNumber(_T self, uint256 blockNumber) internal returns(_T) {
        underlying().roll(blockNumber);
        return self;
    }

    /// @notice sets the `block.basefee` to `baseFee`
    /// @param baseFee the new block base fee
    function setBlockBaseFee(_T self, uint256 baseFee) internal returns(_T) {
        underlying().fee(baseFee);
        return self;
    }

    /// @notice sets the `block.difficulty` to `difficulty`
    /// @param difficulty the new block difficulty
    function setBlockDifficulty(_T self, uint256 difficulty) internal returns(_T) {
        underlying().difficulty(difficulty);
        return self;
    }

    /// @notice sets the `block.chainid` to `chainId`
    /// @param chainId the new block chain id
    function setChainId(_T self, uint256 chainId) internal returns(_T){
        underlying().chainId(chainId);
        return self;
    }

    /// @notice sets the value of the storage slot `slot` to `value`
    /// @param self the address that will be updated
    /// @param slot the slot to update
    /// @param value the new value of the slot `slot` on the address `self`
    /// @return the modified address so other methods can be chained
    function setStorage(address self, bytes32 slot, bytes32 value) internal returns(address) {
        underlying().store(self, slot, value);
        return self;
    }

    /// @notice sets the nonce of the address `addr` to `n`
    /// @param addr the address that will be updated
    /// @param n the new nonce
    /// @return the address that was updated
    function setNonce(_T, address addr, uint64 n) internal returns(address) {
        return setNonce(addr, n);
    }

    /// @notice sets the nonce of the address `addr` to `n`
    /// @param self the address that will be updated
    /// @param n the new nonce
    /// @return the address that was updated so other methods can be chained
    function setNonce(address self, uint64 n) internal returns(address) {
        underlying().setNonce(self, n);
        return self;
    }

    /// @notice sets the balance of the address `addr` to `bal`
    /// @param addr the address that will be updated
    /// @param bal the new balance
    /// @return the address that was updated
    function setBalance(address self, uint256 bal) internal returns(address) {
        underlying().deal(self, bal);
        return self;
    }

    /// @notice sets the next call's `msg.sender` to `sender`
    /// @param sender the address to set the `msg.sender`
    /// @return the `msg.sender` for the next call
    function impersonateOnce(_T, address sender) internal returns(address) {
        return impersonateOnce(sender);
    }

    /// @notice sets the next call's `msg.sender` to `sender`
    /// @param self the address to set the `msg.sender`
    /// @return the `msg.sender` for the next call
    function impersonateOnce(address self) internal returns(address) {
        underlying().prank(self);
        return self;
    }

    /// @notice sets all subsequent call's `msg.sender` to `sender` until `stopPrank` is called
    /// @param sender the address to set the `msg.sender`
    /// @return the `msg.sender` for the next calls
    function impersonate(_T, address sender) internal returns(address) {
        return impersonate(sender);
    }

    /// @notice sets all subsequent call's `msg.sender` to `sender` until `stopPrank` is called
    /// @param self the address to set the `msg.sender`
    /// @return the `msg.sender` for the next calls
    function impersonate(address self) internal returns(address) {
        underlying().startPrank(self);
        return self;
    }

    /// @notice sets the next call's `msg.sender` to `sender` and `tx.origin` to `origin`
    /// @param sender the address to set the `msg.sender`
    /// @param origin the address to set the `tx.origin`
    /// @return the `msg.sender` for the next call
    function impersonateOnce(_T, address sender, address origin) internal returns(address) {
        return impersonateOnce(sender, origin);
    }

    /// @notice sets the next call's `msg.sender` to `sender` and `tx.origin` to `origin`
    /// @param self the address to set the `msg.sender`
    /// @param origin the address to set the `tx.origin`
    /// @return the `msg.sender` for the next call
    function impersonateOnce(address self, address origin) internal returns(address) {
        underlying().prank(self, origin);
        return self;
    }

    /// @notice sets all subsequent call's `msg.sender` to `sender` and `tx.origin` to `origin` until `stopPrank` is called
    /// @param sender the address to set the `msg.sender`
    /// @param origin the address to set the `tx.origin`
    /// @return the `msg.sender` for the next calls
    function impersonate(_T, address sender, address origin) internal returns(address) {
        return impersonate(sender, origin);
    }

    /// @notice sets all subsequent call's `msg.sender` to `sender` and `tx.origin` to `origin` until `stopPrank` is called
    /// @param self the address to set the `msg.sender`
    /// @param origin the address to set the `tx.origin`
    /// @return the `msg.sender` for the next calls
    function impersonate(address self, address origin) internal returns(address) {
        underlying().startPrank(self, origin);
        return self;
    }

    /// @notice resets the values of `msg.sender` and `tx.origin` to their original values
    function stopImpersonate(_T) internal {
        underlying().stopPrank();
    }

    function assume(_T, bool condition) internal view {
        underlying().assume(condition);
    }
}

_T constant vm = _T.wrap(bytes32(uint256(0)));

using VmLib for _T global;
