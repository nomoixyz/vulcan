# Json

Manipulate JSON data.

```solidity
import { Test, JsonObject, json } from "vulcan/test.sol";

contract TestMyContract is Test {
    function testMyContract() external {
        // Create a JsonObject struct
        JsonObject memory obj = json.create();

        // Serialize the property `foo` with a value of `true`
        obj.serialize("foo", true);

        // Obtain the serialized Json string
        expect(obj.serialized).toEqual('{"foo":true}');
    }
}
```
[**Json API reference**](../reference/modules/json.md)
