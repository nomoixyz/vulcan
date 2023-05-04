// SPDX-License-Identifier: MIT
pragma solidity >=0.8.13 <0.9.0;

import "./Vulcan.sol";

import "./Config.sol";

/// @dev Holds a fork's id.
type Fork is uint256;

library forks {
    /// @dev Create a new fork using the provided endpoint.
    /// @param nameOrEndpoint The name or endpoint to use for the fork.
    /// @return The new fork pointer.
    function create(string memory nameOrEndpoint) internal returns (Fork) {
        string memory endpoint = config.rpcUrl(nameOrEndpoint);
        return Fork.wrap(vulcan.hevm.createFork(endpoint));
    }

    /// @dev Create a new fork using the provided endpoint at a given block number.
    /// @param nameOrEndpoint The name or endpoint to use for the fork.
    /// @param blockNumber The block number to fork from.
    /// @return The new fork pointer.
    function createAtBlock(string memory nameOrEndpoint, uint256 blockNumber) internal returns (Fork) {
        string memory endpoint = config.rpcUrl(nameOrEndpoint);
        return Fork.wrap(vulcan.hevm.createFork(endpoint, blockNumber));
    }

    /// @dev Create a new fork using the provided endpoint at a state right before the provided transaction hash.
    /// @param nameOrEndpoint The endpoint to use for the fork.
    /// @param txHash The transaction hash to fork from.
    /// @return The new fork pointer.
    function createBeforeTx(string memory nameOrEndpoint, bytes32 txHash) internal returns (Fork) {
        string memory endpoint = config.rpcUrl(nameOrEndpoint);
        return Fork.wrap(vulcan.hevm.createFork(endpoint, txHash));
    }

    /// @dev Set the provided fork as the current active fork.
    /// @param self The fork to set as active.
    /// @return The fork that was set as active.
    function select(Fork self) internal returns (Fork) {
        vulcan.hevm.selectFork(Fork.unwrap(self));
        return self;
    }

    /// @dev Get the current active fork.
    /// @return The current active fork.
    function active() internal view returns (Fork) {
        return Fork.wrap(vulcan.hevm.activeFork());
    }

    /// @dev Set the block number of the provided fork.
    /// @param self The fork to set the block number of.
    /// @param blockNumber The block number to set.
    /// @return The provided fork.
    function setBlockNumber(Fork self, uint256 blockNumber) internal returns (Fork) {
        vulcan.hevm.rollFork(Fork.unwrap(self), blockNumber);
        return self;
    }

    /// @dev Set the provided fork to the state right before the provided transaction hash.
    /// @param self The fork to set the state of.
    /// @param txHash The transaction hash to fork from.
    /// @return The provided fork.
    function beforeTx(Fork self, bytes32 txHash) internal returns (Fork) {
        vulcan.hevm.rollFork(Fork.unwrap(self), txHash);
        return self;
    }

    /// @dev Make the state of the provided address persist between forks.
    /// @param self The address to make persistent.
    /// @return The provided address.
    function persistBetweenForks(address self) internal returns (address) {
        vulcan.hevm.makePersistent(self);
        return self;
    }

    /// @dev Make the state of the provided addresses persist between forks.
    /// @param who1 The first address to make persistent.
    /// @param who2 The second address to make persistent.
    function persistBetweenForks(address who1, address who2) internal {
        vulcan.hevm.makePersistent(who1, who2);
    }

    /// @dev Make the state of the provided addresses persist between forks.
    /// @param who1 The first address to make persistent.
    /// @param who2 The second address to make persistent.
    /// @param who3 The third address to make persistent.
    function persistBetweenForks(address who1, address who2, address who3) internal {
        vulcan.hevm.makePersistent(who1, who2, who3);
    }

    /// @dev Make the state of the provided addresses persist between forks.
    /// @param whos Array of addresses to make persistent.
    function persistBetweenForks(address[] memory whos) internal {
        vulcan.hevm.makePersistent(whos);
    }

    /// @dev Revoke the persistent state of the provided address.
    /// @param who The address to revoke the persistent state of.
    /// @return The provided address.
    function stopPersist(address who) internal returns (address) {
        vulcan.hevm.revokePersistent(who);
        return who;
    }

    /// @dev Revoke the persistent state of the provided addresses.
    /// @param whos array of addresses to revoke the persistent state of.
    function stopPersist(address[] memory whos) internal {
        vulcan.hevm.revokePersistent(whos);
    }

    /// @dev Check if the provided address is being persisted between forks.
    /// @param who The address to check.
    /// @return True if the address is being persisted between forks, false otherwise.
    function isPersistent(address who) internal view returns (bool) {
        return vulcan.hevm.isPersistent(who);
    }

    /// @dev Allow cheatcodes to be used by the provided address in forking mode.
    /// @param who The address to allow cheatcodes for.
    /// @return The provided address.
    function allowCheatcodes(address who) internal returns (address) {
        vulcan.hevm.allowCheatcodes(who);
        return who;
    }

    /// @dev Executes an existing transaction in the current active fork.
    /// @param txHash The hash of the transaction to execute.
    function executeTx(bytes32 txHash) internal {
        vulcan.hevm.transact(txHash);
    }

    /// @dev Executes an existing transaction in the provided fork.
    /// @param self The fork to execute the transaction in.
    /// @param txHash The hash of the transaction to execute.
    /// @return The provided fork.
    function executeTx(Fork self, bytes32 txHash) internal returns (Fork) {
        vulcan.hevm.transact(Fork.unwrap(self), txHash);
        return self;
    }
}

using forks for Fork global;
