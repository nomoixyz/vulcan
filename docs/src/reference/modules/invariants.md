# Invariants

 ```solidity
 struct FuzzSelector {
    address addr;
    bytes4[] selectors;
}
```

#### **`excludeContract(address newExcludedContract)`**

Excludes a contract.

#### **`excludeContracts(address[] memory newExcludedContracts)`**

Excludes multiple contracts.

#### **`excludeSender(address newExcludedSender)`**

Excludes a sender.

#### **`excludeSenders(address[] memory newExcludedSenders)`**

Excludes multiple senders.

#### **`excludeArtifact(string memory newExcludedArtifact)`**

Excludes an artifact.

#### **`excludeArtifacts(string[] memory newExcludedArtifacts)`**

Excludes multiple artifacts.

#### **`targetArtifact(string memory newTargetedArtifact)`**

Targets an artifact.

#### **`targetArtifacts(string[] memory newTargetedArtifacts)`**

Targets multiple artifacts.

#### **`targetArtifactSelector(FuzzSelector memory newTargetedArtifactSelector)`**

Targets an artifact selector.

#### **`targetArtifactSelectors(FuzzSelector[] memory newTargetedArtifactSelectors)`**

Targets multiple artifact selectors.

#### **`targetContract(address newTargetedContract)`**

Targets a contract.

#### **`targetContracts(address[] memory newTargetedContracts)`**

Targets multiple contracts.

#### **`targetSelector(FuzzSelector memory newTargetedSelector)`**

Targets a selector.

#### **`targetSelectors(FuzzSelector[] memory newTargetedSelectors)`**

Targets multiple selectors.

#### **`targetSender(address newTargetedSender)`**

Targets a sender.

#### **`targetSenders(address[] memory newTargetedSenders)`**

Targets multiple senders.
