# Invariants

## Structs

### FuzzSelector

```solidity
struct FuzzSelector {
	address addr
	bytes4[] selectors
}
```

A struct that represents a Fuzz Selector

## invariants



### **getState() &rarr; (State state)**

Returns the state struct that contains the invariants related data

### **excludeContract(address newExcludedContract)**

Excludes a contract

### **excludeContracts(address[] newExcludedContracts)**

Excludes multiple contracts

### **excludeSender(address newExcludedSender)**

Excludes a sender

### **excludeSenders(address[] newExcludedSenders)**

Excludes multiple senders

### **excludeArtifact(string newExcludedArtifact)**

Excludes an artifact

### **excludeArtifacts(string[] newExcludedArtifacts)**

Excludes multiple artifacts

### **targetArtifact(string newTargetedArtifact)**

Targets an artifact

### **targetArtifacts(string[] newTargetedArtifacts)**

Targets multiple artifacts

### **targetArtifactSelector(FuzzSelector newTargetedArtifactSelector)**

Targets an artifact selector

### **targetArtifactSelectors(FuzzSelector[] newTargetedArtifactSelectors)**

Targets multiple artifact selectors

### **targetContract(address newTargetedContract)**

Targets a contract

### **targetContracts(address[] newTargetedContracts)**

Targets multiple contracts

### **targetSelector(FuzzSelector newTargetedSelector)**

Targets a selector

### **targetSelectors(FuzzSelector[] newTargetedSelectors)**

Targets multiple selectors

### **targetSender(address newTargetedSender)**

Targets a sender

### **targetSenders(address[] newTargetedSenders)**

Targets multiple senders

