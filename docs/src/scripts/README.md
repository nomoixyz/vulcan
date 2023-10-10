# Scripts

Most of Vulcan's modules used for testing can be used in `Scripts` but not all the functions are
recommended to be used in this context. A few examples are:
- [`Accounts`](../modules/accounts.md): Only the functions in the [`accountsSafe`](https://github.com/nomoixyz/vulcan/blob/6b182b6351714592d010ef5bfefc5780710d84e6/src/_modules/Accounts.sol#L10) library should be used. If there is a need to use `unsafe` functions use the `accountsUnsafe` module exported in `vulcan/script.sol`.
- [`Context`](../modules/context.md): Only the functions in the [`ctxSafe`](https://github.com/nomoixyz/vulcan/blob/6b182b6351714592d010ef5bfefc5780710d84e6/src/_modules/Context.sol#L35) library should be used. If there is a need to use `unsafe` functions use the `ctxUnsafe` module exported in `vulcan/script.sol`;
- [`Forks`](../modules/forks.md): None of the functions in this module should be used. If there is a
  need to use `unsafe` functions use the `forksUnsafe` module exported in `vulcan/script.sol`.

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {MyContract} from "src/MyContract.sol";
import {Script, ctx, println, request} from "vulcan/script.sol";

contract DeployScript is Script {
    function run() public {
        ctx.startBroadcast();

        new MyContract();

        ctx.stopBroadcast();

        println("Notifying API");

        request
            .create()
            .post("https://my-api.io/webhook/notify/deployment")
            .send()
            .expect("Failed to trigger webhook");
    }
}
```
