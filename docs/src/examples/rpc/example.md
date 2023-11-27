## Examples
### Calling an RPC

Calling an rpc using the `eth_chainId` method

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, expect} from "vulcan/test.sol";
import {rpc} from "vulcan/test/Rpc.sol";
import {Fork, forks} from "vulcan/test/Forks.sol";

contract RpcTest is Test {
    function testNetVersion() external {
        forks.create("https://rpc.mevblocker.io/fast").select();

        string memory method = "eth_chainId";
        string memory params = "[]";

        bytes memory data = rpc.call(method, params);

        uint8 chainId;

        assembly {
            chainId := mload(add(data, 0x01))
        }

        expect(chainId).toEqual(block.chainid);
    }
}

```

