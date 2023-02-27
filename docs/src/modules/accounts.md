# Accounts

Account operations (balances, impersonation, etc.)

```Solidity
import { Test, accounts } from "vulcan/test.sol";

contract TestMyContract is Test {
    using accounts for *;

    function testMyContract() external {
        address alice = accounts.create("Alice").setBalance(123).impersonate();

        // ...

        address bob = accounts.create("Bob").setBalance(456).impersonate();
    }
}
```
