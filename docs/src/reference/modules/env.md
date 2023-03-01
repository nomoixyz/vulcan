# Env

Set and read environmental variables.

```solidity
import { Test, env } from "vulcan/test.sol";

contract TestMyContract is Test {
    function testMyContract() external {
        env.set("MY_VAR", string("Hello World"));

        string memory MY_VAR = env.getString("MY_VAR");
    }
}
```

### set

*sets the value of the  environment variable with name `name` to `value`.*


```solidity
function set(string memory name, string memory value) internal;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`name`|`string`|the name of the environment variable.|
|`value`|`string`|the new value of the environment variable.|


### getBool

*Reads the environment variable with name `name` and returns the value as `bool`.*


```solidity
function getBool(string memory name) internal view returns (bool);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`name`|`string`|the name of the environment variable to read.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`bool`|the value of the environment variable as `bool`.|


### getUint

*Reads the environment variable with name `name` and returns the value as `uint256`.*


```solidity
function getUint(string memory name) internal view returns (uint256);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`name`|`string`|the name of the environment variable to read.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`uint256`|the value of the environment variable as `uint256`.|


### getInt

*Reads the environment variable with name `name` and returns the value as `int256`.*


```solidity
function getInt(string memory name) internal view returns (int256);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`name`|`string`|the name of the environment variable to read.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`int256`|the value of the environment variable as `int256`.|


### getAddress

*Reads the environment variable with name `name` and returns the value as `address`.*


```solidity
function getAddress(string memory name) internal view returns (address);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`name`|`string`|the name of the environment variable to read.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`address`|the value of the environment variable as `address`.|


### getBytes32

*Reads the environment variable with name `name` and returns the value as `bytes32`.*


```solidity
function getBytes32(string memory name) internal view returns (bytes32);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`name`|`string`|the name of the environment variable to read.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`bytes32`|the value of the environment variable as `bytes32`.|


### getString

*Reads the environment variable with name `name` and returns the value as `string`.*


```solidity
function getString(string memory name) internal view returns (string memory);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`name`|`string`|the name of the environment variable to read.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`string`|the value of the environment variable as `string`.|


### getBytes

*Reads the environment variable with name `name` and returns the value as `bytes`.*


```solidity
function getBytes(string memory name) internal view returns (bytes memory);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`name`|`string`|the name of the environment variable to read.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`bytes`|the value of the environment variable as `bytes`.|


### getBoolArray

*Reads the environment variable with name `name` and returns the value as `bool[]`.*


```solidity
function getBoolArray(string memory name, string memory delim) internal view returns (bool[] memory);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`name`|`string`|the name of the environment variable to read.|
|`delim`|`string`|the delimiter used to split the values.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`bool[]`|the value of the environment variable as `bool[]`.|


### getUintArray

*Reads the environment variable with name `name` and returns the value as `uint256[]`.*


```solidity
function getUintArray(string memory name, string memory delim) internal view returns (uint256[] memory);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`name`|`string`|the name of the environment variable to read.|
|`delim`|`string`|the delimiter used to split the values.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`uint256[]`|the value of the environment variable as `uint256[]`.|


### getIntArray

*Reads the environment variable with name `name` and returns the value as `int256[]`.*


```solidity
function getIntArray(string memory name, string memory delim) internal view returns (int256[] memory);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`name`|`string`|the name of the environment variable to read.|
|`delim`|`string`|the delimiter used to split the values.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`int256[]`|the value of the environment variable as `int256[]`.|


### getAddressArray

*Reads the environment variable with name `name` and returns the value as `address[]`.*


```solidity
function getAddressArray(string memory name, string memory delim) internal view returns (address[] memory);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`name`|`string`|the name of the environment variable to read.|
|`delim`|`string`|the delimiter used to split the values.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`address[]`|the value of the environment variable as `address[]`.|


### getBytes32Array

*Reads the environment variable with name `name` and returns the value as `bytes32[]`.*


```solidity
function getBytes32Array(string memory name, string memory delim) internal view returns (bytes32[] memory);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`name`|`string`|the name of the environment variable to read.|
|`delim`|`string`|the delimiter used to split the values.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`bytes32[]`|the value of the environment variable as `bytes32[]`.|


### getStringArray

*Reads the environment variable with name `name` and returns the value as `string[]`.*


```solidity
function getStringArray(string memory name, string memory delim) internal view returns (string[] memory);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`name`|`string`|the name of the environment variable to read.|
|`delim`|`string`|the delimiter used to split the values.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`string[]`|the value of the environment variable as `string[]`.|


### getBytesArray

*Reads the environment variable with name `name` and returns the value as `bytes[]`.*


```solidity
function getBytesArray(string memory name, string memory delim) internal view returns (bytes[] memory);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`name`|`string`|the name of the environment variable to read.|
|`delim`|`string`|the delimiter used to split the values.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`bytes[]`|the value of the environment variable as `bytes[]`.|


### getBool

*Reads the environment variable with name `name` and returns the value as `bool`.*


```solidity
function getBool(string memory name, bool defaultValue) internal returns (bool value);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`name`|`string`|The name of the environment variable to read.|
|`defaultValue`|`bool`|The value to return if the environment variable doesn't exists.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`value`|`bool`|The value of the environment variable as `bool`.|


### getUint

*Reads the environment variable with name `name` and returns the value as `uint256`.*


