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

## `set(name, value)`

## `getUint(name, default?)`

## `getInt(name, default?)`

## `getBool(name, default?)`

## `getAddress(name, default?)`

## `getBytes32(name, default?)`

## `getString(name, default?)`

## `getBytes(name, default?)`

## `getBoolArray(name, delim, default?)`

## `getUintArray(name, delim, default?)`

## `getIntArray(name, delim, default?)`

## `getAddressArray(name, delim, default?)`

## `getBytes32Array(name, delim, default?)`

## `getStringArray(name, delim, default?)`

## `getBytesArray(name, delim, default?)`
