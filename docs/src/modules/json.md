# Json

Manipulate JSON data.

```Solidity
import { Test, JsonObject, json } from "vulcan/test.sol";

contract TestMyContract is Test {
    function testMyContract() external {
        JsonObject memory obj = json.create();
        obj.serialize("foo", true);
        expect(obj.serialized).toEqual('{"foo":true}');
    }
}
```
