pragma solidity ^0.8.13;

import { Test, Vm, expect, _T } from  "../Vulcan.sol";
import "./VmWrapper.sol";

// Example wrapper that intercepts calls to the VM
contract InterceptWarp is VmWrapper {

    constructor(Vm _vm) VmWrapper(_vm) { }

    // Intercept the warp function
    function warp(uint256 timestamp) external {
        vm.warp(timestamp);

        // Do something...
    }
}
