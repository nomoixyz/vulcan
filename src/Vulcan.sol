// SPDX-License-Identifier: MIT
pragma solidity >=0.8.13 <0.9.0;

import {Vm as Hevm} from "forge-std/Vm.sol";
import {watchers, Call, Watcher} from "./Watcher.sol";
import {ctx} from "./Context.sol";

interface VulcanVm {}

/// @dev Struct that represent an EVM log
struct Log {
    bytes32[] topics;
    bytes data;
    address emitter;
}

/// @dev Struct that represents an RPC endpoint
struct Rpc {
    string name;
    string url;
}

library vulcan {
    using vulcan for *;

    bytes32 constant GLOBAL_FAILED_SLOT = bytes32("failed");

    /// @dev forge-std VM
    Hevm internal constant hevm = Hevm(address(bytes20(uint160(uint256(keccak256("hevm cheat code"))))));

    function init() internal {
        ctx.init();
    }

    function broadcast() internal {
        hevm.broadcast();
    }

    function broadcast(address from) internal {
        hevm.broadcast(from);
    }

    function broadcast(uint256 privKey) internal {
        hevm.broadcast(privKey);
    }

    function startBroadcast() internal {
        hevm.startBroadcast();
    }

    function startBroadcast(address from) internal {
        hevm.startBroadcast(from);
    }

    function startBroadcast(uint256 privKey) internal {
        hevm.startBroadcast(privKey);
    }

    function stopBroadcast() internal {
        hevm.stopBroadcast();
    }

    function assume(bool condition) internal pure {
        hevm.assume(condition);
    }

    function pauseGasMetering() internal {
        hevm.pauseGasMetering();
    }

    function resumeGasMetering() internal {
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

    function watch(address _target) internal returns (Watcher) {
        return watchers.watch(_target);
    }

    function stopWatcher(address _target) internal {
        watchers.stop(_target);
    }
}
