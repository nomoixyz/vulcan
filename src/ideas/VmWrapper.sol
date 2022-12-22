pragma solidity ^0.8.13;

import { Vm } from  "../Sest.sol";

// Intercept calls to the VM
// This could be useful to add functionality to the VM but also for debugging (adding logs before/after calls, etc)
contract VmWrapper {
    Vm internal immutable vm;

    constructor(Vm _vm) {
        vm = _vm;
    }

    fallback() external payable {
        _fallback();
    }

    receive() external payable {
        _fallback();
    }

    function _fallback() private {
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
