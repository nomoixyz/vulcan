// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.7.0;

import { Vm } from "forge-std/Vm.sol";
import {Watcher} from "./Watcher.sol";

interface VulcanVmCommon {}
interface VulcanVmTest is VulcanVmCommon {}

/// @dev struct that represent a log
struct Log {
    bytes32[] topics;
    bytes data;
    address emitter;
}

/// @dev struct that represents an RPC endpoint
struct Rpc {
    string name;
    string url;
}

// TODO: most variable names and comments are the ones provided by the forge-std library, figure out if we should change/improve/remove some of them
/// @dev Main entry point to vm functionality
library vulcan {
    using vulcan for *;

    bytes32 constant GLOBAL_FAILED_SLOT = bytes32("failed");
    /// @dev sest VM storage slot
    uint256 internal constant VM_SLOT = uint256(keccak256("vulcan.vm.slot")); 
    /// @dev forge-std VM
    Vm internal constant HEVM = Vm(address(bytes20(uint160(uint256(keccak256('hevm cheat code'))))));

    /// @dev gets the underlying VM
    function vm() internal view returns(Vm _vm) {
        uint256 vmSlot = VM_SLOT;
        assembly {
            _vm := sload(vmSlot)
        }
    }

    /// @dev sets the underlying VM
    /// @return `self` so other methods can be chained
    function setVm(VulcanVmCommon self, Vm _vm) internal returns(VulcanVmCommon) {
        uint256 vmSlot = VM_SLOT;
        assembly {
            sstore(vmSlot, _vm)
        }
        return self;
    }

    /// @dev reads an storage slot from an adress and returns the content
    /// @param who the target address from which the storage slot will be read
    /// @param slot the storage slot to read
    /// @return the content of the storage at slot `slot` on the address `who`
    function readStorage(VulcanVmCommon, address who, bytes32 slot) internal view returns(bytes32) {
        return vm().load(who, slot);
    }


    /// @dev reads an storage slot from an adress and returns the content
    /// @param who the target address from which the storage slot will be read
    /// @param slot the storage slot to read
    /// @return the content of the storage at slot `slot` on the address `who`
    function readStorage(address who, bytes32 slot) internal view returns(bytes32) {
        return vm().load(who, slot);
    }

    /// @dev signs `digest` using `privKey`
    /// @param privKey the private key used to sign
    /// @param digest the data to sign
    /// @return signature in the form of (v, r, s)
    function sign(VulcanVmCommon, uint256 privKey, bytes32 digest) internal view returns (uint8, bytes32, bytes32) {
        return vm().sign(privKey, digest);
    }

    /// @dev obtains the address derived from `privKey`
    /// @param privKey the private key to derive
    /// @return the address derived from `privKey`
    function deriveAddress(VulcanVmCommon, uint256 privKey) internal view returns (address) {
        return vm().addr(privKey);
    }

    /// @dev obtains the nonce of the address `who`
    /// @param who the target address
    /// @return the nonce of address `who`
    function getNonce(VulcanVmCommon, address who) internal view returns (uint64) {
        return getNonce(who);
    }

    /// @dev obtains the nonce of the address `who`
    /// @param who the target address
    /// @return the nonce of address `who`
    function getNonce(address who) internal view returns (uint64) {
        return vm().getNonce(who);
    }

    /// @dev performs a foreign function call via the terminal, (stringInputs) => (result)
    /// @param inputs the command splitted into strings. eg ["mkdir", "-p", "tests"]
    /// @return the output of the command
    function runCommand(VulcanVmCommon, string[] calldata inputs) internal returns (bytes memory) {
        return vm().ffi(inputs);
    }

    /// @dev sets the value of the  environment variable with name `name` to `value`
    /// @param name the name of the environment variable
    /// @param value the new value of the environment variable
    function setEnv(VulcanVmCommon, string calldata name, string calldata value) internal {
        vm().setEnv(name, value);
    }

    /// @dev Reads the environment variable with name `name` and returns the value as `bool`
    /// @param name the name of the environment variable to read
    /// @return the value of the environment variable as `bool`
    function envBool(VulcanVmCommon, string calldata name) internal view returns (bool) {
        return vm().envBool(name);
    }

    /// @dev Reads the environment variable with name `name` and returns the value as `uint256`
    /// @param name the name of the environment variable to read
    /// @return the value of the environment variable as `uint256`
    function envUint(VulcanVmCommon, string calldata name) internal view returns (uint256) {
        return vm().envUint(name);
    }

    /// @dev Reads the environment variable with name `name` and returns the value as `int256`
    /// @param name the name of the environment variable to read
    /// @return the value of the environment variable as `int256`
    function envInt(VulcanVmCommon, string calldata name) internal view returns (int256) {
        return vm().envInt(name);
    }

    /// @dev Reads the environment variable with name `name` and returns the value as `address`
    /// @param name the name of the environment variable to read
    /// @return the value of the environment variable as `address`
    function envAddress(VulcanVmCommon, string calldata name) internal view returns (address) {
        return vm().envAddress(name);
    }

    /// @dev Reads the environment variable with name `name` and returns the value as `bytes32`
    /// @param name the name of the environment variable to read
    /// @return the value of the environment variable as `bytes32`
    function envBytes32(VulcanVmCommon, string calldata name) internal view returns (bytes32) {
        return vm().envBytes32(name);
    }

    /// @dev Reads the environment variable with name `name` and returns the value as `string`
    /// @param name the name of the environment variable to read
    /// @return the value of the environment variable as `string`
    function envString(VulcanVmCommon, string calldata name) internal view returns (string memory) {
        return vm().envString(name);
    }

    /// @dev Reads the environment variable with name `name` and returns the value as `bytes`
    /// @param name the name of the environment variable to read
    /// @return the value of the environment variable as `bytes`
    function envBytes(VulcanVmCommon, string calldata name) internal view returns (bytes memory) {
        return vm().envBytes(name);
    }

    /// @dev Reads the environment variable with name `name` and returns the value as `bool[]`
    /// @param name the name of the environment variable to read
    /// @param delim the delimiter used to split the values 
    /// @return the value of the environment variable as `bool[]`
    function envBool(VulcanVmCommon, string calldata name, string calldata delim) internal view returns (bool[] memory) {
        return vm().envBool(name, delim);
    }

    /// @dev Reads the environment variable with name `name` and returns the value as `uint256[]`
    /// @param name the name of the environment variable to read
    /// @param delim the delimiter used to split the values 
    /// @return the value of the environment variable as `uint256[]`
    function envUint(VulcanVmCommon, string calldata name, string calldata delim) internal view returns (uint256[] memory) {
        return vm().envUint(name, delim);
    }

    /// @dev Reads the environment variable with name `name` and returns the value as `int256[]`
    /// @param name the name of the environment variable to read
    /// @param delim the delimiter used to split the values 
    /// @return the value of the environment variable as `int256[]`
    function envInt(VulcanVmCommon, string calldata name, string calldata delim) internal view returns (int256[] memory) {
        return vm().envInt(name, delim);
    }

    /// @dev Reads the environment variable with name `name` and returns the value as `address[]`
    /// @param name the name of the environment variable to read
    /// @param delim the delimiter used to split the values 
    /// @return the value of the environment variable as `address[]`
    function envAddress(VulcanVmCommon, string calldata name, string calldata delim) internal view returns (address[] memory) {
        return vm().envAddress(name, delim);
    }

    /// @dev Reads the environment variable with name `name` and returns the value as `bytes32[]`
    /// @param name the name of the environment variable to read
    /// @param delim the delimiter used to split the values 
    /// @return the value of the environment variable as `bytes32[]`
    function envBytes32(VulcanVmCommon, string calldata name, string calldata delim) internal view returns (bytes32[] memory) {
        return vm().envBytes32(name, delim);
    }

    /// @dev Reads the environment variable with name `name` and returns the value as `string[]`
    /// @param name the name of the environment variable to read
    /// @param delim the delimiter used to split the values 
    /// @return the value of the environment variable as `string[]`
    function envString(VulcanVmCommon, string calldata name, string calldata delim) internal view returns (string[] memory) {
        return vm().envString(name, delim);
    }

    /// @dev Reads the environment variable with name `name` and returns the value as `bytes[]`
    /// @param name the name of the environment variable to read
    /// @param delim the delimiter used to split the values 
    /// @return the value of the environment variable as `bytes[]`
    function envBytes(VulcanVmCommon, string calldata name, string calldata delim) internal view returns (bytes[] memory) {
        return vm().envBytes(name, delim);
    }

    /// @dev records all storage reads and writes
    function recordStorage(VulcanVmCommon) internal {
        vm().record();
    }

    /// @dev obtains all reads and writes to the storage from address `who`
    /// @param who the target address to read all accesses to the storage
    /// @return reads and writes in the form of (bytes32[] reads, bytes32[] writes)
    function getStorageAccesses(VulcanVmCommon, address who) internal returns (bytes32[] memory reads, bytes32[] memory writes) {
        return vm().accesses(who);
    }

    /// @dev obtains all reads and writes to the storage from address `who`
    /// @param who the target address to read all accesses to the storage
    /// @return reads and writes in the form of (bytes32[] reads, bytes32[] writes)
    function getStorageAccesses(address who) internal returns (bytes32[] memory reads, bytes32[] memory writes) {
        return vm().accesses(who);
    }

    /// @dev Gets the creation bytecode from an artifact file. Takes in the relative path to the json file
    /// @param path the relative path to the json file
    /// @return the creation code
    function getCode(VulcanVmCommon, string calldata path) internal view returns (bytes memory) {
        return vm().getCode(path);
    }
    /// @dev Gets the deployed bytecode from an artifact file. Takes in the relative path to the json file
    /// @param path the relative path to the json file
    /// @return the deployed code
    function getDeployedCode(VulcanVmCommon, string calldata path) internal view returns (bytes memory) {
        return vm().getDeployedCode(path);
    }

    /// @dev labels the address `who` with label `lbl`
    /// @param who the address to label
    /// @param lbl the new label for address `who`
    function label(VulcanVmCommon, address who, string memory lbl) internal returns (address) {
        return label(who, lbl);
    }

    /// @dev labels the address `who` with label `lbl`
    /// @param who the address to label
    /// @param lbl the new label for address `who`
    function label(address who, string memory lbl) internal returns (address) {
        vm().label(who, lbl);
        return who;
    }

    /// @dev Using the address that calls the test contract, has the next call (at this call depth only) create a transaction that can later be signed and sent onchain
    function broadcast(VulcanVmCommon) internal {
        vm().broadcast();
    }

    /// @dev Has the next call (at this call depth only) create a transaction with the address provided as the sender that can later be signed and sent onchain
    /// @param from the sender of the transaction
    function broadcast(VulcanVmCommon, address from) internal {
        vm().broadcast(from);
    }

    /// @dev Has the next call (at this call depth only) create a transaction with the private key provided as the sender that can later be signed and sent onchain
    /// @param privKey the sender of the transaction as a private key
    function broadcast(VulcanVmCommon, uint256 privKey) internal {
        vm().broadcast(privKey);
    }

    /// @dev Using the address that calls the test contract, has all subsequent calls (at this call depth only) create transactions that can later be signed and sent onchain
    function startBroadcast(VulcanVmCommon) internal {
        vm().startBroadcast();
    }

    /// @dev Has all subsequent calls (at this call depth only) create transactions with the address provided that can later be signed and sent onchain
    /// @param from the sender of the transactions
    function startBroadcast(VulcanVmCommon, address from) internal {
        vm().startBroadcast(from);
    }

    /// @dev Has all subsequent calls (at this call depth only) create transactions with the private key provided that can later be signed and sent onchain
    /// @param privKey the sender of the transactions as a private key
    function startBroadcast(VulcanVmCommon, uint256 privKey) internal {
        vm().startBroadcast(privKey);
    }

    function stopBroadcast(VulcanVmCommon) internal {
        vm().stopBroadcast();
    }

    function readFile(VulcanVmCommon, string memory path) internal view returns (string memory) {
        return vm().readFile(path);
    }

    function readFileBinary(VulcanVmCommon, string memory path) external view returns (bytes memory) {
        return vm().readFileBinary(path);
    }

    function projectRoot(VulcanVmCommon) external view returns (string memory) {
        return vm().projectRoot();
    }

    function readLine(VulcanVmCommon, string calldata path) external view returns (string memory) {
        return vm().readLine(path);
    }

    function writeFile(VulcanVmCommon, string calldata path, string calldata data) external {
        vm().writeFile(path, data);
    }

    function writeFileBinary(VulcanVmCommon, string calldata path, bytes calldata data) external {
        vm().writeFileBinary(path, data);
    }
    function writeLine(VulcanVmCommon, string calldata path, string calldata data) external {
        vm().writeLine(path, data);
    }
    function closeFile(VulcanVmCommon, string calldata path) external {
        vm().closeFile(path);
    }
    function removeFile(VulcanVmCommon, string calldata path) external {
        vm().removeFile(path);
    }
    function toString(VulcanVmCommon, address value) external view returns (string memory) {
        return vm().toString(value);
    }
    function toString(VulcanVmCommon, bytes calldata value) external view returns (string memory) {
        return vm().toString(value);
    }

    function toString(VulcanVmCommon, bytes32 value) external view returns (string memory) {
        return vm().toString(value);
    }
    function toString(VulcanVmCommon, bool value) external view returns (string memory) {
        return vm().toString(value);
    }
    function toString(VulcanVmCommon, uint256 value) external view returns (string memory) {
        return vm().toString(value);
    }
    function toString(VulcanVmCommon, int256 value) external view returns (string memory) {
        return vm().toString(value);
    }
    function parseBytes(VulcanVmCommon, string calldata value) external view returns (bytes memory) {
        return vm().parseBytes(value);
    }
    function parseAddress(VulcanVmCommon, string calldata value) external view returns (address) {
        return vm().parseAddress(value);
    }
    function parseUint(VulcanVmCommon, string calldata value) external view returns (uint256) {
        return vm().parseUint(value);
    }
    function parseInt(VulcanVmCommon, string calldata value) external view returns (int256) {
        return vm().parseInt(value);
    }
    function parseBytes32(VulcanVmCommon, string calldata value) external view returns (bytes32) {
        return vm().parseBytes32(value);
    }
    function parseBool(VulcanVmCommon, string calldata value) external view returns (bool) {
        return vm().parseBool(value);
    }
    function recordLogs(VulcanVmCommon) external {
        vm().recordLogs();
    }
    function getRecordedLogs(VulcanVmCommon) external returns (Log[] memory logs) {
        Vm.Log[] memory recorded = vm().getRecordedLogs();
        assembly {
            logs := recorded
        }
    }
    function deriveKey(VulcanVmCommon, string calldata mnemonicOrPath, uint32 index) external view returns (uint256) {
        return vm().deriveKey(mnemonicOrPath, index);
    }
    function deriveKey(VulcanVmCommon, string calldata mnemonicOrPath, string calldata derivationPath, uint32 index) external view returns (uint256) {
        return vm().deriveKey(mnemonicOrPath, derivationPath, index);
    }

    function rememberKey(VulcanVmCommon, uint256 privKey) external returns (address) {
        return vm().rememberKey(privKey);
    }

    function assume(VulcanVmCommon, bool condition) internal view {
        vm().assume(condition);
    }

    /// @dev creates a wrapped address from `name`
    function createAddress(VulcanVmCommon self, string memory name) internal returns (address) {
        return createAddress(self, name, name);
    }

    /// @dev creates a wrapped address from `name` and labels it with `lbl`
    function createAddress(VulcanVmCommon self, string memory name, string memory lbl) internal returns (address) {
        address addr = deriveAddress(self, uint256(keccak256(abi.encodePacked(name))));

        return label(addr, lbl);
    }

    /* VulcanVmTest */

    /// @dev sets the `block.timestamp` to `ts`
    /// @param ts the new block timestamp
    function setBlockTimestamp(VulcanVmTest self, uint256 ts) internal returns(VulcanVmTest) {
        vm().warp(ts);
        return self;
    }

    /// @dev sets the `block.number` to `blockNumber`
    /// @param blockNumber the new block number
    function setBlockNumber(VulcanVmTest self, uint256 blockNumber) internal returns(VulcanVmTest) {
        vm().roll(blockNumber);
        return self;
    }

    /// @dev sets the `block.basefee` to `baseFee`
    /// @param baseFee the new block base fee
    function setBlockBaseFee(VulcanVmTest self, uint256 baseFee) internal returns(VulcanVmTest) {
        vm().fee(baseFee);
        return self;
    }

    /// @dev sets the `block.difficulty` to `difficulty`
    /// @param difficulty the new block difficulty
    function setBlockDifficulty(VulcanVmTest self, uint256 difficulty) internal returns(VulcanVmTest) {
        vm().difficulty(difficulty);
        return self;
    }

    /// @dev sets the `block.chainid` to `chainId`
    /// @param chainId the new block chain id
    function setChainId(VulcanVmTest self, uint256 chainId) internal returns(VulcanVmTest){
        vm().chainId(chainId);
        return self;
    }

    /// @dev sets the value of the storage slot `slot` to `value`
    /// @param self the address that will be updated
    /// @param slot the slot to update
    /// @param value the new value of the slot `slot` on the address `self`
    /// @return the modified address so other methods can be chained
    function setStorage(VulcanVmTest, address self, bytes32 slot, bytes32 value) internal returns(address) {
        vm().store(self, slot, value);
        return self;
    }

    /// @dev sets the value of the storage slot `slot` to `value`
    /// @param self the address that will be updated
    /// @param slot the slot to update
    /// @param value the new value of the slot `slot` on the address `self`
    /// @return the modified address so other methods can be chained
    function setStorage(address self, bytes32 slot, bytes32 value) internal returns(address) {
        vm().store(self, slot, value);
        return self;
    }

    /// @dev sets the nonce of the address `addr` to `n`
    /// @param addr the address that will be updated
    /// @param n the new nonce
    /// @return the address that was updated
    function setNonce(VulcanVmTest, address addr, uint64 n) internal returns(address) {
        return setNonce(addr, n);
    }

    /// @dev sets the nonce of the address `addr` to `n`
    /// @param self the address that will be updated
    /// @param n the new nonce
    /// @return the address that was updated
    function setNonce(address self, uint64 n) internal returns(address) {
        vm().setNonce(self, n);
        return self;
    }

    /// @dev sets the next call's `msg.sender` to `sender`
    /// @param sender the address to set the `msg.sender`
    /// @return the `msg.sender` for the next call
    function impersonateOnce(VulcanVmTest, address sender) internal returns(address) {
        return impersonateOnce(sender);
    }

    /// @dev sets the next call's `msg.sender` to `sender`
    /// @param self the address to set the `msg.sender`
    /// @return the `msg.sender` for the next call
    function impersonateOnce(address self) internal returns(address) {
        vm().prank(self);
        return self;
    }

    /// @dev sets all subsequent call's `msg.sender` to `sender` until `stopPrank` is called
    /// @param sender the address to set the `msg.sender`
    /// @return the `msg.sender` for the next calls
    function impersonate(VulcanVmTest, address sender) internal returns(address) {
        return impersonate(sender);
    }

    /// @dev sets all subsequent call's `msg.sender` to `sender` until `stopPrank` is called
    /// @param self the address to set the `msg.sender`
    /// @return the `msg.sender` for the next calls
    function impersonate(address self) internal returns(address) {
        vm().startPrank(self);
        return self;
    }

    /// @dev sets the next call's `msg.sender` to `sender` and `tx.origin` to `origin`
    /// @param sender the address to set the `msg.sender`
    /// @param origin the address to set the `tx.origin`
    /// @return the `msg.sender` for the next call
    function impersonateOnce(VulcanVmTest, address sender, address origin) internal returns(address) {
        return impersonateOnce(sender, origin);
    }

    /// @dev sets the next call's `msg.sender` to `sender` and `tx.origin` to `origin`
    /// @param self the address to set the `msg.sender`
    /// @param origin the address to set the `tx.origin`
    /// @return the `msg.sender` for the next call
    function impersonateOnce(address self, address origin) internal returns(address) {
        vm().prank(self, origin);
        return self;
    }

    /// @dev sets all subsequent call's `msg.sender` to `sender` and `tx.origin` to `origin` until `stopPrank` is called
    /// @param sender the address to set the `msg.sender`
    /// @param origin the address to set the `tx.origin`
    /// @return the `msg.sender` for the next calls
    function impersonate(VulcanVmTest, address sender, address origin) internal returns(address) {
        return impersonate(sender, origin);
    }

    /// @dev sets all subsequent call's `msg.sender` to `sender` and `tx.origin` to `origin` until `stopPrank` is called
    /// @param self the address to set the `msg.sender`
    /// @param origin the address to set the `tx.origin`
    /// @return the `msg.sender` for the next calls
    function impersonate(address self, address origin) internal returns(address) {
        vm().startPrank(self, origin);
        return self;
    }

    /// @dev resets the values of `msg.sender` and `tx.origin` to their original values
    function stopImpersonate(VulcanVmTest) internal {
        vm().stopPrank();
    }

    /// @dev sets the balance of the address `addr` to `bal`
    /// @param self the address that will be updated
    /// @param bal the new balance
    /// @return the address that was updated
    function setBalance(VulcanVmTest, address self, uint256 bal) internal returns(address) {
        return setBalance(self, bal);
    }

    /// @dev sets the balance of the address `addr` to `bal`
    /// @param self the address that will be updated
    /// @param bal the new balance
    /// @return the address that was updated
    function setBalance(address self, uint256 bal) internal returns(address) {
        vm().deal(self, bal);
        return self;
    }

    function setCode(VulcanVmTest, address self, bytes memory code) internal returns(address) {
        return setCode(self, code);
    }

    function setCode(address self, bytes memory code) internal returns(address) {
        vm().etch(self, code);
        return self;
    }

    /* TODO: SHOULD WE ADD THE expectX HERE ? */

    function setBlockCoinbase(VulcanVmTest self, address who) internal returns (VulcanVmTest){
        vm().coinbase(who);
        return self;
    }
    
    function snapshot(VulcanVmTest) external returns (uint256) {
        return vm().snapshot();
    }

    function revertToSnapshot(VulcanVmTest, uint256 snapshotId) external returns (bool) {
        return vm().revertTo(snapshotId);
    }

    function createFork(VulcanVmTest, string memory endpoint, uint256 blockNumber) external returns (uint256) {
        return vm().createFork(endpoint, blockNumber);
    }
    function createFork(VulcanVmTest, string memory endpoint) external returns (uint256) {
        return vm().createFork(endpoint);
    }
    function createFork(VulcanVmTest, string memory endpoint, bytes32 txHash) external returns (uint256) {
        return vm().createFork(endpoint, txHash);
    }
    function createSelectFork(VulcanVmTest, string memory endpoint, uint256 blockNumber) external returns (uint256) {
        return vm().createSelectFork(endpoint, blockNumber);
    }
    function createSelectFork(VulcanVmTest, string memory endpoint, bytes32 txHash) external returns (uint256) {
        return vm().createSelectFork(endpoint, txHash);
    }
    function createSelectFork(VulcanVmTest, string memory endpoint) external returns (uint256) {
        return vm().createSelectFork(endpoint);
    }
    function selectFork(VulcanVmTest, uint256 forkId) external {
        return vm().selectFork(forkId);
    }
    function activeFork(VulcanVmTest) external view returns (uint256) {
        return vm().activeFork();
    }
    function rollFork(VulcanVmTest, uint256 blockNumber) external {
        return vm().rollFork(blockNumber);
    }
    function rollFork(VulcanVmTest, bytes32 txHash) external {
        return vm().rollFork(txHash);
    }
    function rollFork(VulcanVmTest, uint256 forkId, uint256 blockNumber) external {
        return vm().rollFork(forkId, blockNumber);
    }
    function rollFork(VulcanVmTest, uint256 forkId, bytes32 txHash) external {
        return vm().rollFork(forkId, txHash);
    }
    function makePersistent(VulcanVmTest, address who) external {
        return vm().makePersistent(who);
    }
    function makePersistent(VulcanVmTest, address who1, address who2) external {
        return vm().makePersistent(who1, who2);
    }
    function makePersistent(VulcanVmTest, address who1, address who2, address who3) external {
        return vm().makePersistent(who1, who2, who3);
    }
    function makePersistent(VulcanVmTest, address[] memory whos) external {
        return vm().makePersistent(whos);
    }
    function revokePersistent(VulcanVmTest, address who) external {
        return vm().revokePersistent(who);
    }
    function revokePersistent(VulcanVmTest, address[] memory whos) external {
        return vm().revokePersistent(whos);
    }

    function isPersistent(VulcanVmTest, address who) external view returns (bool) {
        return vm().isPersistent(who);
    }
    function allowCheatcodes(VulcanVmTest, address who) external {
        return vm().allowCheatcodes(who);
    }
    function transact(VulcanVmTest, bytes32 txHash) external {
        return vm().transact(txHash);
    }
    function transact(VulcanVmTest, uint256 forkId, bytes32 txHash) external {
        return vm().transact(forkId, txHash);
    }

    function failed() internal view returns (bool) {
        bytes32 globalFailed = address(HEVM).readStorage(GLOBAL_FAILED_SLOT);
        return globalFailed == bytes32(uint256(1));
    } 

    function fail() internal {
        address(HEVM).setStorage(GLOBAL_FAILED_SLOT, bytes32(uint256(1)));
    }

    function clearFailure() internal {
        address(HEVM).setStorage(GLOBAL_FAILED_SLOT, bytes32(uint256(0)));
    }

    function watch(VulcanVmTest, address payable _target) internal returns (Watcher) {
        Watcher watcher = new Watcher();

        bytes memory targetCode = _target.code;

        // Switcheroo
        _target.setCode(address(watcher).code);
        address(watcher).setCode(targetCode);

        return Watcher(_target);
    }

}
