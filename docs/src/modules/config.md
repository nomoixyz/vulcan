# Config

Foundry project configuration stuff.

```solidity
import { Test, config, Rpc } from "vulcan/test.sol";

contract TestMyContract is Test {
    function testMyContract() external {
        // Obtain the RPC URL from one of the keys configured on `foundry.toml`
        string memory rpcUrl = config.rpcUrl("mainnet");

        // Obtain all the RPCs as [name, url][]
        string[2][] memory rpcs = config.rpcUrls();

        // Obtain all the RPCs as an array of `Rpc`s 
        // Rpc { name, url }
        Rpc[] memory rpcsAsStruct = config.rpcUrlStructs();
    }
}
```
[**Config API reference**](../reference/modules/config.md)
