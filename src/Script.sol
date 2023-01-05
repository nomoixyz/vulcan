// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "./VmLib.sol";
import "./ConsoleLib.sol";

// @dev Main entry point to sest tests
contract Script {
    using VmLib for _T;
    using VmLib for address;

    constructor() {
        vm.setUnderlying(VmLib.DEFAULT_VM);
    }
}
