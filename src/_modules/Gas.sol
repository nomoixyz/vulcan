// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "./Vulcan.sol";
import "./Accounts.sol";

library gas {
    bytes32 constant GAS_MEASUREMENTS_MAGIC = keccak256("vulcan.gas.measurements.magic");

    function record(string memory name) internal {
        bytes32 startSlot = keccak256(abi.encode(GAS_MEASUREMENTS_MAGIC, name, "start"));
        accounts.setStorage(address(vulcan.hevm), startSlot, bytes32(gasleft()));
    }

    function stopRecord(string memory name) internal returns (uint256) {
        uint256 endGas = gasleft();

        bytes32 startSlot = keccak256(abi.encode(GAS_MEASUREMENTS_MAGIC, name, "start"));
        uint256 startGas = uint256(accounts.readStorage(address(vulcan.hevm), startSlot));

        if (endGas > startGas) {
            revert("gas.stopRecord: Gas used can't have a negative value");
        }

        bytes32 endSlot = keccak256(abi.encode(GAS_MEASUREMENTS_MAGIC, name, "end"));
        accounts.setStorage(address(vulcan.hevm), endSlot, bytes32(endGas));

        return startGas - endGas;
    }

    function getRecord(string memory name) internal view returns (uint256, uint256) {
        bytes32 startSlot = keccak256(abi.encode(GAS_MEASUREMENTS_MAGIC, name, "start"));
        uint256 startGas = uint256(accounts.readStorage(address(vulcan.hevm), startSlot));

        bytes32 endSlot = keccak256(abi.encode(GAS_MEASUREMENTS_MAGIC, name, "end"));
        uint256 endGas = uint256(accounts.readStorage(address(vulcan.hevm), endSlot));

        return (startGas, endGas);
    }

    function used(string memory name) internal view returns (uint256) {
        (uint256 startGas, uint256 endGas) = getRecord(name);

        return startGas - endGas;
    }
}

