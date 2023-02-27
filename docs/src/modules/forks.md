# Forks

Forking functionality.

```Solidity
import { Test, forks, Fork } from "vulcan/test.sol";

contract TestMyContract is Test {
    function testMyContract() external {
        Fork fork = forks.create("mainnet"); // Alternatively an endpoint can be passed directly.
    }
}
```
