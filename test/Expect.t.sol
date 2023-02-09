pragma solidity >=0.8.13 <0.9.0;

import {any, Test, expect, events, console, vulcan} from "../src/lib.sol";
import {Sender} from "./mocks/Sender.sol";
import {watchers, Watcher} from "src/Watcher.sol";

contract CallTest {
    error CustomError(uint256 i);

    event Event(string indexed foo, uint256 bar);

    uint256 num = 69;

    function ok() external returns (uint256) {
        uint256 val = uint256(keccak256(abi.encodePacked(num)));

        num = val;

        return val;
    }

    function emitEvent(string memory foo, uint256 bar) external {
        emit Event(foo, bar);
    }

    function failWithRevert() external {
        revert();
    }

    function failWithStringRevert() external {
        revert("Error");
    }

    function failWithRequire() external {
        require(true == false);
    }

    function failWithRequireMessage() external {
        require(true == false, "Require message");
    }

    function failWithCustomError() external {
        revert CustomError(num);
    }
}

contract ExpectTest is Test {
    using vulcan for *;

    modifier shouldFail() {
        bool pre = vulcan.failed();
        _;
        bool post = vulcan.failed();

        if (pre) {
            return;
        }

        if (!post) {
            revert("Didn't fail");
        }

        vulcan.clearFailure();
    }

    function testUintToEqualPass(uint256 a) external {
        expect(a).toEqual(a);
    }

    function testUintToEqualFail(uint256 a, uint256 b) external shouldFail {
        vm.assume(a != b);
        expect(a).toEqual(b);
    }

    function testUintNotToEqualPass(uint256 a, uint256 b) external {
        vm.assume(a != b);
        expect(a).not.toEqual(b);
    }

    function testUintNotToEqualFail(uint256 a) external shouldFail {
        expect(a).not.toEqual(a);
    }

    function testUintToBeCloseToPass(uint256 a, uint256 b, uint256 delta) external {
        vm.assume((a < b ? b - a : a - b) <= delta);
        expect(a).toBeCloseTo(b, delta);
    }

    function testUintToBeCloseToFail(uint256 a, uint256 b, uint256 delta) external shouldFail {
        vm.assume((a < b ? b - a : a - b) > delta);
        expect(a).toBeCloseTo(b, delta);
    }

    function testUintToBeLessThanPass(uint256 a, uint256 b) external {
        vm.assume(a < b);
        expect(a).toBeLessThan(b);
    }

    function testUintToBeLessThanOrEqualPass(uint256 a, uint256 b) external {
        vm.assume(a <= b);
        expect(a).toBeLessThanOrEqual(b);
        expect(a).toBeLessThanOrEqual(a);
    }

    function testUintToBeGreaterThanPass(uint256 a, uint256 b) external {
        vm.assume(a > b);
        expect(a).toBeGreaterThan(b);
    }

    function testUintToBeGreaterThanOrEqualPass(uint256 a, uint256 b) external {
        vm.assume(a >= b);
        expect(a).toBeGreaterThanOrEqual(b);
        expect(a).toBeGreaterThanOrEqual(a);
    }

    function testIntToEqualPass(int256 a) external {
        expect(a).toEqual(a);
    }

    function testIntToEqualFail(int256 a, int256 b) external shouldFail {
        vm.assume(a != b);
        expect(a).toEqual(b);
    }

    function testIntNotToEqualPass(int256 a, int256 b) external {
        vm.assume(a != b);
        expect(a).not.toEqual(b);
    }

    function testIntNotToEqualFail(int256 a) external shouldFail {
        expect(a).not.toEqual(a);
    }

    function testIntToBeCloseToPass(int256 a, int256 b, uint256 delta) external {
        // TODO
    }

    function testIntToBeCloseToFail(int256 a, uint256 delta, bool add) external shouldFail {
        // TODO
    }

    function testIntToBeLessThanPass(int256 a, int256 b) external {
        vm.assume(a < b);
        expect(a).toBeLessThan(b);
    }

    function testIntToBeLessThanFail(int256 a, int256 b) external shouldFail {
        vm.assume(a >= b);
        expect(a).toBeLessThan(b);
    }

    function testIntToBeLessThanOrEqualPass(int256 a, int256 b) external {
        vm.assume(a <= b);
        expect(a).toBeLessThanOrEqual(b);
        expect(a).toBeLessThanOrEqual(a);
    }

    function testIntToBeLessThanOrEqualFail(int256 a, int256 b) external shouldFail {
        vm.assume(a > b);
        expect(a).toBeLessThanOrEqual(b);
    }

    function testIntToBeGreaterThanPass(int256 a, int256 b) external {
        vm.assume(a > b);
        expect(a).toBeGreaterThan(b);
    }

    function testIntToBeGreaterThanFail(int256 a, int256 b) external shouldFail {
        vm.assume(a <= b);
        expect(a).toBeGreaterThan(b);
    }

    function testIntToBeGreaterThanOrEqualPass(int256 a, int256 b) external {
        vm.assume(a >= b);
        expect(a).toBeGreaterThanOrEqual(b);
        expect(a).toBeGreaterThanOrEqual(a);
    }

    function testIntToBeGreaterThanOrEqualFail(int256 a, int256 b) external shouldFail {
        vm.assume(a < b);
        expect(a).toBeGreaterThanOrEqual(b);
    }

    function testBoolToEqualPass(bool a) external {
        if (a) {
            expect(a).toEqual(true);
            expect(a).toBeTrue();
        } else {
            expect(a).toEqual(false);
            expect(a).toBeFalse();
        }
    }

    /* BYTES32 */

    function testBytes32ToEqualPass(bytes32 a) external {
        expect(a).toEqual(a);
    }

    function testBytes32ToEqualFail(bytes32 a, bytes32 b) external shouldFail {
        vm.assume(a != b);
        expect(a).toEqual(b);
    }

    function testBytes32NotToEqualPass(bytes32 a, bytes32 b) external {
        vm.assume(a != b);
        expect(a).not.toEqual(b);
    }

    function testBytes32NotToEqualFail(bytes32 a) external shouldFail {
        expect(a).not.toEqual(a);
    }

    function testBytes32ToBeTheHashOfPass(bytes memory a) external {
        expect(keccak256(a)).toBeTheHashOf(a);
    }

    function testBytes32ToBeTheHashOfFail(bytes32 a, bytes memory b) external shouldFail {
        vm.assume(keccak256(b) != a);
        expect(a).toBeTheHashOf(b);
    }

    function testBytes32NotToBeTheHashOfPass(bytes32 a, bytes memory b) external {
        vm.assume(keccak256(b) != a);
        expect(a).not.toBeTheHashOf(b);
    }

    /* STRING */

    function testStringToEqualPass(string memory a) external {
        expect(a).toEqual(a);
    }

    function testStringToEqualFail(string memory a, string memory b) external shouldFail {
        vm.assume(keccak256(bytes(a)) != keccak256(bytes(b)));
        expect(a).toEqual(b);
    }

    function testStringNotToEqualPass(string memory a, string memory b) external {
        vm.assume(keccak256(bytes(a)) != keccak256(bytes(b)));
        expect(a).not.toEqual(b);
    }

    function testStringNotToEqualFail(string memory a) external shouldFail {
        expect(a).not.toEqual(a);
    }

    function testStringToContainPass(string memory a, string memory b, string memory c) external {
        expect(string.concat(a, b, c)).toContain(b);
    }

    // TODO: fuzzing?
    function testStringToContainFail() external shouldFail {
        expect(string("abc")).toContain("d");
    }

    function testStringToHaveLengthPass(string memory a) external {
        expect(a).toHaveLength(bytes(a).length);
    }

    function testStringToHaveLengthFail(string memory a, uint256 len) external shouldFail {
        vm.assume(len != bytes(a).length);
        expect(a).toHaveLength(len);
    }

    function testToHaveReverted() external {
        CallTest t = new CallTest();

        watchers.watch(address(t)).captureReverts();

        t.failWithRevert();
        t.failWithStringRevert();
        t.failWithRequire();
        t.failWithRequireMessage();
        t.failWithCustomError();

        expect(address(t).getCall(0)).toHaveReverted();
        expect(address(t).getCall(1)).toHaveReverted();
        expect(address(t).getCall(2)).toHaveReverted();
        expect(address(t).getCall(3)).toHaveReverted();
        expect(address(t).getCall(4)).toHaveReverted();
        expect(address(t).firstCall()).toHaveReverted();
        expect(address(t).lastCall()).toHaveReverted();
    }

    function testToHaveSucceeded() external {
        CallTest t = new CallTest();

        watchers.watch(address(t));

        uint256 result = t.ok();

        expect(address(t).getCall(0)).toHaveSucceeded();
        expect(address(t).firstCall()).toHaveSucceeded();
        expect(address(t).lastCall()).toHaveSucceeded();
        expect(result).toEqual(uint256(keccak256(abi.encodePacked(uint256(69)))));
    }

    function testToHaveRevertedWith() external {
        CallTest t = new CallTest();

        watchers.watch(address(t)).captureReverts();

        t.failWithStringRevert();
        t.failWithRequireMessage();
        t.failWithCustomError();

        expect(address(t).getCall(0)).toHaveRevertedWith(string("Error"));
        expect(address(t).getCall(1)).toHaveRevertedWith(string("Require message"));
        expect(address(t).getCall(2)).toHaveRevertedWith(CallTest.CustomError.selector);
        expect(address(t).firstCall()).toHaveRevertedWith(string("Error"));
        expect(address(t).lastCall()).toHaveRevertedWith(CallTest.CustomError.selector);

        bytes memory expectedError = abi.encodeWithSelector(CallTest.CustomError.selector, uint256(69));
        expect(address(t).getCall(2)).toHaveRevertedWith(expectedError);
    }

    function testToHaveEmittedPass() external {
        CallTest t = new CallTest();

        watchers.watch(payable(address(t)));

        t.emitEvent("foo", 123);

        expect(address(t).getCall(0)).toHaveEmitted("Event(string,uint256)");
    }

    function testToHaveEmittedFail() external shouldFail {
        CallTest t = new CallTest();

        watchers.watch(address(t));

        t.emitEvent("foo", 123);

        expect(address(t).getCall(0)).toHaveEmitted("Fake(string,uint256)");
    }

    function testToHaveEmittedWithDataPass() external {
        CallTest t = new CallTest();

        watchers.watch(address(t));

        t.emitEvent("foo", 123);

        expect(address(t).getCall(0)).toHaveEmitted("Event(string,uint256)", abi.encode(uint256(123)));
    }

    function testToHaveEmittedWithDataFail() external shouldFail {
        CallTest t = new CallTest();

        watchers.watch(address(t));

        t.emitEvent("foo", 123);

        expect(address(t).getCall(0)).toHaveEmitted("Event(string,uint256)", abi.encode(uint256(321)));
    }

    event Event(string indexed a, uint256 b);

    function testToHaveEmittedWithTopicsPass() external {
        CallTest t = new CallTest();

        watchers.watch(payable(address(t)));

        t.emitEvent("foo", 123);

        expect(address(t).calls()[0]).toHaveEmitted(
            "Event(string,uint256)",
            [any.topic()]
        );
    }

    function testToHaveEmittedWithTopicsFail() external shouldFail {
        CallTest t = new CallTest();

        watchers.watch(payable(address(t)));

        t.emitEvent("foo", 123);

        expect(address(t).calls()[0]).toHaveEmitted(
            "Fake(string,uint256)",
            [events.topic(string("bar"))],
            abi.encode(uint256(123))
        );
    }
}