```solidity
function getUint(string memory name, uint256 defaultValue) external returns (uint256 value);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`name`|`string`|The name of the environment variable to read.|
|`defaultValue`|`uint256`|The value to return if the environment variable doesn't exists.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`value`|`uint256`|The value of the environment variable as `uint256`.|


### getInt

*Reads the environment variable with name `name` and returns the value as `int256`.*


```solidity
function getInt(string memory name, int256 defaultValue) external returns (int256 value);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`name`|`string`|The name of the environment variable to read.|
|`defaultValue`|`int256`|The value to return if the environment variable doesn't exists.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`value`|`int256`|The value of the environment variable as `int256`.|


### getAddress

*Reads the environment variable with name `name` and returns the value as `address`.*


```solidity
function getAddress(string memory name, address defaultValue) external returns (address value);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`name`|`string`|The name of the environment variable to read.|
|`defaultValue`|`address`|The value to return if the environment variable doesn't exists.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`value`|`address`|The value of the environment variable as `address`.|


### getBytes32

*Reads the environment variable with name `name` and returns the value as `bytes32`.*


```solidity
function getBytes32(string memory name, bytes32 defaultValue) external returns (bytes32 value);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`name`|`string`|The name of the environment variable to read.|
|`defaultValue`|`bytes32`|The value to return if the environment variable doesn't exists.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`value`|`bytes32`|The value of the environment variable as `bytes32`.|


### getString

*Reads the environment variable with name `name` and returns the value as `string`.*


```solidity
function getString(string memory name, string memory defaultValue) external returns (string memory value);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`name`|`string`|The name of the environment variable to read.|
|`defaultValue`|`string`|The value to return if the environment variable doesn't exists.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`value`|`string`|The value of the environment variable as `string`.|


### getBytes

*Reads the environment variable with name `name` and returns the value as `bytes`.*


```solidity
function getBytes(string memory name, bytes memory defaultValue) external returns (bytes memory value);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`name`|`string`|The name of the environment variable to read.|
|`defaultValue`|`bytes`|The value to return if the environment variable doesn't exists.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`value`|`bytes`|The value of the environment variable as `bytes`.|


### getBoolArray

*Reads the environment variable with name `name` and returns the value as `bool[]`.*


```solidity
function getBoolArray(string memory name, string memory delim, bool[] memory defaultValue)
    external
    returns (bool[] memory value);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`name`|`string`|the name of the environment variable to read.|
|`delim`|`string`|the delimiter used to split the values.|
|`defaultValue`|`bool[]`|The value to return if the environment variable doesn't exists.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`value`|`bool[]`|The value of the environment variable as `bool[]`.|


### getUintArray

*Reads the environment variable with name `name` and returns the value as `uint256[]`.*


```solidity
function getUintArray(string memory name, string memory delim, uint256[] memory defaultValue)
    external
    returns (uint256[] memory value);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`name`|`string`|the name of the environment variable to read.|
|`delim`|`string`|the delimiter used to split the values.|
|`defaultValue`|`uint256[]`|The value to return if the environment variable doesn't exists.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`value`|`uint256[]`|The value of the environment variable as `uint256[]`.|


### getIntArray

*Reads the environment variable with name `name` and returns the value as `int256[]`.*


```solidity
function getIntArray(string memory name, string memory delim, int256[] memory defaultValue)
    external
    returns (int256[] memory value);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`name`|`string`|the name of the environment variable to read.|
|`delim`|`string`|the delimiter used to split the values.|
|`defaultValue`|`int256[]`|The value to return if the environment variable doesn't exists.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`value`|`int256[]`|The value of the environment variable as `int256[]`.|


### getAddressArray

*Reads the environment variable with name `name` and returns the value as `address[]`.*


```solidity
function getAddressArray(string memory name, string memory delim, address[] memory defaultValue)
    external
    returns (address[] memory value);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`name`|`string`|the name of the environment variable to read.|
|`delim`|`string`|the delimiter used to split the values.|
|`defaultValue`|`address[]`|The value to return if the environment variable doesn't exists.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`value`|`address[]`|The value of the environment variable as `address[]`.|


### getBytes32Array

*Reads the environment variable with name `name` and returns the value as `bytes32[]`.*


```solidity
function getBytes32Array(string memory name, string memory delim, bytes32[] memory defaultValue)
    external
    returns (bytes32[] memory value);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`name`|`string`|the name of the environment variable to read.|
|`delim`|`string`|the delimiter used to split the values.|
|`defaultValue`|`bytes32[]`|The value to return if the environment variable doesn't exists.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`value`|`bytes32[]`|The value of the environment variable as `bytes32[]`.|


### getStringArray

*Reads the environment variable with name `name` and returns the value as `string[]`.*


```solidity
function getStringArray(string memory name, string memory delim, string[] memory defaultValue)
    external
    returns (string[] memory value);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`name`|`string`|the name of the environment variable to read.|
|`delim`|`string`|the delimiter used to split the values.|
|`defaultValue`|`string[]`|The value to return if the environment variable doesn't exists.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`value`|`string[]`|The value of the environment variable as `string[]`.|


### getBytesArray

*Reads the environment variable with name `name` and returns the value as `bytes[]`.*


```solidity
function getBytesArray(string memory name, string memory delim, bytes[] memory defaultValue)
    external
    returns (bytes[] memory value);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`name`|`string`|the name of the environment variable to read.|
|`delim`|`string`|the delimiter used to split the values.|
|`defaultValue`|`bytes[]`|The value to return if the environment variable doesn't exists.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`value`|`bytes[]`|The value of the environment variable as `bytes[]`.|


