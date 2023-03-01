# Json

Manipulate JSON data.

```solidity
import { Test, JsonObject, json } from "vulcan/test.sol";

contract TestMyContract is Test {
    function testMyContract() external {
        JsonObject memory obj = json.create();
        obj.serialize("foo", true);
        expect(obj.serialized).toEqual('{"foo":true}');
    }
}
```

# JsonObject


```solidity
struct JsonObject {
    string id;
    string serialized;
}
```

### parseObject

*Parses a json object string by key and returns an ABI encoded value.*


```solidity
function parseObject(string memory jsonStr, string memory key) internal pure returns (bytes memory abiEncodedData);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`jsonStr`|`string`|The json string.|
|`key`|`string`|The key from the `jsonStr` to parse.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`abiEncodedData`|`bytes`|The ABI encoded tuple representing the value of the provided key.|


### parseObject

*Parses a json object string and returns an ABI encoded tuple.*


```solidity
function parseObject(string memory jsonStr) internal pure returns (bytes memory abiEncodedData);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`jsonStr`|`string`|The json string.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`abiEncodedData`|`bytes`|The ABI encoded tuple representing the json object.|


### parseObject

*Parses a json object struct by key and returns an ABI encoded value.*


```solidity
function parseObject(JsonObject memory jsonObj, string memory key)
    internal
    pure
    returns (bytes memory abiEncodedData);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`jsonObj`|`JsonObject`|The json object struct.|
|`key`|`string`|The key from the `jsonObject` to parse.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`abiEncodedData`|`bytes`|The ABI encoded tuple representing the value of the provided key.|


### parseObject

*Parses a json object struct and returns an ABI encoded tuple.*


```solidity
function parseObject(JsonObject memory jsonObj) internal pure returns (bytes memory abiEncodedData);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`jsonObj`|`JsonObject`|The json struct.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`abiEncodedData`|`bytes`|The ABI encoded tuple representing the json object.|


### parseUint

*Parses the value of the `key` contained on `jsonStr` as uint256.*


```solidity
function parseUint(string memory jsonStr, string memory key) internal returns (uint256);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`jsonStr`|`string`|The json string.|
|`key`|`string`|The key from the `jsonStr` to parse.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`uint256`|The uint256 value.|


### parseUintArray

*Parses the value of the `key` contained on `jsonStr` as uint256[].*


```solidity
function parseUintArray(string memory jsonStr, string memory key) internal returns (uint256[] memory);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`jsonStr`|`string`|The json string.|
|`key`|`string`|The key from the `jsonStr` to parse.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`uint256[]`|The uint256[] value.|


### parseInt

*Parses the value of the `key` contained on `jsonStr` as int256.*


```solidity
function parseInt(string memory jsonStr, string memory key) internal returns (int256);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`jsonStr`|`string`|The json string.|
|`key`|`string`|The key from the `jsonStr` to parse.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`int256`|The int256 value.|


### parseIntArray

*Parses the value of the `key` contained on `jsonStr` as int256[].*


```solidity
function parseIntArray(string memory jsonStr, string memory key) internal returns (int256[] memory);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`jsonStr`|`string`|The json string.|
|`key`|`string`|The key from the `jsonStr` to parse.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`int256[]`|The int256[] value.|


### parseBool

*Parses the value of the `key` contained on `jsonStr` as bool.*


```solidity
function parseBool(string memory jsonStr, string memory key) internal returns (bool);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`jsonStr`|`string`|The json string.|
|`key`|`string`|The key from the `jsonStr` to parse.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`bool`|The bool value.|


### parseBoolArray

*Parses the value of the `key` contained on `jsonStr` as bool[].*


```solidity
function parseBoolArray(string memory jsonStr, string memory key) internal returns (bool[] memory);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`jsonStr`|`string`|The json string.|
|`key`|`string`|The key from the `jsonStr` to parse.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`bool[]`|The bool[] value.|


### parseAddress

*Parses the value of the `key` contained on `jsonStr` as address.*


```solidity
function parseAddress(string memory jsonStr, string memory key) internal returns (address);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`jsonStr`|`string`|The json string.|
|`key`|`string`|The key from the `jsonStr` to parse.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`address`|The address value.|


### parseAddressArray

*Parses the value of the `key` contained on `jsonStr` as address.*


```solidity
function parseAddressArray(string memory jsonStr, string memory key) internal returns (address[] memory);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`jsonStr`|`string`|The json string.|
|`key`|`string`|The key from the `jsonStr` to parse.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`address[]`|The address value.|


### parseString

*Parses the value of the `key` contained on `jsonStr` as string.*


