# Watchers

## Structs

### Call

```solidity
struct Call {
	bytes callData
	bool success
	bytes returnData
	Log[] logs
}
```



## watchersUnsafe



### **watcherAddress(address target) &rarr; (address)**

Obtains the address of the watcher for `target`.

### **targetAddress(address _watcher) &rarr; (address)**

Obtains the address of the target for `_target`.

### **watcher(address target) &rarr; (Watcher)**

Obtains the Watcher implementation for the `target` address.

### **watch(address target) &rarr; (Watcher)**

Starts watching a `target` address.

### **stop(address target)**

Stops watching the `target` address.

### **stopWatcher(address target)**

Stops watching the `target` address.

### **calls(address target) &rarr; (Call[])**

Obtains all the calls made to the `target` address.

### **getCall(address target, uint256 index) &rarr; (Call)**

Obtains an specific call made to the `target` address at an specific index.

### **firstCall(address target) &rarr; (Call)**

Obtains the first call made to the `target` address.

### **lastCall(address target) &rarr; (Call)**

Obtains the last call made to the `target` address.

### **captureReverts(address target) &rarr; (Watcher)**

Starts capturing reverts for the `target` address. This will prevent the `target` contract to
revert until `disableCaptureReverts` is called. This is meant to be used in conjunction with the `toHaveReverted` and
`toHaveRevertedWith` functions from the expect library.

### **disableCaptureReverts(address target) &rarr; (Watcher)**

Stops capturing reverts for the `target` address.

