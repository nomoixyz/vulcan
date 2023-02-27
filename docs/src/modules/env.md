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
