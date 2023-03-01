# Env

Set and read environmental variables.

```solidity
import { Test, env } from "vulcan/test.sol";

contract TestMyContract is Test {
    function testMyContract() external {
		// Sets the value of the environment variable `MY_VAR` to `Hello World`
        env.set("MY_VAR", string("Hello World"));

		// Reads the content of the `MY_VAR` environment variable
        string memory MY_VAR = env.getString("MY_VAR");
    }
}
```
