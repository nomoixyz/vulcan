# Result

## Custom types

### Bytes32Result

```solidity
type Bytes32Result is bytes32;
```



### BytesResult

```solidity
type BytesResult is bytes32;
```



### StringResult

```solidity
type StringResult is bytes32;
```



### BoolResult

```solidity
type BoolResult is bytes32;
```



### EmptyResult

```solidity
type EmptyResult is bytes32;
```



## Functions

### **Ok() &rarr; (EmptyResult)**



### **Ok(bytes32 value) &rarr; (Bytes32Result)**



### **Ok(bytes value) &rarr; (BytesResult)**



### **Ok(string value) &rarr; (StringResult)**



### **Ok(bool value) &rarr; (BoolResult)**



## LibResultPointer



### **decode(Pointer self) &rarr; (ResultType, Pointer)**



### **isError(Pointer self) &rarr; (bool)**



### **isOk(Pointer self) &rarr; (bool)**



### **toError(Pointer self) &rarr; (Error)**



### **unwrap(Pointer self) &rarr; (Pointer ptr)**



### **expect(Pointer self, string err) &rarr; (Pointer ptr)**



## LibBytes32ResultPointer



### **toBytes32Result(Pointer self) &rarr; (Bytes32Result res)**



## LibBytes32Result



### **isError(Bytes32Result self) &rarr; (bool)**



### **isOk(Bytes32Result self) &rarr; (bool)**



### **toError(Bytes32Result self) &rarr; (Error)**



### **toValue(Bytes32Result self) &rarr; (bytes32)**



### **unwrap(Bytes32Result self) &rarr; (bytes32)**



### **expect(Bytes32Result self, string err) &rarr; (bytes32)**



### **toPointer(Bytes32Result self) &rarr; (Pointer)**



## LibBytesResultPointer



### **toBytesResult(Pointer self) &rarr; (BytesResult res)**



## LibBytesResult



### **isOk(BytesResult self) &rarr; (bool)**



### **isError(BytesResult self) &rarr; (bool)**



### **unwrap(BytesResult self) &rarr; (bytes)**



### **expect(BytesResult self, string err) &rarr; (bytes)**



### **toError(BytesResult self) &rarr; (Error)**



### **toValue(BytesResult self) &rarr; (bytes)**



### **toPointer(BytesResult self) &rarr; (Pointer)**



## LibStringResultPointer



### **toStringResult(Pointer self) &rarr; (StringResult res)**



## LibStringResult



### **isOk(StringResult self) &rarr; (bool)**



### **isError(StringResult self) &rarr; (bool)**



### **unwrap(StringResult self) &rarr; (string val)**



### **expect(StringResult self, string err) &rarr; (string)**



### **toError(StringResult self) &rarr; (Error)**



### **toValue(StringResult self) &rarr; (string val)**



### **toPointer(StringResult self) &rarr; (Pointer)**



## LibBoolResultPointer



### **toBoolResult(Pointer self) &rarr; (BoolResult res)**



## LibBoolResult



### **isOk(BoolResult self) &rarr; (bool)**



### **isError(BoolResult self) &rarr; (bool)**



### **unwrap(BoolResult self) &rarr; (bool val)**



### **expect(BoolResult self, string err) &rarr; (bool)**



### **toError(BoolResult self) &rarr; (Error)**



### **toValue(BoolResult self) &rarr; (bool val)**



### **toPointer(BoolResult self) &rarr; (Pointer)**



## LibEmptyResultPointer



### **toEmptyResult(Pointer self) &rarr; (EmptyResult res)**



## LibEmptyResult



### **isOk(EmptyResult self) &rarr; (bool)**



### **isError(EmptyResult self) &rarr; (bool)**



### **unwrap(EmptyResult self)**



### **expect(EmptyResult self, string err)**



### **toError(EmptyResult self) &rarr; (Error)**



### **toPointer(EmptyResult self) &rarr; (Pointer)**



## LibResultType



### **encode(ResultType _type, Pointer _dataPtr) &rarr; (Pointer result)**



