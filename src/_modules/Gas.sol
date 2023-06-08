// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "./Vulcan.sol";
import "./Accounts.sol";

struct GasMeasurement {
    uint256 start;
    uint256 end;
}

library gas {
    bytes32 constant GAS_MEASUREMENTS_SLOT = keccak256("vulcan.gas.measurements");

    function measurements() internal pure returns (mapping(string => GasMeasurement) storage m) {
        bytes32 slot = GAS_MEASUREMENTS_SLOT;

        assembly {
            m.slot := slot
        }
    }

    function measurement(string memory name) internal view returns (GasMeasurement memory) {
        return measurements()[name];
    }

    function measure(string memory name) internal {
        measurements()[name] = GasMeasurement(gasleft(), uint256(0));
    }

    function endMeasure(string memory name) internal returns (uint256) {
        uint256 endGas = gasleft();

        uint256 startGas = measurement(name).start;

        if (endGas > startGas) {
            revert("gas.endMeasure: Gas used can't have a negative value");
        }

        measurements()[name].end = endGas;

        return startGas - endGas;
    }

    function value(GasMeasurement memory gasMeasurement) internal pure returns (uint256) {
        return gasMeasurement.start - gasMeasurement.end;
    }
}

using gas for GasMeasurement global;
