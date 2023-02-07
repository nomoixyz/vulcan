// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.7.0;

import { Vm as Hevm } from "forge-std/Vm.sol";
import {Watcher} from "./Watcher.sol";

interface VulcanVmSafe {}
interface VulcanVm is VulcanVmSafe {}

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

struct FsMetadata {
    bool isDir;
    bool isSymlink;
    uint256 length;
    bool readOnly;
    uint256 modified;
    uint256 accessed;
    uint256 created;
}

struct Watchers {
    mapping(address => Watcher) map;
}

struct Fork {
    uint256 id;
}

// TODO: most variable names and comments are the ones provided by the forge-std library, figure out if we should change/improve/remove some of them
/// @dev Main entry point to vm functionality
library vulcan {
    using vulcan for *;

    bytes32 constant GLOBAL_FAILED_SLOT = bytes32("failed");
    bytes32 constant VM_WATCHERS_SLOT = bytes32("vulcan.vm.watchers.slot");

    /// @dev forge-std VM
    Hevm internal constant hevm = Hevm(address(bytes20(uint160(uint256(keccak256('hevm cheat code'))))));

    // This address doesn't contain any code
    VulcanVm internal constant vm = VulcanVm(address(bytes20(uint160(uint256(keccak256('vulcan.vm.address'))))));


    /// @dev reads an storage slot from an adress and returns the content
    /// @param who the target address from which the storage slot will be read
    /// @param slot the storage slot to read
    /// @return the content of the storage at slot `slot` on the address `who`
    function readStorage(VulcanVmSafe, address who, bytes32 slot) internal view returns(bytes32) {
        return hevm.load(who, slot);
    }

    /// @dev reads an storage slot from an adress and returns the content
    /// @param who the target address from which the storage slot will be read
    /// @param slot the storage slot to read
    /// @return the content of the storage at slot `slot` on the address `who`
    function readStorage(address who, bytes32 slot) internal view returns(bytes32) {
        return hevm.load(who, slot);
    }

    /// @dev signs `digest` using `privKey`
    /// @param privKey the private key used to sign
    /// @param digest the data to sign
    /// @return signature in the form of (v, r, s)
    function sign(VulcanVmSafe, uint256 privKey, bytes32 digest) internal pure returns (uint8, bytes32, bytes32) {
        return hevm.sign(privKey, digest);
    }

    /// @dev obtains the address derived from `privKey`
    /// @param privKey the private key to derive
    /// @return the address derived from `privKey`
    function deriveAddress(VulcanVmSafe, uint256 privKey) internal pure returns (address) {
        return hevm.addr(privKey);
    }

    /// @dev obtains the nonce of the address `who`
    /// @param who the target address
    /// @return the nonce of address `who`
    function getNonce(VulcanVmSafe, address who) internal view returns (uint64) {
        return getNonce(who);
    }

    /// @dev obtains the nonce of the address `who`
    /// @param who the target address
    /// @return the nonce of address `who`
    function getNonce(address who) internal view returns (uint64) {
        return hevm.getNonce(who);
    }

    /// @dev performs a foreign function call via the terminal, (stringInputs) => (result)
    /// @param inputs the command splitted into strings. eg ["mkdir", "-p", "tests"]
    /// @return the output of the command
    function runCommand(VulcanVmSafe, string[] memory inputs) internal returns (bytes memory) {
        return hevm.ffi(inputs);
    }

    /// @dev sets the value of the  environment variable with name `name` to `value`
    /// @param name the name of the environment variable
    /// @param value the new value of the environment variable
    function setEnv(VulcanVmSafe, string memory name, string memory value) internal {
        hevm.setEnv(name, value);
    }

    /// @dev Reads the environment variable with name `name` and returns the value as `bool`
    /// @param name the name of the environment variable to read
    /// @return the value of the environment variable as `bool`
    function envBool(VulcanVmSafe, string memory name) internal view returns (bool) {
        return hevm.envBool(name);
    }

    /// @dev Reads the environment variable with name `name` and returns the value as `uint256`
    /// @param name the name of the environment variable to read
    /// @return the value of the environment variable as `uint256`
    function envUint(VulcanVmSafe, string memory name) internal view returns (uint256) {
        return hevm.envUint(name);
    }

    /// @dev Reads the environment variable with name `name` and returns the value as `int256`
    /// @param name the name of the environment variable to read
    /// @return the value of the environment variable as `int256`
    function envInt(VulcanVmSafe, string memory name) internal view returns (int256) {
        return hevm.envInt(name);
    }

    /// @dev Reads the environment variable with name `name` and returns the value as `address`
    /// @param name the name of the environment variable to read
    /// @return the value of the environment variable as `address`
    function envAddress(VulcanVmSafe, string memory name) internal view returns (address) {
        return hevm.envAddress(name);
    }

    /// @dev Reads the environment variable with name `name` and returns the value as `bytes32`
    /// @param name the name of the environment variable to read
    /// @return the value of the environment variable as `bytes32`
    function envBytes32(VulcanVmSafe, string memory name) internal view returns (bytes32) {
        return hevm.envBytes32(name);
    }

    /// @dev Reads the environment variable with name `name` and returns the value as `string`
    /// @param name the name of the environment variable to read
    /// @return the value of the environment variable as `string`
    function envString(VulcanVmSafe, string memory name) internal view returns (string memory) {
        return hevm.envString(name);
    }

    /// @dev Reads the environment variable with name `name` and returns the value as `bytes`
    /// @param name the name of the environment variable to read
    /// @return the value of the environment variable as `bytes`
    function envBytes(VulcanVmSafe, string memory name) internal view returns (bytes memory) {
        return hevm.envBytes(name);
    }

    /// @dev Reads the environment variable with name `name` and returns the value as `bool[]`
    /// @param name the name of the environment variable to read
    /// @param delim the delimiter used to split the values 
    /// @return the value of the environment variable as `bool[]`
    function envBool(VulcanVmSafe, string memory name, string memory delim) internal view returns (bool[] memory) {
        return hevm.envBool(name, delim);
    }

    /// @dev Reads the environment variable with name `name` and returns the value as `uint256[]`
    /// @param name the name of the environment variable to read
    /// @param delim the delimiter used to split the values 
    /// @return the value of the environment variable as `uint256[]`
    function envUint(VulcanVmSafe, string memory name, string memory delim) internal view returns (uint256[] memory) {
        return hevm.envUint(name, delim);
    }

    /// @dev Reads the environment variable with name `name` and returns the value as `int256[]`
    /// @param name the name of the environment variable to read
    /// @param delim the delimiter used to split the values 
    /// @return the value of the environment variable as `int256[]`
    function envInt(VulcanVmSafe, string memory name, string memory delim) internal view returns (int256[] memory) {
        return hevm.envInt(name, delim);
    }

    /// @dev Reads the environment variable with name `name` and returns the value as `address[]`
    /// @param name the name of the environment variable to read
    /// @param delim the delimiter used to split the values 
    /// @return the value of the environment variable as `address[]`
    function envAddress(VulcanVmSafe, string memory name, string memory delim) internal view returns (address[] memory) {
        return hevm.envAddress(name, delim);
    }

    /// @dev Reads the environment variable with name `name` and returns the value as `bytes32[]`
    /// @param name the name of the environment variable to read
    /// @param delim the delimiter used to split the values 
    /// @return the value of the environment variable as `bytes32[]`
    function envBytes32(VulcanVmSafe, string memory name, string memory delim) internal view returns (bytes32[] memory) {
        return hevm.envBytes32(name, delim);
    }

    /// @dev Reads the environment variable with name `name` and returns the value as `string[]`
    /// @param name the name of the environment variable to read
    /// @param delim the delimiter used to split the values 
    /// @return the value of the environment variable as `string[]`
    function envString(VulcanVmSafe, string memory name, string memory delim) internal view returns (string[] memory) {
        return hevm.envString(name, delim);
    }

    /// @dev Reads the environment variable with name `name` and returns the value as `bytes[]`
    /// @param name the name of the environment variable to read
    /// @param delim the delimiter used to split the values 
    /// @return the value of the environment variable as `bytes[]`
    function envBytes(VulcanVmSafe, string memory name, string memory delim) internal view returns (bytes[] memory) {
        return hevm.envBytes(name, delim);
    }

    function envOr(string memory name, bool defaultValue) internal returns (bool value) {
        return hevm.envOr(name, defaultValue);
    }
    function envOr(string memory name, uint256 defaultValue) external returns (uint256 value) {
        return hevm.envOr(name, defaultValue);
    }
    function envOr(string memory name, int256 defaultValue) external returns (int256 value) {
        return hevm.envOr(name, defaultValue);
    }
    function envOr(string memory name, address defaultValue) external returns (address value) {
        return hevm.envOr(name, defaultValue);
    }
    function envOr(string memory name, bytes32 defaultValue) external returns (bytes32 value) {
        return hevm.envOr(name, defaultValue);
    }
    function envOr(string memory name, string memory defaultValue) external returns (string memory value) {
        return hevm.envOr(name, defaultValue);
    }
    function envOr(string memory name, bytes memory defaultValue) external returns (bytes memory value) {
        return hevm.envOr(name, defaultValue);
    }
    // Read environment variables as arrays with default value
    function envOr(string memory name, string memory delim, bool[] memory defaultValue)
        external
        returns (bool[] memory value)
    {
        return hevm.envOr(name, delim, defaultValue);
    }

    function envOr(string memory name, string memory delim, uint256[] memory defaultValue)
        external
        returns (uint256[] memory value)
    {
        return hevm.envOr(name, delim, defaultValue);
    }
    function envOr(string memory name, string memory delim, int256[] memory defaultValue)
        external
        returns (int256[] memory value)
    {
        return hevm.envOr(name, delim, defaultValue);
    }
    function envOr(string memory name, string memory delim, address[] memory defaultValue)
        external
        returns (address[] memory value)
    {
        return hevm.envOr(name, delim, defaultValue);
    }
    function envOr(string memory name, string memory delim, bytes32[] memory defaultValue)
        external
        returns (bytes32[] memory value)
    {
        return hevm.envOr(name, delim, defaultValue);
    }
    function envOr(string memory name, string memory delim, string[] memory defaultValue)
        external
        returns (string[] memory value)
    {
        return hevm.envOr(name, delim, defaultValue);
    }
    function envOr(string memory name, string memory delim, bytes[] memory defaultValue)
        external
        returns (bytes[] memory value)
    {
        return hevm.envOr(name, delim, defaultValue);
    }

    /// @dev records all storage reads and writes
    function recordStorage(VulcanVmSafe) internal {
        hevm.record();
    }

    /// @dev obtains all reads and writes to the storage from address `who`
    /// @param who the target address to read all accesses to the storage
    /// @return reads and writes in the form of (bytes32[] reads, bytes32[] writes)
    function getStorageAccesses(VulcanVmSafe, address who) internal returns (bytes32[] memory reads, bytes32[] memory writes) {
        return hevm.accesses(who);
    }

    /// @dev obtains all reads and writes to the storage from address `who`
    /// @param who the target address to read all accesses to the storage
    /// @return reads and writes in the form of (bytes32[] reads, bytes32[] writes)
    function getStorageAccesses(address who) internal returns (bytes32[] memory reads, bytes32[] memory writes) {
        return hevm.accesses(who);
    }

    /// @dev Gets the creation bytecode from an artifact file. Takes in the relative path to the json file
    /// @param path the relative path to the json file
    /// @return the creation code
    function getCode(VulcanVmSafe, string memory path) internal view returns (bytes memory) {
        return hevm.getCode(path);
    }
    /// @dev Gets the deployed bytecode from an artifact file. Takes in the relative path to the json file
    /// @param path the relative path to the json file
    /// @return the deployed code
    function getDeployedCode(VulcanVmSafe, string memory path) internal view returns (bytes memory) {
        return hevm.getDeployedCode(path);
    }

    /// @dev labels the address `who` with label `lbl`
    /// @param who the address to label
    /// @param lbl the new label for address `who`
    function label(VulcanVmSafe, address who, string memory lbl) internal returns (address) {
        return label(who, lbl);
    }

    /// @dev labels the address `who` with label `lbl`
    /// @param who the address to label
    /// @param lbl the new label for address `who`
    function label(address who, string memory lbl) internal returns (address) {
        hevm.label(who, lbl);
        return who;
    }

    /// @dev Using the address that calls the test contract, has the next call (at this call depth only) create a transaction that can later be signed and sent onchain
    function broadcast(VulcanVmSafe) internal {
        hevm.broadcast();
    }

    /// @dev Has the next call (at this call depth only) create a transaction with the address provided as the sender that can later be signed and sent onchain
    /// @param from the sender of the transaction
    function broadcast(VulcanVmSafe, address from) internal {
        hevm.broadcast(from);
    }

    /// @dev Has the next call (at this call depth only) create a transaction with the private key provided as the sender that can later be signed and sent onchain
    /// @param privKey the sender of the transaction as a private key
    function broadcast(VulcanVmSafe, uint256 privKey) internal {
        hevm.broadcast(privKey);
    }

    /// @dev Using the address that calls the test contract, has all subsequent calls (at this call depth only) create transactions that can later be signed and sent onchain
    function startBroadcast(VulcanVmSafe) internal {
        hevm.startBroadcast();
    }

    /// @dev Has all subsequent calls (at this call depth only) create transactions with the address provided that can later be signed and sent onchain
    /// @param from the sender of the transactions
    function startBroadcast(VulcanVmSafe, address from) internal {
        hevm.startBroadcast(from);
    }

    /// @dev Has all subsequent calls (at this call depth only) create transactions with the private key provided that can later be signed and sent onchain
    /// @param privKey the sender of the transactions as a private key
    function startBroadcast(VulcanVmSafe, uint256 privKey) internal {
        hevm.startBroadcast(privKey);
    }

    function stopBroadcast(VulcanVmSafe) internal {
        hevm.stopBroadcast();
    }

    function readFile(VulcanVmSafe, string memory path) internal view returns (string memory) {
        return hevm.readFile(path);
    }

    function readFileBinary(VulcanVmSafe, string memory path) internal view returns (bytes memory) {
        return hevm.readFileBinary(path);
    }

    function projectRoot(VulcanVmSafe) internal view returns (string memory) {
        return hevm.projectRoot();
    }
    
    function fsMetadata(string memory fileOrDir) internal returns (FsMetadata memory metadata) {
        Hevm.FsMetadata memory md = hevm.fsMetadata(fileOrDir);
        assembly {
            metadata := md
        }
    }

    function readLine(VulcanVmSafe, string memory path) internal view returns (string memory) {
        return hevm.readLine(path);
    }

    function writeFile(VulcanVmSafe, string memory path, string memory data) internal {
        hevm.writeFile(path, data);
    }

    function writeFileBinary(VulcanVmSafe, string memory path, bytes memory data) internal {
        hevm.writeFileBinary(path, data);
    }
    function writeLine(VulcanVmSafe, string memory path, string memory data) internal {
        hevm.writeLine(path, data);
    }
    function closeFile(VulcanVmSafe, string memory path) internal {
        hevm.closeFile(path);
    }
    function removeFile(VulcanVmSafe, string memory path) internal {
        hevm.removeFile(path);
    }
    function toString(VulcanVmSafe, address value) internal pure returns (string memory) {
        return hevm.toString(value);
    }
    function toString(VulcanVmSafe, bytes memory value) internal pure returns (string memory) {
        return hevm.toString(value);
    }

    function toString(VulcanVmSafe, bytes32 value) internal pure returns (string memory) {
        return hevm.toString(value);
    }
    function toString(VulcanVmSafe, bool value) internal pure returns (string memory) {
        return hevm.toString(value);
    }
    function toString(VulcanVmSafe, uint256 value) internal pure returns (string memory) {
        return hevm.toString(value);
    }
    function toString(VulcanVmSafe, int256 value) internal pure returns (string memory) {
        return hevm.toString(value);
    }
    function parseBytes(VulcanVmSafe, string memory value) internal pure returns (bytes memory) {
        return hevm.parseBytes(value);
    }
    function parseAddress(VulcanVmSafe, string memory value) internal pure returns (address) {
        return hevm.parseAddress(value);
    }
    function parseUint(VulcanVmSafe, string memory value) internal pure returns (uint256) {
        return hevm.parseUint(value);
    }
    function parseInt(VulcanVmSafe, string memory value) internal pure returns (int256) {
        return hevm.parseInt(value);
    }
    function parseBytes32(VulcanVmSafe, string memory value) internal pure returns (bytes32) {
        return hevm.parseBytes32(value);
    }
    function parseBool(VulcanVmSafe, string memory value) internal pure returns (bool) {
        return hevm.parseBool(value);
    }
    function recordLogs(VulcanVmSafe) internal {
        hevm.recordLogs();
    }
    function getRecordedLogs(VulcanVmSafe) internal returns (Log[] memory logs) {
        Hevm.Log[] memory recorded = hevm.getRecordedLogs();
        assembly {
            logs := recorded
        }
    }
    function deriveKey(VulcanVmSafe, string memory mnemonicOrPath, uint32 index) internal pure returns (uint256) {
        return hevm.deriveKey(mnemonicOrPath, index);
    }
    function deriveKey(VulcanVmSafe, string memory mnemonicOrPath, string memory derivationPath, uint32 index) internal pure returns (uint256) {
        return hevm.deriveKey(mnemonicOrPath, derivationPath, index);
    }

    function rememberKey(VulcanVmSafe, uint256 privKey) internal returns (address) {
        return hevm.rememberKey(privKey);
    }

    function assume(VulcanVmSafe, bool condition) internal pure {
        hevm.assume(condition);
    }

    function pauseGasMetering() external {
        hevm.pauseGasMetering();
    }

    function resumeGasMetering() external {
        hevm.resumeGasMetering();
    }

    /// @dev creates a wrapped address from `name`
    function createAddress(VulcanVmSafe self, string memory name) internal returns (address) {
        return createAddress(self, name, name);
    }

    /// @dev creates a wrapped address from `name` and labels it with `lbl`
    function createAddress(VulcanVmSafe self, string memory name, string memory lbl) internal returns (address) {
        address addr = deriveAddress(self, uint256(keccak256(abi.encodePacked(name))));

        return label(addr, lbl);
    }

    /* VulcanVm */

    /// @dev sets the `block.timestamp` to `ts`
    /// @param ts the new block timestamp
    function setBlockTimestamp(VulcanVm self, uint256 ts) internal returns(VulcanVm) {
        hevm.warp(ts);
        return self;
    }

    /// @dev sets the `block.number` to `blockNumber`
    /// @param blockNumber the new block number
    function setBlockNumber(VulcanVm self, uint256 blockNumber) internal returns(VulcanVm) {
        hevm.roll(blockNumber);
        return self;
    }

    /// @dev sets the `block.basefee` to `baseFee`
    /// @param baseFee the new block base fee
    function setBlockBaseFee(VulcanVm self, uint256 baseFee) internal returns(VulcanVm) {
        hevm.fee(baseFee);
        return self;
    }

    /// @dev sets the `block.difficulty` to `difficulty`
    /// @param difficulty the new block difficulty
    function setBlockDifficulty(VulcanVm self, uint256 difficulty) internal returns(VulcanVm) {
        hevm.difficulty(difficulty);
        return self;
    }

    /// @dev sets the `block.chainid` to `chainId`
    /// @param chainId the new block chain id
    function setChainId(VulcanVm self, uint256 chainId) internal returns(VulcanVm){
        hevm.chainId(chainId);
        return self;
    }

    /// @dev sets the value of the storage slot `slot` to `value`
    /// @param self the address that will be updated
    /// @param slot the slot to update
    /// @param value the new value of the slot `slot` on the address `self`
    /// @return the modified address so other methods can be chained
    function setStorage(VulcanVm, address self, bytes32 slot, bytes32 value) internal returns(address) {
        hevm.store(self, slot, value);
        return self;
    }

    /// @dev sets the value of the storage slot `slot` to `value`
    /// @param self the address that will be updated
    /// @param slot the slot to update
    /// @param value the new value of the slot `slot` on the address `self`
    /// @return the modified address so other methods can be chained
    function setStorage(address self, bytes32 slot, bytes32 value) internal returns(address) {
        hevm.store(self, slot, value);
        return self;
    }

    /// @dev sets the nonce of the address `addr` to `n`
    /// @param addr the address that will be updated
    /// @param n the new nonce
    /// @return the address that was updated
    function setNonce(VulcanVm, address addr, uint64 n) internal returns(address) {
        return setNonce(addr, n);
    }

    /// @dev sets the nonce of the address `addr` to `n`
    /// @param self the address that will be updated
    /// @param n the new nonce
    /// @return the address that was updated
    function setNonce(address self, uint64 n) internal returns(address) {
        hevm.setNonce(self, n);
        return self;
    }

    /// @dev sets the next call's `msg.sender` to `sender`
    /// @param sender the address to set the `msg.sender`
    /// @return the `msg.sender` for the next call
    function impersonateOnce(VulcanVm, address sender) internal returns(address) {
        return impersonateOnce(sender);
    }

    /// @dev sets the next call's `msg.sender` to `sender`
    /// @param self the address to set the `msg.sender`
    /// @return the `msg.sender` for the next call
    function impersonateOnce(address self) internal returns(address) {
        hevm.prank(self);
        return self;
    }

    /// @dev sets all subsequent call's `msg.sender` to `sender` until `stopPrank` is called
    /// @param sender the address to set the `msg.sender`
    /// @return the `msg.sender` for the next calls
    function impersonate(VulcanVm, address sender) internal returns(address) {
        return impersonate(sender);
    }

    /// @dev sets all subsequent call's `msg.sender` to `sender` until `stopPrank` is called
    /// @param self the address to set the `msg.sender`
    /// @return the `msg.sender` for the next calls
    function impersonate(address self) internal returns(address) {
        hevm.startPrank(self);
        return self;
    }

    /// @dev sets the next call's `msg.sender` to `sender` and `tx.origin` to `origin`
    /// @param sender the address to set the `msg.sender`
    /// @param origin the address to set the `tx.origin`
    /// @return the `msg.sender` for the next call
    function impersonateOnce(VulcanVm, address sender, address origin) internal returns(address) {
        return impersonateOnce(sender, origin);
    }

    /// @dev sets the next call's `msg.sender` to `sender` and `tx.origin` to `origin`
    /// @param self the address to set the `msg.sender`
    /// @param origin the address to set the `tx.origin`
    /// @return the `msg.sender` for the next call
    function impersonateOnce(address self, address origin) internal returns(address) {
        hevm.prank(self, origin);
        return self;
    }

    /// @dev sets all subsequent call's `msg.sender` to `sender` and `tx.origin` to `origin` until `stopPrank` is called
    /// @param sender the address to set the `msg.sender`
    /// @param origin the address to set the `tx.origin`
    /// @return the `msg.sender` for the next calls
    function impersonate(VulcanVm, address sender, address origin) internal returns(address) {
        return impersonate(sender, origin);
    }

    /// @dev sets all subsequent call's `msg.sender` to `sender` and `tx.origin` to `origin` until `stopPrank` is called
    /// @param self the address to set the `msg.sender`
    /// @param origin the address to set the `tx.origin`
    /// @return the `msg.sender` for the next calls
    function impersonate(address self, address origin) internal returns(address) {
        hevm.startPrank(self, origin);
        return self;
    }

    /// @dev resets the values of `msg.sender` and `tx.origin` to their original values
    function stopImpersonate(VulcanVm) internal {
        hevm.stopPrank();
    }

    /// @dev sets the balance of the address `addr` to `bal`
    /// @param self the address that will be updated
    /// @param bal the new balance
    /// @return the address that was updated
    function setBalance(VulcanVm, address self, uint256 bal) internal returns(address) {
        return setBalance(self, bal);
    }

    /// @dev sets the balance of the address `addr` to `bal`
    /// @param self the address that will be updated
    /// @param bal the new balance
    /// @return the address that was updated
    function setBalance(address self, uint256 bal) internal returns(address) {
        hevm.deal(self, bal);
        return self;
    }

    function setCode(VulcanVm, address self, bytes memory code) internal returns(address) {
        return setCode(self, code);
    }

    function setCode(address self, bytes memory code) internal returns(address) {
        hevm.etch(self, code);
        return self;
    }

    function expectRevert(bytes memory revertData) internal {
        hevm.expectRevert(revertData);
    }

    function expectRevert(bytes4 revertData) internal {
        hevm.expectRevert(revertData);
    }

    function expectRevert() external {
        hevm.expectRevert();
    }

    function expectEmit(bool checkTopic1, bool checkTopic2, bool checkTopic3, bool checkData) internal {
        hevm.expectEmit(checkTopic1, checkTopic2, checkTopic3, checkData);
    }
    function expectEmit(bool checkTopic1, bool checkTopic2, bool checkTopic3, bool checkData, address emitter)
        internal
    {
        hevm.expectEmit(checkTopic1, checkTopic2, checkTopic3, checkData, emitter);
    }

    function mockCall(address callee, bytes memory data, bytes memory returnData) internal {
        hevm.mockCall(callee, data, returnData);
    }

    function mockCall(address callee, uint256 msgValue, bytes memory data, bytes memory returnData) internal {
        hevm.mockCall(callee, msgValue, data, returnData);
    }

    function clearMockedCalls() internal {
        hevm.clearMockedCalls();
    }

    function expectCall(address callee, bytes memory data) internal {
        hevm.expectCall(callee, data);
    }

    function expectCall(address callee, uint256 msgValue, bytes memory data) internal {
        hevm.expectCall(callee, msgValue, data);
    }

    function setBlockCoinbase(VulcanVm self, address who) internal returns (VulcanVm){
        hevm.coinbase(who);
        return self;
    }
    
    function snapshot(VulcanVm) internal returns (uint256) {
        return hevm.snapshot();
    }

    function revertToSnapshot(VulcanVm, uint256 snapshotId) internal returns (bool) {
        return hevm.revertTo(snapshotId);
    }

    function forkAtBlock(VulcanVm, string memory endpoint, uint256 blockNumber) internal returns (Fork memory) {
        return Fork(hevm.createFork(endpoint, blockNumber));
    }
    function fork(VulcanVm, string memory endpoint) internal returns (Fork memory) {
        return Fork(hevm.createFork(endpoint));
    }
    function forkBeforeTx(VulcanVm, string memory endpoint, bytes32 txHash) internal returns (Fork memory) {
        return Fork(hevm.createFork(endpoint, txHash));
    }

    function select(Fork memory self) internal returns (Fork memory) {
        hevm.selectFork(self.id);
        return self;
    }

    function activeFork(VulcanVm) internal view returns (Fork memory) {
        return Fork(hevm.activeFork());
    }

    function setBlockNumber(Fork memory self, uint256 blockNumber) internal returns (Fork memory) {
        hevm.rollFork(self.id, blockNumber);
        return self;
    }

    function beforeTx(Fork memory self, bytes32 txHash) internal returns (Fork memory) {
        hevm.rollFork(self.id, txHash);
        return self;
    }


    function persistBetweenForks(address self) internal returns(address) {
        hevm.makePersistent(self);
        return self;
    }

    function persistBetweenForks(VulcanVm, address who) internal {
        hevm.makePersistent(who);
    }

    function persistBetweenForks(VulcanVm, address who1, address who2) internal {
        hevm.makePersistent(who1, who2);
    }
    function persistBetweenForks(VulcanVm, address who1, address who2, address who3) internal {
        hevm.makePersistent(who1, who2, who3);
    }
    function persistBetweenForks(VulcanVm, address[] memory whos) internal {
        hevm.makePersistent(whos);
    }
    function stopPersist(VulcanVm, address who) internal {
        hevm.revokePersistent(who);
    }
    function stopPersist(VulcanVm, address[] memory whos) internal {
        hevm.revokePersistent(whos);
    }
    function isPersistent(VulcanVm, address who) internal view returns (bool) {
        return hevm.isPersistent(who);
    }
    function allowCheatcodes(VulcanVm, address who) internal {
        hevm.allowCheatcodes(who);
    }
    function executeTx(VulcanVm, bytes32 txHash) internal {
        hevm.transact(txHash);
    }
    function executeTx(Fork memory self, bytes32 txHash) internal returns(Fork memory) {
        hevm.transact(self.id, txHash);
        return self;
    }

    function failed() internal view returns (bool) {
        bytes32 globalFailed = address(hevm).readStorage(GLOBAL_FAILED_SLOT);
        return globalFailed == bytes32(uint256(1));
    } 

    function fail() internal {
        address(hevm).setStorage(GLOBAL_FAILED_SLOT, bytes32(uint256(1)));
    }

    function clearFailure() internal {
        address(hevm).setStorage(GLOBAL_FAILED_SLOT, bytes32(uint256(0)));
    }

    function watchers() internal view returns (Watchers storage watchers) {
        bytes32 slot = VM_WATCHERS_SLOT;

        assembly {
            watchers.slot := slot
        }
    }

    function watch(VulcanVm, address payable _target) internal returns (Watcher) {
        Watcher watcher = new Watcher();

        bytes memory targetCode = _target.code;

        // Switcheroo
        _target.setCode(address(watcher).code);
        address(watcher).setCode(targetCode);

        watchers().map[_target] = Watcher(_target);

        return Watcher(_target);
    }

    function stopWatch(VulcanVm, address _target) internal {
        Watcher watcher = watchers().map[_target];

        if (address(watcher) == address(0)) {
            return;
        }

        watcher.reset();

        _target.setCode(watcher.target().code);

        delete watchers().map[_target];
    }

    function calls(address self, uint256 index) internal returns (Watcher.Call memory) {
        return watchers().map[self].calls(index);
    }

    function firstCall(address self) internal returns (Watcher.Call memory) {
        return watchers().map[self].firstCall();
    }

    function lastCall(address self) internal returns (Watcher.Call memory) {
        return watchers().map[self].lastCall();
    }
}

using vulcan for Fork global;