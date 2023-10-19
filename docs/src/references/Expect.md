# Expect

## Structs

### _BoolExpectation

```solidity
struct _BoolExpectation {
	bool actual
	_BoolExpectationNot not
}
```



### _BoolExpectationNot

```solidity
struct _BoolExpectationNot {
	bool actual
}
```



### _UintExpectation

```solidity
struct _UintExpectation {
	uint256 actual
	_UintExpectationNot not
}
```



### _UintExpectationNot

```solidity
struct _UintExpectationNot {
	uint256 actual
}
```



### _IntExpectation

```solidity
struct _IntExpectation {
	int256 actual
	_IntExpectationNot not
}
```



### _IntExpectationNot

```solidity
struct _IntExpectationNot {
	int256 actual
}
```



### _AddressExpectation

```solidity
struct _AddressExpectation {
	address actual
	_AddressExpectationNot not
}
```



### _AddressExpectationNot

```solidity
struct _AddressExpectationNot {
	address actual
}
```



### _Bytes32Expectation

```solidity
struct _Bytes32Expectation {
	bytes32 actual
	_Bytes32ExpectationNot not
}
```



### _Bytes32ExpectationNot

```solidity
struct _Bytes32ExpectationNot {
	bytes32 actual
}
```



### _BytesExpectation

```solidity
struct _BytesExpectation {
	bytes actual
	_BytesExpectationNot not
}
```



### _BytesExpectationNot

```solidity
struct _BytesExpectationNot {
	bytes actual
}
```



### _StringExpectation

```solidity
struct _StringExpectation {
	string actual
	_StringExpectationNot not
}
```



### _StringExpectationNot

```solidity
struct _StringExpectationNot {
	string actual
}
```



### _CallExpectation

```solidity
struct _CallExpectation {
	Call call
	_CallExpectationNot not
}
```



### _CallExpectationNot

```solidity
struct _CallExpectationNot {
	Call call
}
```



## Functions

### **expect(bool actual) &rarr; (_BoolExpectation)**



### **expect(uint256 actual) &rarr; (_UintExpectation)**



### **expect(int256 actual) &rarr; (_IntExpectation)**



### **expect(address actual) &rarr; (_AddressExpectation)**



### **expect(bytes32 actual) &rarr; (_Bytes32Expectation)**



### **expect(bytes actual) &rarr; (_BytesExpectation)**



### **expect(string actual) &rarr; (_StringExpectation)**



### **expect(Call call) &rarr; (_CallExpectation)**



### **any() &rarr; (bytes32)**



## ExpectLib



### **toEqual(_BoolExpectation self, bool expected)**



### **toEqual(_BoolExpectationNot self, bool expected)**



### **toBeTrue(_BoolExpectation self)**



### **toBeFalse(_BoolExpectation self)**



### **toEqual(_AddressExpectation self, address expected)**



### **toEqual(_AddressExpectationNot self, address expected)**



### **toBeAContract(_AddressExpectation self)**



### **toBeAContract(_AddressExpectationNot self)**



### **toEqual(_Bytes32Expectation self, bytes32 expected)**



### **toEqual(_Bytes32ExpectationNot self, bytes32 expected)**



### **toBeTheHashOf(_Bytes32Expectation self, bytes data)**



### **toBeTheHashOf(_Bytes32ExpectationNot self, bytes data)**



### **toEqual(_BytesExpectation self, bytes expected)**



### **toEqual(_BytesExpectationNot self, bytes expected)**



### **toEqual(_StringExpectation self, string expected)**



### **toEqual(_StringExpectationNot self, string expected)**



### **toContain(_StringExpectation self, string contained)**



### **toContain(_StringExpectationNot self, string contained)**



### **toHaveLength(_StringExpectation self, uint256 expected)**



### **toHaveLength(_StringExpectationNot self, uint256 expected)**



### **toEqual(_UintExpectation self, uint256 expected)**



### **toEqual(_UintExpectationNot self, uint256 expected)**



### **toBeCloseTo(_UintExpectation self, uint256 expected, uint256 d)**



### **toBeLessThan(_UintExpectation self, uint256 expected)**



### **toBeLessThanOrEqual(_UintExpectation self, uint256 expected)**



### **toBeGreaterThan(_UintExpectation self, uint256 expected)**



### **toBeGreaterThanOrEqual(_UintExpectation self, uint256 expected)**



### **toEqual(_IntExpectation self, int256 expected)**



### **toEqual(_IntExpectationNot self, int256 expected)**



### **toBeCloseTo(_IntExpectation self, int256 expected, uint256 d)**



### **toBeLessThan(_IntExpectation self, int256 expected)**



### **toBeLessThanOrEqual(_IntExpectation self, int256 expected)**



### **toBeGreaterThan(_IntExpectation self, int256 expected)**



### **toBeGreaterThanOrEqual(_IntExpectation self, int256 expected)**



### **toHaveReverted(_CallExpectation self)**



### **toHaveRevertedWith(_CallExpectation self, bytes4 expectedSelector)**



### **toHaveRevertedWith(_CallExpectationNot self, bytes4 expectedSelector)**



### **toHaveRevertedWith(_CallExpectation self, string error)**



### **toHaveRevertedWith(_CallExpectationNot self, string error)**



### **toHaveRevertedWith(_CallExpectation self, bytes expectedError)**



### **toHaveRevertedWith(_CallExpectationNot self, bytes expectedError)**



### **toHaveSucceeded(_CallExpectation self)**



### **toHaveEmitted(_CallExpectation self, string eventSig)**



### **toHaveEmitted(_CallExpectation self, bytes32[1] topics)**



### **toHaveEmitted(_CallExpectation self, bytes32[2] topics)**



### **toHaveEmitted(_CallExpectation self, bytes32[3] topics)**



### **toHaveEmitted(_CallExpectation self, bytes32[4] topics)**



### **toHaveEmitted(_CallExpectation self, string eventSig, bytes data)**



### **toHaveEmitted(_CallExpectation self, string eventSig, bytes32[1] topics)**



### **toHaveEmitted(_CallExpectation self, string eventSig, bytes32[2] topics)**



### **toHaveEmitted(_CallExpectation self, string eventSig, bytes32[3] topics)**



### **toHaveEmitted(_CallExpectation self, bytes32[1] topics, bytes data)**



### **toHaveEmitted(_CallExpectation self, bytes32[2] topics, bytes data)**



### **toHaveEmitted(_CallExpectation self, bytes32[3] topics, bytes data)**



### **toHaveEmitted(_CallExpectation self, bytes32[4] topics, bytes data)**



### **toHaveEmitted(_CallExpectation self, string eventSig, bytes32[1] topics, bytes data)**



### **toHaveEmitted(_CallExpectation self, string eventSig, bytes32[2] topics, bytes data)**



### **toHaveEmitted(_CallExpectation self, string eventSig, bytes32[3] topics, bytes data)**



### **toHaveEmitted(_CallExpectation self, string eventSig, bytes32[] topics, bytes data)**



## AnyLib



### **value() &rarr; (bytes32)**



### **check(bytes32 val) &rarr; (bool res)**



