// SPDX-License-Identifier: MIT
pragma solidity >=0.8.13 <0.9.0;

import {console} from "./_modules/Console.sol";
import {vulcan, Log} from "./_modules/Vulcan.sol";
import {any} from "./_modules/Any.sol";
import {accounts} from "./_modules/Accounts.sol";
import {commands, Command} from "./_modules/Commands.sol";
import {ctx} from "./_modules/Context.sol";
import {env} from "./_modules/Env.sol";
import {events} from "./_modules/Events.sol";
import {expect} from "./_modules/Expect.sol";
import {forks, Fork} from "./_modules/Fork.sol";
import {fs, FsMetadata} from "./_modules/Fs.sol";
import {huff, Huffc} from "./_modules/Huff.sol";
import {json, JsonObject} from "./_modules/Json.sol";
import {strings} from "./_modules/Strings.sol";
import {watchers, Watcher} from "./_modules/Watcher.sol";
import {config, Rpc} from "./_modules/Config.sol";
import {fmt} from "./_modules/Fmt.sol";
import {format} from "./format.sol";
import {println} from "./println.sol";

// @dev Main entry point to Vulcan tests
contract Test {
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
            revert("Didn't fail");
        }

        vulcan.clearFailure();
    }
}
