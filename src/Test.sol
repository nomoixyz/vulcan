// SPDX-License-Identifier: MIT
pragma solidity >=0.8.13 <0.9.0;

import {vulcan} from "./Vulcan.sol";
import "./Console.sol";

// @dev Main entry point to Vulcan tests
contract Test {
    using vulcan for *;

    bool public IS_TEST = true;

    constructor() {
        vulcan.init();
    }

    function failed() public view returns (bool) {
        return vulcan.failed();
    }
}
