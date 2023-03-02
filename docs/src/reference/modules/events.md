# Events

## Functions
### toDynamic

*Transform a fixed array of `bytes32` to a dynamic array of `bytes32`.*


```solidity
function toDynamic(bytes32[1] memory topics) internal pure returns (bytes32[] memory _topics);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`topics`|`bytes32[1]`|The fixed array to transform.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`_topics`|`bytes32[]`|The dynamic array.|


### toDynamic

*Transform a fixed array of `bytes32` to a dynamic array of `bytes32`.*


```solidity
function toDynamic(bytes32[2] memory topics) internal pure returns (bytes32[] memory _topics);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`topics`|`bytes32[2]`|The fixed array to transform.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`_topics`|`bytes32[]`|The dynamic array.|


### toDynamic

*Transform a fixed array of `bytes32` to a dynamic array of `bytes32`.*


```solidity
function toDynamic(bytes32[3] memory topics) internal pure returns (bytes32[] memory _topics);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`topics`|`bytes32[3]`|The fixed array to transform.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`_topics`|`bytes32[]`|The dynamic array.|


### toDynamic

*Transform a fixed array of `bytes32` to a dynamic array of `bytes32`.*


```solidity
function toDynamic(bytes32[4] memory topics) internal pure returns (bytes32[] memory _topics);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`topics`|`bytes32[4]`|The fixed array to transform.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`_topics`|`bytes32[]`|The dynamic array.|


### topic

*Obtains the topic representation of an `uint256` parameter.*


```solidity
function topic(uint256 _param) internal pure returns (bytes32);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`_param`|`uint256`|The `uint256` value.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`bytes32`|The representation of `_param` as an event topic.|


### topic

*Obtains the topic representation of a `string` parameter.*


```solidity
function topic(string memory _param) internal pure returns (bytes32);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`_param`|`string`|The `string` value.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`bytes32`|The representation of `_param` as an event topic.|


### topic

*Obtains the topic representation of an `address` parameter.*


```solidity
function topic(address _param) internal pure returns (bytes32);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`_param`|`address`|The `address` value.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`bytes32`|The representation of `_param` as an event topic.|


### topic

*Obtains the topic representation of a `bytes32` parameter.*


```solidity
function topic(bytes32 _param) internal pure returns (bytes32);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`_param`|`bytes32`|The `bytes32` value.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`bytes32`|The representation of `_param` as an event topic.|


### topic

*Obtains the topic representation of a `bytes` parameter.*


```solidity
function topic(bytes memory _param) internal pure returns (bytes32);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`_param`|`bytes`|The `bytes` value.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`bytes32`|The representation of `_param` as an event topic.|


### topic

*Obtains the topic representation of a `bool` parameter.*


```solidity
function topic(bool _param) internal pure returns (bytes32);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`_param`|`bool`|The `bool` value.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`bytes32`|The representation of `_param` as an event topic.|


### topic

*Obtains the topic representation of a `int256` parameter.*


```solidity
function topic(int256 _param) internal pure returns (bytes32);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`_param`|`int256`|The `int256` value.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`bytes32`|The representation of `_param` as an event topic.|


### recordLogs

*Starts recording all transactions logs.*


```solidity
function recordLogs() internal;
```

### getRecordedLogs

*Obtains all recorded transactions logs.*


```solidity
function getRecordedLogs() internal returns (Log[] memory logs);
```

