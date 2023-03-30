// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Test, strings, expect} from "src/test.sol";
import {logger, Logger} from "src/Logger.sol";

contract LoggerTest is Test {
    using strings for *;

    function testItCanCreateALogger() external {
        string memory format = "{} {} {} {} {} {} {}";

        Logger memory l = logger
            .printf(format)
            .with(true)
            .with(uint256(1))
            .with(address(1))
            .with(bytes32(uint256(1)))
            .with(int256(-1));

        expect(l.format).toEqual(format);
        expect(l.values[0]).toEqual(true.toString());
        expect(l.values[1]).toEqual(uint256(1).toString());
        expect(l.values[2]).toEqual(address(1).toString());
        expect(l.values[3]).toEqual(bytes32(uint256(1)).toString());
        expect(l.values[4]).toEqual(int256(-1).toString());
    }
}
