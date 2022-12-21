// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "./TestLib.sol";

// @dev Main entry point to sest tests
contract Test {
    using TestLib for *;
    _T internal test = _T(0).setVm(TestLib.DEFAULT_VM);
}
