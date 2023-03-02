# Strings

### toString

*Transforms an address to a string.*


```solidity
function toString(address value) internal pure returns (string memory);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`value`|`address`|The address to parse.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`string`|The string representation of `value`.|


### toString

*Transforms a byte array to a string.*


```solidity
function toString(bytes memory value) internal pure returns (string memory);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`value`|`bytes`|The byte array to parse.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`string`|The string representation of `value`.|


### toString

*Transforms a bytes32 to a string.*


```solidity
function toString(bytes32 value) internal pure returns (string memory);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`value`|`bytes32`|The bytes32 to parse.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`string`|The string representation of `value`.|


### toString

*Transforms a boolean to a string.*


```solidity
function toString(bool value) internal pure returns (string memory);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`value`|`bool`|The boolean to parse.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`string`|The string representation of `value`.|


### toString

*Transforms an uint256 to a string.*


```solidity
function toString(uint256 value) internal pure returns (string memory);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`value`|`uint256`|The uint256 to parse.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`string`|The string representation of `value`.|


### toString

*Transforms an int256 to a string.*


```solidity
function toString(int256 value) internal pure returns (string memory);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`value`|`int256`|The int256 to parse.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`string`|The string representation of `value`.|


### parseBytes

*Parses a byte array string.*


```solidity
function parseBytes(string memory value) internal pure returns (bytes memory);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`value`|`string`|The string to parse.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`bytes`|The parsed byte array.|


### parseAddress

*Parses an address string.*


```solidity
function parseAddress(string memory value) internal pure returns (address);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`value`|`string`|The string to parse.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`address`|The parsed address.|


### parseUint

*Parses an uint256 string.*


```solidity
function parseUint(string memory value) internal pure returns (uint256);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`value`|`string`|The string to parse.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`uint256`|The parsed uint256.|


### parseInt

*Parses an int256 string.*


```solidity
function parseInt(string memory value) internal pure returns (int256);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`value`|`string`|The string to parse.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`int256`|The parsed int256.|


### parseBytes32

*Parses a bytes32 string.*


```solidity
function parseBytes32(string memory value) internal pure returns (bytes32);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`value`|`string`|The string to parse.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`bytes32`|The parsed bytes32.|


### parseBool

*Parses a boolean string.*


```solidity
function parseBool(string memory value) internal pure returns (bool);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`value`|`string`|The string to parse.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`bool`|The parsed boolean.|


