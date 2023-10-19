# Vulcan

## Structs

### Log

```solidity
struct Log {
	bytes32[] topics
	bytes data
	address emitter
}
```

Struct that represent an EVM log

## vulcan



### **init()**

Initializes the context module

### **failed() &rarr; (bool)**

Checks if `fail` was called at some point.

### **fail()**

Signal that an expectation/assertion failed.

### **clearFailure()**

Resets the failed state.

### **watch(address _target) &rarr; (Watcher)**

Starts monitoring an address.

### **stopWatcher(address _target)**

Stops monitoring an address.

