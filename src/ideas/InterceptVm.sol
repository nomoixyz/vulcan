pragma solidity ^0.8.13;

import { Test, Vm, expect, _T } from  "../Sest.sol";

// Intercept calls to the VM
contract InterceptVm {
    Vm internal immutable vm;
    constructor(Vm _vm) {
        vm = _vm;
    }

    // Intercept the warp function
    function warp(uint256 timestamp) external {
        vm.warp(timestamp);

        // Do something...
    }

    fallback() external payable {
        _fallback();
    }

    receive() external payable {
        _fallback();
    }

    function _fallback() internal {
        Vm _vm = vm;
        assembly {
            calldatacopy(0, 0, calldatasize())

            let result := call(gas(), _vm, callvalue(), 0, calldatasize(), 0, 0)

            returndatacopy(0, 0, returndatasize())

            switch result
            case 0 {
                revert(0, returndatasize())
            }
            default {
                return(0, returndatasize())
            }
        }
    }
}
