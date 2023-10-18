// SPDX-License-Identifier: MIT
pragma solidity >=0.8.13 <0.9.0;

import {Test} from "src/test.sol";
import {expect} from "src/test/Expect.sol";
import {semver, Semver} from "src/_internal/Semver.sol";

contract SemverTest is Test {
    function testCreate() external {
        Semver memory version;

        version = semver.create(1, 2, 3);
        expect(version.major).toEqual(1);
        expect(version.minor).toEqual(2);
        expect(version.patch).toEqual(3);

        version = semver.create(1, 2);
        expect(version.major).toEqual(1);
        expect(version.minor).toEqual(2);
        expect(version.patch).toEqual(0);

        version = semver.create(1);
        expect(version.major).toEqual(1);
        expect(version.minor).toEqual(0);
        expect(version.patch).toEqual(0);
    }

    function testParse() external {
        Semver memory version;

        version = semver.parse("v0.6.9");
        expect(version.major).toEqual(0);
        expect(version.minor).toEqual(6);
        expect(version.patch).toEqual(9);

        version = semver.parse("0.6.9");
        expect(version.major).toEqual(0);
        expect(version.minor).toEqual(6);
        expect(version.patch).toEqual(9);
    }

    function testToString() external {
        expect(semver.create(1, 2, 3).toString()).toEqual("1.2.3");
    }

    function testEqual() external {
        expect(semver.create(1, 2, 3).equals(semver.create(1, 2, 3))).toBeTrue();

        expect(semver.create(1, 2, 3).equals(semver.create(1, 2, 4))).toBeFalse();
    }

    function testGreaterThan() external {
        expect(semver.create(1, 2, 4).greaterThan(semver.create(1, 2, 3))).toBeTrue();
        expect(semver.create(2, 2, 3).greaterThan(semver.create(1, 2, 3))).toBeTrue();
        expect(semver.create(1, 3, 3).greaterThan(semver.create(1, 2, 3))).toBeTrue();
        expect(semver.create(2, 3, 4).greaterThan(semver.create(1, 2, 3))).toBeTrue();

        expect(semver.create(1, 2, 2).greaterThan(semver.create(1, 2, 3))).toBeFalse();
        expect(semver.create(1, 1, 3).greaterThan(semver.create(1, 2, 3))).toBeFalse();
        expect(semver.create(0, 2, 3).greaterThan(semver.create(1, 2, 3))).toBeFalse();
        expect(semver.create(0, 1, 2).greaterThan(semver.create(1, 2, 3))).toBeFalse();
        expect(semver.create(1, 2, 3).greaterThan(semver.create(1, 2, 3))).toBeFalse();
    }

    function testGreaterThanOrEqual() external {
        expect(semver.create(1, 2, 3).greaterThanOrEqual(semver.create(1, 2, 3))).toBeTrue();
        expect(semver.create(1, 2, 4).greaterThanOrEqual(semver.create(1, 2, 3))).toBeTrue();
        expect(semver.create(2, 2, 3).greaterThanOrEqual(semver.create(1, 2, 3))).toBeTrue();
        expect(semver.create(1, 3, 3).greaterThanOrEqual(semver.create(1, 2, 3))).toBeTrue();
        expect(semver.create(2, 3, 4).greaterThanOrEqual(semver.create(1, 2, 3))).toBeTrue();

        expect(semver.create(1, 2, 2).greaterThanOrEqual(semver.create(1, 2, 3))).toBeFalse();
        expect(semver.create(1, 1, 3).greaterThanOrEqual(semver.create(1, 2, 3))).toBeFalse();
        expect(semver.create(0, 2, 3).greaterThanOrEqual(semver.create(1, 2, 3))).toBeFalse();
        expect(semver.create(0, 1, 2).greaterThanOrEqual(semver.create(1, 2, 3))).toBeFalse();
    }

    function testLessThan() external {
        expect(semver.create(1, 2, 2).lessThan(semver.create(1, 2, 3))).toBeTrue();
        expect(semver.create(1, 1, 3).lessThan(semver.create(1, 2, 3))).toBeTrue();
        expect(semver.create(0, 2, 3).lessThan(semver.create(1, 2, 3))).toBeTrue();
        expect(semver.create(0, 1, 2).lessThan(semver.create(1, 2, 3))).toBeTrue();

        expect(semver.create(1, 2, 4).lessThan(semver.create(1, 2, 3))).toBeFalse();
        expect(semver.create(2, 2, 3).lessThan(semver.create(1, 2, 3))).toBeFalse();
        expect(semver.create(1, 3, 3).lessThan(semver.create(1, 2, 3))).toBeFalse();
        expect(semver.create(2, 3, 4).lessThan(semver.create(1, 2, 3))).toBeFalse();
        expect(semver.create(1, 2, 3).lessThan(semver.create(1, 2, 3))).toBeFalse();
    }

    function testLessThanOrEqual() external {
        expect(semver.create(1, 2, 3).lessThanOrEqual(semver.create(1, 2, 3))).toBeTrue();
        expect(semver.create(1, 2, 2).lessThanOrEqual(semver.create(1, 2, 3))).toBeTrue();
        expect(semver.create(1, 1, 3).lessThanOrEqual(semver.create(1, 2, 3))).toBeTrue();
        expect(semver.create(0, 2, 3).lessThanOrEqual(semver.create(1, 2, 3))).toBeTrue();
        expect(semver.create(0, 1, 2).lessThanOrEqual(semver.create(1, 2, 3))).toBeTrue();

        expect(semver.create(1, 2, 4).lessThanOrEqual(semver.create(1, 2, 3))).toBeFalse();
        expect(semver.create(2, 2, 3).lessThanOrEqual(semver.create(1, 2, 3))).toBeFalse();
        expect(semver.create(1, 3, 3).lessThanOrEqual(semver.create(1, 2, 3))).toBeFalse();
        expect(semver.create(2, 3, 4).lessThanOrEqual(semver.create(1, 2, 3))).toBeFalse();
    }
}
