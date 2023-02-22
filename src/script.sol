// SPDX-License-Identifier: MIT
pragma solidity >=0.8.13 <0.9.0;

import {vulcan} from "./Vulcan.sol";
import {accountsSafe as accounts, accounts as accountsUnsafe} from "./Accounts.sol";
import {commands} from "./Command.sol";
import {ctxSafe as ctx, ctx as ctxUnsafe} from "./Context.sol";
import {env} from "./Env.sol";
import {events} from "./Events.sol";
import {forks as forksUnsafe} from "./Fork.sol";
import {fs} from "./Fs.sol";
import {json} from "./Json.sol";
import {strings} from "./Strings.sol";
import {watchers as watchersUnsafe} from "./Watcher.sol";
import "./Console.sol";

contract Script {
    bool public IS_SCRIPT = true;
}
