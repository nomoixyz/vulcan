pragma solidity ^0.8.13;

import { fmt } from  "../src/ideas/Format.sol";
import { Test, expect, _T, vm, console, TestLib } from  "../src/Vulcan.sol";

contract Format is Test {
    function testFormat() external view {
        fmt("").arg("hello").arg(123).arg("hello").arg(123).log();
    }

}