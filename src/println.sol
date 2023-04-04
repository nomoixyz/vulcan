// SPDX-License-Identifier: MIT
pragma solidity >=0.8.13 <0.9.0;

import {console} from "./Console.sol";
import {fmt} from "./Fmt.sol";

function println(string memory template, bytes memory args) view {
    console.log(fmt.format(template, args));
}

function println(string memory arg) view {
    console.log(arg);
}
