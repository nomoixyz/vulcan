// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.13 <0.9.0;

import {Vm as Hevm} from "forge-std/Vm.sol";
import {watchers, Call, Watcher} from "./Watcher.sol";
import {ctx} from "./Context.sol";

/// @dev Struct that represent an EVM log
struct Log {
    bytes32[] topics;
    bytes data;
    address emitter;
}

library vulcan {
    using vulcan for *;

    bytes32 constant GLOBAL_FAILED_SLOT = bytes32("failed");

    /// @dev forge-std VM
    Hevm internal constant hevm = Hevm(address(bytes20(uint160(uint256(keccak256("hevm cheat code"))))));

    /// @dev Initializes the context module
    function init() internal {
        ctx.init();
    }

    /// @dev Checks if `fail` was called at some point.
    /// @return true if `fail` was called, false otherwise
    function failed() internal view returns (bool) {
        bytes32 globalFailed = vulcan.hevm.load(address(hevm), GLOBAL_FAILED_SLOT);
        return globalFailed == bytes32(uint256(1));
    }

    /// @dev Signal that an expectation/assertion failed.
    function fail() internal {
        vulcan.hevm.store(address(hevm), GLOBAL_FAILED_SLOT, bytes32(uint256(1)));
    }

    /// @dev Resets the failed state.
    function clearFailure() internal {
        vulcan.hevm.store(address(hevm), GLOBAL_FAILED_SLOT, bytes32(uint256(0)));
    }

    /// @dev Starts monitoring an address.
    /// @param _target The address to monitor.
    /// @return The Watcher contract that monitors the `_target` address.
    function watch(address _target) internal returns (Watcher) {
        return watchers.watch(_target);
    }

    /// @dev Stops monitoring an address.
    /// @param _target The address to stop monitoring.
    function stopWatcher(address _target) internal {
        watchers.stop(_target);
    }
}
