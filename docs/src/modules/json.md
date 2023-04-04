# Json

Manipulate JSON data.

```solidity
import { Test, JsonObject, json } from "vulcan/test.sol";

contract TestMyContract is Test {
    function testMyContract() external {
        // Create a JsonObject struct
        JsonObject memory obj = json.create();

        // Set the property `foo` with a value of `true`
        obj.set("foo", true);

        // Obtain the set Json string
        expect(obj.set).toEqual('{"foo":true}');

        // Nested Objects
        JsonObject memory nested = json.create();

        nested.set("bar", obj);

        expect(nested.set).toEqual('{"bar":{"foo":true}}');
    }
}
```
[**Json API reference**](../reference/modules/json.md)
