// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "./VmLib.sol";
import "./ConsoleLib.sol";
import "./TestLib.sol";

// @dev Main entry point to Vulcan tests
contract Test {
    using TestLib for _T;
    using VmLib for _T;
    using VmLib for address;

    bool public IS_TEST = true;

    bool first = false;

    constructor() {
        vm.setUnderlying(VmLib.DEFAULT_VM);
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
        return vm.failed();
    } 
}
