// SPDX-License-Identifier: MIT
pragma solidity >=0.8.13 <0.9.0;

import {fmt} from "./Fmt.sol";

function format(string memory template, bytes memory args) pure returns (string memory) {
    return fmt.format(template, args);
}
