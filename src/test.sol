// SPDX-License-Identifier: MIT
pragma solidity >=0.8.13 <0.9.0;

import {console} from "./_modules/Console.sol";
import {vulcan, Log} from "./_modules/Vulcan.sol";
import {any} from "./_modules/Any.sol";
import {accounts} from "./_modules/Accounts.sol";
import {commands, Command, CommandResult, CommandOutput} from "./_modules/Commands.sol";
import {ctx} from "./_modules/Context.sol";
import {env} from "./_modules/Env.sol";
import {events} from "./_modules/Events.sol";
import {expect} from "./_modules/Expect.sol";
import {forks, Fork} from "./_modules/Forks.sol";
import {fs, FsMetadata} from "./_modules/Fs.sol";
import {gas} from "./_modules/Gas.sol";
import {huff, Huffc} from "./_modules/Huff.sol";
import {InvariantsBase, invariants} from "./_modules/Invariants.sol";
import {json, JsonObject, Ok} from "./_modules/Json.sol";
import {strings} from "./_modules/Strings.sol";
import {watchers, Watcher} from "./_modules/Watchers.sol";
import {config, Rpc} from "./_modules/Config.sol";
import {fmt} from "./_modules/Fmt.sol";
import {fe, Fe} from "./_modules/Fe.sol";
import {format} from "./_utils/format.sol";
import {println} from "./_utils/println.sol";
import {bound} from "./_utils/bound.sol";
import {formatError} from "./_utils/formatError.sol";
import {removeSelector} from "./_utils/removeSelector.sol";
import {Ok} from "./_modules/Result.sol";

// @dev Main entry point to Vulcan tests
contract Test is InvariantsBase {
    bool public IS_TEST = true;

    constructor() {
        vulcan.init();
    }

    function failed() public view returns (bool) {
        return vulcan.failed();
    }

    modifier shouldFail() {
        bool pre = vulcan.failed();
        _;
        bool post = vulcan.failed();

        if (pre) {
            return;
        }

        if (!post) {
            revert(formatError("test", "shouldFail()", "Test expected to fail"));
        }

        vulcan.clearFailure();
    }
}
