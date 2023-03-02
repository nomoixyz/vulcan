# Modules

The VM functionality and additional utilities are organized in modules, which are imported either through `vulcan/test.sol` or `vulcan/script.sol`.

Each module can contain "safe" functions which are available in the imported module for both tests and scripts, and "unsafe" functions that are only meant to be used in tests. Unsafe functions can also be used in a script if needed (when connecting to an appropriate node) by importing the version of the module suffixed with `Unsafe`.

```solidity
/**
 * The accounts module will contain all safe and unsafe functions when
 * imported from `vulcan/test.sol`
 */
import { Test, accounts } from "vulcan/test.sol";

/**
 * The accounts module will only contain safe functions when imported
 * from `vulcan/script.sol`, and unsafe functions can be accessed by
 * importing the `unsafe` version of the module.
 */ 
import { Test, accounts, accountsUnsafe } from "vulcan/script.sol";
```
