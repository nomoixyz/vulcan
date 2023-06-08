// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import {Test, expect, gas, GasMeasurement} from "../../src/test.sol";

contract GasTest is Test {
    function testItMeasures() public {
        string memory name = "test";

        gas.measure(name);
        keccak256(bytes(name));
        uint256 measurementValue = gas.endMeasure(name);

        expect(measurementValue).toBeGreaterThan(0);
        expect(measurementValue).toEqual(gas.measurement(name).value());
    }
}
