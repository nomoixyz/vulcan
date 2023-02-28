# Accounts

Account operations (balances, impersonation, etc.)

```solidity
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

## `readStorage(who, slot)`

## `sign(privKey, digest)`

## `derive(privKey)`

## `deriveKey(mnemonicOrPath, index)`

## `deriveKey(mnemonicOrPath, derivationPath, index)`

## `rememberKey(privKey)`

## `getNonce(who)`

## `recordStorage()`

## `getStorageAccesses(who)`

## `label(who, lbl)`

## `create(name, lbl?)`

## `readStorage(who, slot)`

## `setStorage(who, slot, value)`

## `setNonce(who, nonce)`

## `impersonateOnce(who, origin?)`

## `impersonate(who, origin?)`

## `stopImpersonate()`

## `setBalance(who, balance)`

## `setCode(who, code)`
