## Examples
### Obtain a specific RPC URL

Read a specific RPC URL from the foundry configuration

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, expect, config} from "vulcan/test.sol";

contract ConfigExample is Test {
    function test() external {
        string memory key = "mainnet";

        expect(config.rpcUrl(key)).toEqual("https://mainnet.rpc.io");
    }
}

```

### Obtain all the RPC URLs

Read all the RPC URLs from the foundry configuration

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, expect, config} from "vulcan/test.sol";

contract ConfigExample is Test {
    function test() external {
        string[2][] memory rpcs = config.rpcUrls();

        expect(rpcs.length).toEqual(2);
        expect(rpcs[0][0]).toEqual("arbitrum");
        expect(rpcs[0][1]).toEqual("https://arbitrum.rpc.io");
        expect(rpcs[1][0]).toEqual("mainnet");
        expect(rpcs[1][1]).toEqual("https://mainnet.rpc.io");
    }
}

```

### Obtain all the RPC URLs using structs

Read all the RPC URL from the foundry configuration as structs

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, expect, config, RpcConfig} from "vulcan/test.sol";

contract ConfigExample is Test {
    function test() external {
        RpcConfig[] memory rpcs = config.rpcUrlStructs();

        expect(rpcs.length).toEqual(2);
        expect(rpcs[0].name).toEqual("arbitrum");
        expect(rpcs[0].url).toEqual("https://arbitrum.rpc.io");
        expect(rpcs[1].name).toEqual("mainnet");
        expect(rpcs[1].url).toEqual("https://mainnet.rpc.io");
    }
}

```

