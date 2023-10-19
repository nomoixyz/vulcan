# Forks

## Custom types

### Fork

```solidity
type Fork is uint256;
```

Holds a fork's id.

## forksUnsafe



### **create(string nameOrEndpoint) &rarr; (Fork)**

Create a new fork using the provided endpoint.

### **createAtBlock(string nameOrEndpoint, uint256 blockNumber) &rarr; (Fork)**

Create a new fork using the provided endpoint at a given block number.

### **createBeforeTx(string nameOrEndpoint, bytes32 txHash) &rarr; (Fork)**

Create a new fork using the provided endpoint at a state right before the provided transaction hash.

### **select(Fork self) &rarr; (Fork)**

Set the provided fork as the current active fork.

### **active() &rarr; (Fork)**

Get the current active fork.

### **setBlockNumber(Fork self, uint256 blockNumber) &rarr; (Fork)**

Set the block number of the provided fork.

### **beforeTx(Fork self, bytes32 txHash) &rarr; (Fork)**

Set the provided fork to the state right before the provided transaction hash.

### **persistBetweenForks(address self) &rarr; (address)**

Make the state of the provided address persist between forks.

### **persistBetweenForks(address who1, address who2)**

Make the state of the provided addresses persist between forks.

### **persistBetweenForks(address who1, address who2, address who3)**

Make the state of the provided addresses persist between forks.

### **persistBetweenForks(address[] whos)**

Make the state of the provided addresses persist between forks.

### **stopPersist(address who) &rarr; (address)**

Revoke the persistent state of the provided address.

### **stopPersist(address[] whos)**

Revoke the persistent state of the provided addresses.

### **isPersistent(address who) &rarr; (bool)**

Check if the provided address is being persisted between forks.

### **allowCheatcodes(address who) &rarr; (address)**

Allow cheatcodes to be used by the provided address in forking mode.

### **executeTx(bytes32 txHash)**

Executes an existing transaction in the current active fork.

### **executeTx(Fork self, bytes32 txHash) &rarr; (Fork)**

Executes an existing transaction in the provided fork.

