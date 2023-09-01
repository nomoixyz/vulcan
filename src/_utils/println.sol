// SPDX-License-Identifier: MIT
pragma solidity >=0.8.13 <0.9.0;

import {fmt} from "../_modules/Fmt.sol";
import {rawConsoleLog} from "./rawConsole.sol";

function println(string memory template, bytes memory args) view {
    rawConsoleLog(fmt.format(template, args));
}

function println(string memory arg) view {
    rawConsoleLog(arg);
}