```solidity
function parseString(string memory jsonStr, string memory key) internal returns (string memory);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`jsonStr`|`string`|The json string.|
|`key`|`string`|The key from the `jsonStr` to parse.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`string`|The string value.|


### parseStringArray

*Parses the value of the `key` contained on `jsonStr` as string[].*


```solidity
function parseStringArray(string memory jsonStr, string memory key) internal returns (string[] memory);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`jsonStr`|`string`|The json string.|
|`key`|`string`|The key from the `jsonStr` to parse.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`string[]`|The string[] value.|


### parseBytes

*Parses the value of the `key` contained on `jsonStr` as bytes.*


```solidity
function parseBytes(string memory jsonStr, string memory key) internal returns (bytes memory);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`jsonStr`|`string`|The json string.|
|`key`|`string`|The key from the `jsonStr` to parse.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`bytes`|The bytes value.|


### parseBytesArray

*Parses the value of the `key` contained on `jsonStr` as bytes[].*


```solidity
function parseBytesArray(string memory jsonStr, string memory key) internal returns (bytes[] memory);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`jsonStr`|`string`|The json string.|
|`key`|`string`|The key from the `jsonStr` to parse.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`bytes[]`|The bytes[] value.|


### parseBytes32

*Parses the value of the `key` contained on `jsonStr` as bytes32.*


```solidity
function parseBytes32(string memory jsonStr, string memory key) internal returns (bytes32);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`jsonStr`|`string`|The json string.|
|`key`|`string`|The key from the `jsonStr` to parse.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`bytes32`|The bytes32 value.|


### parseBytes32Array

*Parses the value of the `key` contained on `jsonStr` as bytes32[].*


```solidity
function parseBytes32Array(string memory jsonStr, string memory key) internal returns (bytes32[] memory);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`jsonStr`|`string`|The json string.|
|`key`|`string`|The key from the `jsonStr` to parse.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`bytes32[]`|The bytes32[] value.|


### create

*Creates a JsonObject struct with an identifier.*


```solidity
function create() internal returns (JsonObject memory);
```
**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`JsonObject`|The JsonObject struct.|


### serialize

*Serializes a key from a JsonObject struct with a boolean value.*


```solidity
function serialize(JsonObject memory obj, string memory valueKey, bool value) internal returns (JsonObject memory);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`obj`|`JsonObject`|The json object to modify.|
|`valueKey`|`string`|The key that will hold the `value`.|
|`value`|`bool`|The value of `valueKey`.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`JsonObject`|The modified JsonObject struct.|


### serialize

*Serializes a key from a JsonObject struct with a uint256 value.*


```solidity
function serialize(JsonObject memory obj, string memory valueKey, uint256 value) internal returns (JsonObject memory);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`obj`|`JsonObject`|The json object to modify.|
|`valueKey`|`string`|The key that will hold the `value`.|
|`value`|`uint256`|The value of `valueKey`.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`JsonObject`|The modified JsonObject struct.|


### serialize

*Serializes a key from a JsonObject struct with a int256 value.*


```solidity
function serialize(JsonObject memory obj, string memory valueKey, int256 value) internal returns (JsonObject memory);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`obj`|`JsonObject`|The json object to modify.|
|`valueKey`|`string`|The key that will hold the `value`.|
|`value`|`int256`|The value of `valueKey`.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`JsonObject`|The modified JsonObject struct.|


### serialize

*Serializes a key from a JsonObject struct with a address value.*


```solidity
function serialize(JsonObject memory obj, string memory valueKey, address value) internal returns (JsonObject memory);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`obj`|`JsonObject`|The json object to modify.|
|`valueKey`|`string`|The key that will hold the `value`.|
|`value`|`address`|The value of `valueKey`.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`JsonObject`|The modified JsonObject struct.|


### serialize

*Serializes a key from a JsonObject struct with a bytes32 value.*


```solidity
function serialize(JsonObject memory obj, string memory valueKey, bytes32 value) internal returns (JsonObject memory);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`obj`|`JsonObject`|The json object to modify.|
|`valueKey`|`string`|The key that will hold the `value`.|
|`value`|`bytes32`|The value of `valueKey`.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`JsonObject`|The modified JsonObject struct.|


### serialize

*Serializes a key from a JsonObject struct with a string value.*


```solidity
function serialize(JsonObject memory obj, string memory valueKey, string memory value)
    internal
    returns (JsonObject memory);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`obj`|`JsonObject`|The json object to modify.|
|`valueKey`|`string`|The key that will hold the `value`.|
|`value`|`string`|The value of `valueKey`.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`JsonObject`|The modified JsonObject struct.|


