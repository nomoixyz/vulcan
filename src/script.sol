// SPDX-License-Identifier: MIT
pragma solidity >=0.8.13 <0.9.0;

import "./_imports.sol";

import {accountsSafe as accounts} from "./_private/AccountsSafe.sol";
import {ctxSafe as ctx} from "./_private/ContextSafe.sol";

contract Script {
    bool public IS_SCRIPT = true;
}
