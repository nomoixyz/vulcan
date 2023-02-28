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

## `parseObject(jsonStr, key?)`

## `parseObject(jsonObj, key?)`

## `parseUint(jsonStr, key)`

## `parseUintArray(jsonStr, key)`

## `parseInt(jsonStr, key)`

## `parseIntArray(jsonStr, key)`

## `parseBool(jsonStr, key)`

## `parseBoolArray(jsonStr, key)`

## `parseAddress(jsonStr, key)`

## `parseAddressArray(jsonStr, key)`

## `parseString(jsonStr, key)`

## `parseStringArray(jsonStr, key)`

## `parseBytes(jsonStr, key)`

## `parseBytesArray(jsonStr, key)`

## `parseBytes32(jsonStr, key)`

## `parseBytes32Array(jsonStr, key)`

## `create()`

## `serialize(jsonObj, key, value)`

## `write(jsonObj, path, valueKey?)`
