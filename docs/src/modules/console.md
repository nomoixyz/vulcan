# Console

Print to the console.

```Solidity
import { Test, console } from "vulcan/test.sol";

contract TestMyContract is Test {
    function testMyContract() external {
        // Same API as forge-std's console2
        console.log("Hello World");
    }
}
```
