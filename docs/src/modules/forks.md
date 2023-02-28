# Forks

Forking functionality.

```solidity
import { Test, forks, Fork } from "vulcan/test.sol";

contract TestMyContract is Test {
    function testMyContract() external {
        Fork fork = forks.create("mainnet"); // Alternatively an endpoint can be passed directly.
    }
}
```

## `create(endpoint)`

## `createAtBlock(endpoint, blockNumber)`

## `createBeforeTx(endpoint, txHash)`

## `select(fork)`

## `active()`

## `setBlockNumber(blockNumber)`

## `beforeTx(fork, txHash)`

## `persistBetweenForks(who1, who2?, who3?)`
## `persistBetweenForks(whos)`

## `stopPersist(who|whos)`

## `isPersistent(who)`

## `allowCheatcodes(who)`

## `executeTx(txHash)`

## `executeTx(fork, txHash)`
