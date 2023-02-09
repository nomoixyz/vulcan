// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.13 <0.9.0;

import { Vm as Hevm } from "forge-std/Vm.sol";
import {WatcherProxy, WatcherStorage, Call, Watcher} from "./Watcher.sol";

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
// TODO: most variable names and comments are the ones provided by the forge-std library, figure out if we should change/improve/remove some of them
/// @dev Main entry point to vm functionality
library vulcan {
    using vulcan for *;

    bytes32 constant GLOBAL_FAILED_SLOT = bytes32("failed");
    bytes32 constant VM_WATCHERS_STORAGES_SLOT = bytes32("vulcan.vm.watchers.storages.slot");

    /// @dev forge-std VM
    Hevm internal constant hevm = Hevm(address(bytes20(uint160(uint256(keccak256('hevm cheat code'))))));

    // This address doesn't contain any code
    VulcanVm internal constant vm = VulcanVm(address(bytes20(uint160(uint256(keccak256('vulcan.vm.address'))))));

    /// @dev performs a foreign function call via the terminal, (stringInputs) => (result)
    /// @param inputs the command splitted into strings. eg ["mkdir", "-p", "tests"]
    /// @return the output of the command
    function runCommand(VulcanVmSafe, string[] memory inputs) internal returns (bytes memory) {
        return hevm.ffi(inputs);
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

    function assume(VulcanVmSafe, bool condition) internal pure {
        hevm.assume(condition);
    }

    function pauseGasMetering() external {
        hevm.pauseGasMetering();
    }

    function resumeGasMetering() external {
        hevm.resumeGasMetering();
    }

    /* VulcanVm */

    function failed() internal view returns (bool) {
        bytes32 globalFailed = vulcan.hevm.load(address(hevm), GLOBAL_FAILED_SLOT);
        return globalFailed == bytes32(uint256(1));
    } 

    function fail() internal {
        vulcan.hevm.store(address(hevm), GLOBAL_FAILED_SLOT, bytes32(uint256(1)));
    }

    function clearFailure() internal {
        vulcan.hevm.store(address(hevm), GLOBAL_FAILED_SLOT, bytes32(uint256(0)));
    }

    function storages() internal pure returns (mapping(address => WatcherStorage) storage s) {
        bytes32 slot = VM_WATCHERS_STORAGES_SLOT;

        assembly {
            s.slot := slot
        }
    }

    function watcher(address self) internal view returns (Watcher memory) {
        require(address(storages()[self]) != address(0), "Address doesn't have a watcher");

        return Watcher(storages()[self]);
    }

    function watch(address self) internal returns (Watcher memory) {
        require(address(storages()[self]) == address(0), "Address already has a watcher");

        WatcherStorage proxyStorage = new WatcherStorage();

        WatcherProxy proxy = new WatcherProxy(proxyStorage);

        proxyStorage.setTarget(address(proxy));
        proxyStorage.setProxy(self);

        bytes memory targetCode = self.code;

        // Switcheroo
        self.setCode(address(proxy).code);
        address(proxy).setCode(targetCode);

        storages()[self] = proxyStorage;

        return Watcher(proxyStorage);
    }

    function watch(VulcanVm, address _target) internal returns (Watcher memory) {
        return _target.watch();
    }

    function stop(Watcher memory self) internal {
        address proxy = self.watcherStorage.proxy();
        address target = self.watcherStorage.target();

        proxy.setCode(target.code);

        delete storages()[proxy];
    }

    function stopWatcher(address self) internal returns (address) {
        self.watcher().stop();
        return self;
    }

    function stopWatcher(VulcanVm self, address _target) internal returns (VulcanVm) {
        _target.watcher().stop();
        return self;
    }

    function calls(address self, uint256 index) internal view returns (Call memory) {
        return storages()[self].calls(index);
    }

    function calls(Watcher memory self, uint256 index) internal view returns (Call memory) {
        return self.watcherStorage.calls(index);
    }

    function firstCall(address self) internal view returns (Call memory) {
        return storages()[self].firstCall();
    }

    function firstCall(Watcher memory self) internal view returns (Call memory) {
        return self.watcherStorage.firstCall();
    }

    function lastCall(address self) internal view returns (Call memory) {
        return storages()[self].lastCall();
    }

    function lastCall(Watcher memory self) internal view returns (Call memory) {
        return self.watcherStorage.lastCall();
    }

    function captureReverts(Watcher memory self) internal returns (Watcher memory) {
        self.watcherStorage.setCaptureReverts(true);
        return self;
    }

    function disableCaptureReverts(Watcher memory self) internal returns (Watcher memory) {
        self.watcherStorage.setCaptureReverts(true);
        return self;
    }
}