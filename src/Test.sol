// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "./Vulcan.sol";
import "./Console.sol";

// @dev Main entry point to Vulcan tests
contract Test {
    using vulcan for *;

    bool public IS_TEST = true;

    bool first = false;

    VulcanVmTest vm;

    constructor() {
        vm.setVm(vulcan.HEVM);
    }

    function setUp() external {
        if (!first) {
            first = true;
            before();
        }

        beforeEach();
    }

    function before() virtual internal {}

    function beforeEach() virtual internal {}

    function failed() public view returns (bool) {
        return vulcan.failed();
    } 
}
