// SPDX-License-Identifier: MIT
pragma solidity >=0.8.13 <0.9.0;

// Common imports
import "./_imports.sol";

import {accountsSafe as accounts} from "./_private/Accounts.sol";
import {ctxSafe as ctx} from "./_private/Context.sol";

contract Script {
    bool public IS_SCRIPT = true;
}
