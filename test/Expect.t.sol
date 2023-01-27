pragma solidity ^0.8.13;

import { Test, expect, _T, vm, console, TestLib } from  "../src/Sest.sol";
import {Sender} from "./mocks/Sender.sol";

contract ExpectTest is Test {
    using TestLib for _T;

    modifier shouldFail() {
        bool pre = vm.failed();
        _;
        bool post = vm.failed();

        if (pre) {
            return;
        }

        if (!post) {
            revert("Didn't fail");
        }

        vm.clearFailure();
    }

    function testUintToEqualPasses(uint256 a) external {
        expect(a).toEqual(a);
    }

    function testUintToEqualFails(uint256 a, uint256 b) external shouldFail {
        vm.assume(a != b);
        expect(a).toEqual(b);
    }

    function testUintNotToEqualPasses(uint256 a, uint256 b) external {
        vm.assume(a != b);
        expect(a).not.toEqual(b);
    }

    function testUintNotToEqualFails(uint256 a) external shouldFail {
        expect(a).not.toEqual(a);
    }

    function testUintToBeCloseToPasses(uint256 a, uint256 b, uint256 delta) external {
        vm.assume((a < b ? b - a : a - b) <= delta);
        expect(a).toBeCloseTo(b, delta);
    }

    function testUintToBeCloseToFails(uint256 a, uint256 b, uint256 delta) external shouldFail {
        vm.assume((a < b ? b - a : a - b) > delta);
        expect(a).toBeCloseTo(b, delta);
    }

    function testUintToBeLessThanPasses(uint256 a, uint256 b) external {
        vm.assume(a < b);
        expect(a).toBeLessThan(b);
    }

    function testUintToBeLessThanOrEqualPasses(uint256 a, uint256 b) external {
        vm.assume(a <= b);
        expect(a).toBeLessThanOrEqual(b);
        expect(a).toBeLessThanOrEqual(a);
    }

    function testUintToBeGreaterThanPasses(uint256 a, uint256 b) external {
        vm.assume(a > b);
        expect(a).toBeGreaterThan(b);
    }

    function testUintToBeGreaterThanOrEqualPasses(uint256 a, uint256 b) external {
        vm.assume(a >= b);
        expect(a).toBeGreaterThanOrEqual(b);
        expect(a).toBeGreaterThanOrEqual(a);
    }


    function testIntToEqualPasses(int256 a) external {
        expect(a).toEqual(a);
    }

    function testIntToEqualFails(int256 a, int256 b) external shouldFail {
        vm.assume(a != b);
        expect(a).toEqual(b);
    }

    function testIntNotToEqualPasses(int256 a, int256 b) external {
        vm.assume(a != b);
        expect(a).not.toEqual(b);
    }

    function testIntNotToEqualFails(int256 a) external shouldFail {
        expect(a).not.toEqual(a);
    }

    function testIntToBeCloseToPasses(int256 a, int256 b, uint256 delta) external {
        // vm.assume( <= delta);
        // expect(a).toBeCloseTo(b, delta);
    }

    function testIntToBeCloseToFails(int256 a, uint256 delta, bool add) external shouldFail {

        // TODO: better fuzzing

    }

    function testIntToBeLessThanPasses(int256 a, int256 b) external {
        vm.assume(a < b);
        expect(a).toBeLessThan(b);
    }

    function testIntToBeLessThanFails(int256 a, int256 b) external shouldFail {
        vm.assume(a >= b);
        expect(a).toBeLessThan(b);
    }

    function testIntToBeLessThanOrEqualPasses(int256 a, int256 b) external {
        vm.assume(a <= b);
        expect(a).toBeLessThanOrEqual(b);
        expect(a).toBeLessThanOrEqual(a);
    }

    function testIntToBeLessThanOrEqualFails(int256 a, int256 b) external shouldFail {
        vm.assume(a > b);
        expect(a).toBeLessThanOrEqual(b);
    }

    function testIntToBeGreaterThanPasses(int256 a, int256 b) external {
        vm.assume(a > b);
        expect(a).toBeGreaterThan(b);
    }

    function testIntToBeGreaterThanFails(int256 a, int256 b) external shouldFail {
        vm.assume(a <= b);
        expect(a).toBeGreaterThan(b);
    }

    function testIntToBeGreaterThanOrEqualPasses(int256 a, int256 b) external {
        vm.assume(a >= b);
        expect(a).toBeGreaterThanOrEqual(b);
        expect(a).toBeGreaterThanOrEqual(a);
    }

    function testIntToBeGreaterThanOrEqualFails(int256 a, int256 b) external shouldFail {
        vm.assume(a < b);
        expect(a).toBeGreaterThanOrEqual(b);
    }

    function testBoolToEqualPasses(bool a) external {
        if (a) {
            expect(a).toEqual(true);
            expect(a).toBeTrue();
        } else {
            expect(a).toEqual(false);
            expect(a).toBeFalse();
        }
    }
}