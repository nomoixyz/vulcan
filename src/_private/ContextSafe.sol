// SPDX-License-Identifier: MIT
pragma solidity >=0.8.13 <0.9.0;

import {vulcan} from "./Vulcan.sol";
import {accountsUnsafe as accounts} from "./AccountsUnsafe.sol";
import {strings} from "./Strings.sol";
import {println} from "../_utils/println.sol";
import {formatError} from "../_utils/formatError.sol";

library ctxSafe {
    function broadcast() internal {
        vulcan.hevm.broadcast();
    }

    function broadcast(address from) internal {
        vulcan.hevm.broadcast(from);
    }

    function broadcast(uint256 privKey) internal {
        vulcan.hevm.broadcast(privKey);
    }

    function startBroadcast() internal {
        vulcan.hevm.startBroadcast();
    }

    function startBroadcast(address from) internal {
        vulcan.hevm.startBroadcast(from);
    }

    function startBroadcast(uint256 privKey) internal {
        vulcan.hevm.startBroadcast(privKey);
    }

    function stopBroadcast() internal {
        vulcan.hevm.stopBroadcast();
    }

    function assume(bool condition) internal pure {
        vulcan.hevm.assume(condition);
    }

    function pauseGasMetering() internal {
        vulcan.hevm.pauseGasMetering();
    }

    function resumeGasMetering() internal {
        vulcan.hevm.resumeGasMetering();
    }

    function startGasReport(string memory name) internal {
        if (bytes(name).length > 32) {
            revert(_formatError("startGasReport", "Gas report name can't have more than 32 characters"));
        }

        bytes32 b32Name = bytes32(bytes(name));
        bytes32 slot = keccak256(bytes("vulcan.ctx.gasReport.name"));
        accounts.setStorage(address(vulcan.hevm), slot, b32Name);
        bytes32 valueSlot = keccak256(abi.encodePacked("vulcan.ctx.gasReport", b32Name));
        accounts.setStorage(address(vulcan.hevm), valueSlot, bytes32(gasleft()));
    }

    function endGasReport() internal view {
        uint256 gas = gasleft();
        bytes32 slot = keccak256(bytes("vulcan.ctx.gasReport.name"));
        bytes32 b32Name = accounts.readStorage(address(vulcan.hevm), slot);
        bytes32 valueSlot = keccak256(abi.encodePacked("vulcan.ctx.gasReport", b32Name));
        uint256 prevGas = uint256(accounts.readStorage(address(vulcan.hevm), valueSlot));
        if (gas > prevGas) {
            revert(_formatError("endGasReport", "Gas used can't have a negative value"));
        }
        println(string.concat("gas(", string(abi.encodePacked(b32Name)), "):", strings.toString(prevGas - gas)));
    }

    function _formatError(string memory func, string memory message) private pure returns (string memory) {
        return formatError("ctx", func, message);
    }
}

