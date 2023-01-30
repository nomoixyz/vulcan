// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "./Vulcan.sol";
import "./Console.sol";

// @dev Main entry point to sest tests
contract Script {
    using vulcan for *;

    VulcanVmCommon vm;

    constructor() {
        vm.setVm(vulcan.HEVM);
    }
}
