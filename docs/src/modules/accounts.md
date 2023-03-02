# Accounts

Utilities to operate over accounts (balances, impersonation, etc.)

```solidity
import { Test, accounts } from "vulcan/test.sol";

contract TestMyContract is Test {
    using accounts for *;

    function testMyContract() external {
        // Create an address from a string, sets the ETH balance and impersonate calls
        address alice = accounts.create("Alice").setBalance(123).impersonate();

        // Stop impersonating `alice`
        accounts.stopImpersonate();

        DAI dai = DAI(0x6B175474E89094C44Da98b954EedeAC495271d0F);

        // Create an address from a string, mint tokens to the address and impersonate
        // the next call
        address bob = accounts.create("Bob").mintToken(address(dai), 1337).impersonateOnce();

        // There is no need to `create` an address
        address charlie = address(0x01).setNonce(10).setBalance(1e18);

        DAI daiClone = DAI(address(0x02));
        // Inject code into an address
        address(daiClone).setCode(address(dai).code);

        // The storage of an address can be manipulated
        address(daiClone).setStorage(bytes32(1), bytes32(10e18));
        // The storage of an address can be read
        bytes32 daiSlot1 = address(daiClone).readStorage(bytes32(1));
    }
}
```
[**Accounts API reference**](../reference/modules/accounts.md)
