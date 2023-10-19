# Error

## Custom types

### Error

```solidity
type Error is bytes32;
```



## LibError



### **toPointer(Error err) &rarr; (Pointer)**



### **decode(Error err) &rarr; (bytes32 id, string message, bytes data)**



### **encodeError(function fn, string message) &rarr; (Error err)**



### **toErrorId(function fn) &rarr; (bytes32 id)**



### **matches(Error err, function fn) &rarr; (bool)**



### **decodeAs(Error, function)**



### **encodeError(function fn, string message, uint256 p0) &rarr; (Error err)**



### **toErrorId(function fn) &rarr; (bytes32 id)**



### **matches(Error err, function fn) &rarr; (bool)**



### **decodeAs(Error err, function) &rarr; (uint256)**



### **encodeError(function fn, string message, string p0) &rarr; (Error err)**



### **toErrorId(function fn) &rarr; (bytes32 id)**



### **matches(Error err, function fn) &rarr; (bool)**



### **decodeAs(Error err, function) &rarr; (string)**



### **toStringResult(Error self) &rarr; (StringResult)**



### **toBytesResult(Error self) &rarr; (BytesResult)**



### **toBoolResult(Error self) &rarr; (BoolResult)**



