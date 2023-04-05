// SPDX-License-Identifier: MIT
pragma solidity >=0.8.13 <0.9.0;

import {console} from "./_modules/Console.sol";
import {vulcan} from "./_modules/Vulcan.sol";
import {accountsSafe as accounts, accounts as accountsUnsafe} from "./_modules/Accounts.sol";
import {commands} from "./_modules/Commands.sol";
import {ctxSafe as ctx, ctx as ctxUnsafe} from "./_modules/Context.sol";
import {env} from "./_modules/Env.sol";
import {events} from "./_modules/Events.sol";
import {forks as forksUnsafe} from "./_modules/Fork.sol";
import {fs} from "./_modules/Fs.sol";
import {json} from "./_modules/Json.sol";
import {strings} from "./_modules/Strings.sol";
import {watchers as watchersUnsafe} from "./_modules/Watcher.sol";
import {config, Rpc} from "./_modules/Config.sol";
import {fmt} from "./_modules/Fmt.sol";
import {format} from "./_utils/format.sol";
import {println} from "./_utils/println.sol";

contract Script {
    bool public IS_SCRIPT = true;
}