### serialize

*Serializes a key from a JsonObject struct with a bytes value.*


```solidity
function serialize(JsonObject memory obj, string memory valueKey, bytes memory value)
    internal
    returns (JsonObject memory);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`obj`|`JsonObject`|The json object to modify.|
|`valueKey`|`string`|The key that will hold the `value`.|
|`value`|`bytes`|The value of `valueKey`.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`JsonObject`|The modified JsonObject struct.|


### serialize

*Serializes a key from a JsonObject struct with a bool[] value.*


```solidity
function serialize(JsonObject memory obj, string memory valueKey, bool[] memory values)
    internal
    returns (JsonObject memory);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`obj`|`JsonObject`|The json object to modify.|
|`valueKey`|`string`|The key that will hold the `value`.|
|`values`|`bool[]`|The value of `valueKey`.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`JsonObject`|The modified JsonObject struct.|


### serialize

*Serializes a key from a JsonObject struct with a uint256[] value.*


```solidity
function serialize(JsonObject memory obj, string memory valueKey, uint256[] memory values)
    internal
    returns (JsonObject memory);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`obj`|`JsonObject`|The json object to modify.|
|`valueKey`|`string`|The key that will hold the `value`.|
|`values`|`uint256[]`|The value of `valueKey`.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`JsonObject`|The modified JsonObject struct.|


### serialize

*Serializes a key from a JsonObject struct with a int256[] value.*


```solidity
function serialize(JsonObject memory obj, string memory valueKey, int256[] memory values)
    internal
    returns (JsonObject memory);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`obj`|`JsonObject`|The json object to modify.|
|`valueKey`|`string`|The key that will hold the `value`.|
|`values`|`int256[]`|The value of `valueKey`.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`JsonObject`|The modified JsonObject struct.|


### serialize

*Serializes a key from a JsonObject struct with a address[] value.*


```solidity
function serialize(JsonObject memory obj, string memory valueKey, address[] memory values)
    internal
    returns (JsonObject memory);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`obj`|`JsonObject`|The json object to modify.|
|`valueKey`|`string`|The key that will hold the `value`.|
|`values`|`address[]`|The value of `valueKey`.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`JsonObject`|The modified JsonObject struct.|


### serialize

*Serializes a key from a JsonObject struct with a bytes32[] value.*


```solidity
function serialize(JsonObject memory obj, string memory valueKey, bytes32[] memory values)
    internal
    returns (JsonObject memory);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`obj`|`JsonObject`|The json object to modify.|
|`valueKey`|`string`|The key that will hold the `value`.|
|`values`|`bytes32[]`|The value of `valueKey`.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`JsonObject`|The modified JsonObject struct.|


### serialize

*Serializes a key from a JsonObject struct with a string[] value.*


```solidity
function serialize(JsonObject memory obj, string memory valueKey, string[] memory values)
    internal
    returns (JsonObject memory);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`obj`|`JsonObject`|The json object to modify.|
|`valueKey`|`string`|The key that will hold the `value`.|
|`values`|`string[]`|The value of `valueKey`.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`JsonObject`|The modified JsonObject struct.|


### serialize

*Serializes a key from a JsonObject struct with a string[] value.*


```solidity
function serialize(JsonObject memory obj, string memory valueKey, bytes[] memory values)
    internal
    returns (JsonObject memory);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`obj`|`JsonObject`|The json object to modify.|
|`valueKey`|`string`|The key that will hold the `value`.|
|`values`|`bytes[]`|The value of `valueKey`.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`JsonObject`|The modified JsonObject struct.|


### serialize

*Serializes a key from a JsonObject struct with a JsonObject value.*


```solidity
function serialize(JsonObject memory obj, string memory valueKey, JsonObject memory value)
    internal
    returns (JsonObject memory);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`obj`|`JsonObject`|The json object to modify.|
|`valueKey`|`string`|The key that will hold the `value`.|
|`value`|`JsonObject`|The value of `valueKey`.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`JsonObject`|The modified JsonObject struct.|


### write

*Writes a JsonObject struct to a file.*


```solidity
function write(JsonObject memory obj, string memory path) internal;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`obj`|`JsonObject`|The json object that will be stored as a file.|
|`path`|`string`|The path where the file will be saved.|


### write

*Writes a JsonObject struct to an existing json file modifiyng only a specific key.*


```solidity
function write(JsonObject memory obj, string memory path, string memory valueKey) internal;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`obj`|`JsonObject`|The json object that contains a value on `valueKey`.|
|`path`|`string`|The path where the file will be saved.|
|`valueKey`|`string`|The key from `obj` that will be overwritten on the file.|


