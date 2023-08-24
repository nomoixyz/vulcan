# Invariants

 ```solidity
 struct FuzzSelector {
    address addr;
    bytes4[] selectors;
}
```

#### **`excludeContract(address newExcludedContract)`**

Excludes a contract from the invariant runs. This means that no transactions will be sent to this contract.

#### **`excludeContracts(address[] memory newExcludedContracts)`**

Excludes multiple contracts from the invariant runs. This means that no transactions will be sent to these contracts.

#### **`excludeSender(address newExcludedSender)`**

Excludes a sender from the invariant runs. This means that the address will not be used as the sender of a transaction.

#### **`excludeSenders(address[] memory newExcludedSenders)`**

Excludes multiple senders from the invariant runs. This means that these addresses will not be used as the senders of transactions.

#### **`excludeArtifact(string memory newExcludedArtifact)`**

Excludes an artifact from the invariant runs. This means that contracts with this artifact will not be targeted.

#### **`excludeArtifacts(string[] memory newExcludedArtifacts)`**

Excludes multiple artifacts from the invariant runs. This means that contracts with these artifacts will not be targeted.

#### **`targetArtifact(string memory newTargetedArtifact)`**

Targets an artifact in the invariant runs. This means that contracts with this artifact will be specifically targeted.

#### **`targetArtifacts(string[] memory newTargetedArtifacts)`**

Targets multiple artifacts in the invariant runs. This means that contracts with these artifacts will be specifically targeted.

#### **`targetArtifactSelector(FuzzSelector memory newTargetedArtifactSelector)`**

Targets an artifact selector in the invariant runs. This means that the specific artifact selector will be targeted.

#### **`targetArtifactSelectors(FuzzSelector[] memory newTargetedArtifactSelectors)`**

Targets multiple artifact selectors in the invariant runs. This means that these specific artifact selectors will be targeted.

#### **`targetContract(address newTargetedContract)`**

Targets a contract in the invariant runs. This means that transactions will be specifically sent to this contract.

#### **`targetContracts(address[] memory newTargetedContracts)`**

Targets multiple contracts in the invariant runs. This means that transactions will be specifically sent to these contracts.

#### **`targetSelector(FuzzSelector memory newTargetedSelector)`**

Targets a selector in the invariant runs. This means that the specific selector will be targeted.

#### **`targetSelectors(FuzzSelector[] memory newTargetedSelectors)`**

Targets multiple selectors in the invariant runs. This means that these specific selectors will be targeted.

#### **`targetSender(address newTargetedSender)`**

Targets a sender in the invariant runs. This means that the address will be specifically used as the sender of a transaction.

#### **`targetSenders(address[] memory newTargetedSenders)`**

Targets multiple senders in the invariant runs. This means that these addresses will be specifically used as the senders of transactions.

