# Console

Print to the console. Uses `forge-std/console2.sol`.

```solidity
import { Test, console } from "vulcan/test.sol";

contract TestMyContract is Test {
    function testMyContract() external {
        // Same API as forge-std's console2
        console.log("Hello World");
        console.log("Some value: ", uint256(1337));
    }
}
```
