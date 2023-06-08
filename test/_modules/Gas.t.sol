// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import {Test, expect, gas} from "../../src/test.sol";

contract GasTest is Test {
    function testItMeasures() public {
        string memory name = "test";

        gas.record(name);
        keccak256(bytes(name));
        uint256 measurementValue = gas.stopRecord(name);

        expect(measurementValue).toBeGreaterThan(0);
        expect(measurementValue).toEqual(gas.used(name));
    }
}
