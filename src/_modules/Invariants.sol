// SPDX-License-Identifier: MIT
pragma solidity >=0.8.13 <0.9.0;

/// @title FuzzSelector
/// @dev A struct that represents a Fuzz Selector
struct FuzzSelector {
    address addr;
    bytes4[] selectors;
}

/// @title InvariantsBase
/// @dev An abstract contract that defines the base for Invariants
abstract contract InvariantsBase {
    /// @dev Returns the excluded artifacts
    /// @return The array of excluded artifacts
    function excludeArtifacts() public view returns (string[] memory) {
        return invariants.getState().excludedArtifacts;
    }

    /// @dev Returns the excluded contracts
    /// @return The array of excluded contracts
    function excludeContracts() public view returns (address[] memory) {
        return invariants.getState().excludedContracts;
    }

    /// @dev Returns the excluded senders
    /// @return The array of excluded senders
    function excludeSenders() public view returns (address[] memory) {
        return invariants.getState().excludedSenders;
    }

    /// @dev Returns the targeted artifacts
    /// @return The array of targeted artifacts
    function targetArtifacts() public view returns (string[] memory) {
        return invariants.getState().targetedArtifacts;
    }

    /// @dev Returns the targeted artifact selectors
    /// @return The array of targeted artifact selectors
    function targetArtifactSelectors() public view returns (FuzzSelector[] memory) {
        return invariants.getState().targetedArtifactSelectors;
    }

    /// @dev Returns the targeted contracts
    /// @return The array of targeted contracts
    function targetContracts() public view returns (address[] memory) {
        return invariants.getState().targetedContracts;
    }

    /// @dev Returns the targeted selectors
    /// @return The array of targeted selectors
    function targetSelectors() public view returns (FuzzSelector[] memory) {
        return invariants.getState().targetedSelectors;
    }

    /// @dev Returns the targeted senders
    /// @return The array of targeted senders
    function targetSenders() public view returns (address[] memory) {
        return invariants.getState().targetedSenders;
    }
}

library invariants {
    struct State {
        address[] excludedContracts;
        address[] excludedSenders;
        address[] targetedContracts;
        address[] targetedSenders;
        string[] excludedArtifacts;
        string[] targetedArtifacts;
        FuzzSelector[] targetedArtifactSelectors;
        FuzzSelector[] targetedSelectors;
    }

    /// @dev Returns the state struct that contains the invariants related data
    /// @return state The invariants state struct
    function getState() internal pure returns (State storage state) {
        bytes32 slot = keccak256("vulcan.invariants.state");
        assembly {
            state.slot := slot
        }
    }

    /// @dev Excludes a contract
    /// @param newExcludedContract The contract to be excluded
    function excludeContract(address newExcludedContract) internal {
        getState().excludedContracts.push(newExcludedContract);
    }

    /// @dev Excludes multiple contracts
    /// @param newExcludedContracts The contracts to be excluded
    function excludeContracts(address[] memory newExcludedContracts) internal {
        for (uint256 i = 0; i < newExcludedContracts.length; i++) {
            excludeContract(newExcludedContracts[i]);
        }
    }

    /// @dev Excludes a sender
    /// @param newExcludedSender The sender to be excluded
    function excludeSender(address newExcludedSender) internal {
        getState().excludedSenders.push(newExcludedSender);
    }

    /// @dev Excludes multiple senders
    /// @param newExcludedSenders The senders to be excluded
    function excludeSenders(address[] memory newExcludedSenders) internal {
        for (uint256 i = 0; i < newExcludedSenders.length; i++) {
            excludeSender(newExcludedSenders[i]);
        }
    }

    /// @dev Excludes an artifact
    /// @param newExcludedArtifact The artifact to be excluded
    function excludeArtifact(string memory newExcludedArtifact) internal {
        getState().excludedArtifacts.push(newExcludedArtifact);
    }

    /// @dev Excludes multiple artifacts
    /// @param newExcludedArtifacts The artifacts to be excluded
    function excludeArtifacts(string[] memory newExcludedArtifacts) internal {
        for (uint256 i = 0; i < newExcludedArtifacts.length; i++) {
            excludeArtifact(newExcludedArtifacts[i]);
        }
    }

    /// @dev Targets an artifact
    /// @param newTargetedArtifact The artifact to be targeted
    function targetArtifact(string memory newTargetedArtifact) internal {
        getState().targetedArtifacts.push(newTargetedArtifact);
    }

    /// @dev Targets multiple artifacts
    /// @param newTargetedArtifacts The artifacts to be targeted
    function targetArtifacts(string[] memory newTargetedArtifacts) internal {
        for (uint256 i = 0; i < newTargetedArtifacts.length; i++) {
            targetArtifact(newTargetedArtifacts[i]);
        }
    }

    /// @dev Targets an artifact selector
    /// @param newTargetedArtifactSelector The artifact selector to be targeted
    function targetArtifactSelector(FuzzSelector memory newTargetedArtifactSelector) internal {
        getState().targetedArtifactSelectors.push(newTargetedArtifactSelector);
    }

    /// @dev Targets multiple artifact selectors
    /// @param newTargetedArtifactSelectors The artifact selectors to be targeted
    function targetArtifactSelectors(FuzzSelector[] memory newTargetedArtifactSelectors) internal {
        for (uint256 i = 0; i < newTargetedArtifactSelectors.length; i++) {
            targetArtifactSelector(newTargetedArtifactSelectors[i]);
        }
    }

    /// @dev Targets a contract
    /// @param newTargetedContract The contract to be targeted
    function targetContract(address newTargetedContract) internal {
        getState().targetedContracts.push(newTargetedContract);
    }

    /// @dev Targets multiple contracts
    /// @param newTargetedContracts The contracts to be targeted
    function targetContracts(address[] memory newTargetedContracts) internal {
        for (uint256 i = 0; i < newTargetedContracts.length; i++) {
            targetContract(newTargetedContracts[i]);
        }
    }

    /// @dev Targets a selector
    /// @param newTargetedSelector The selector to be targeted
    function targetSelector(FuzzSelector memory newTargetedSelector) internal {
        getState().targetedSelectors.push(newTargetedSelector);
    }

    /// @dev Targets multiple selectors
    /// @param newTargetedSelectors The selectors to be targeted
    function targetSelectors(FuzzSelector[] memory newTargetedSelectors) internal {
        for (uint256 i = 0; i < newTargetedSelectors.length; i++) {
            targetSelector(newTargetedSelectors[i]);
        }
    }

    /// @dev Targets a sender
    /// @param newTargetedSender The sender to be targeted
    function targetSender(address newTargetedSender) internal {
        getState().targetedSenders.push(newTargetedSender);
    }

    /// @dev Targets multiple senders
    /// @param newTargetedSenders The senders to be targeted
    function targetSenders(address[] memory newTargetedSenders) internal {
        for (uint256 i = 0; i < newTargetedSenders.length; i++) {
            targetSender(newTargetedSenders[i]);
        }
    }
}
