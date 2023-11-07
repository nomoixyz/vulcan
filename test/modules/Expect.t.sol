// SPDX-License-Identifier: MIT
pragma solidity >=0.8.13 <0.9.0;

import {Test} from "src/test.sol";
import {ctx} from "src/test/Context.sol";
import {any, expect} from "src/test/Expect.sol";
import {events} from "src/test/Events.sol";
import {vulcan} from "src/test/Vulcan.sol";
import {watchers, Watcher} from "src/test/Watchers.sol";
import {delta} from "src/utils.sol";
import {Sender} from "../mocks/Sender.sol";

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
        if (true) {
            revert();
        }

        num = 0;
    }

    function failWithStringRevert() external {
        if (true) {
            revert("Error");
        }

        num = 0;
    }

    function failWithRequire() external {
        require(true == false);

        num = 0;
    }

    function failWithRequireMessage() external {
        require(true == false, "Require message");

        num = 0;
    }

    function failWithCustomError() external {
        if (true) {
            revert CustomError(num);
        }

        num = 0;
    }
}

contract ExpectTest is Test {
    using vulcan for *;
    using watchers for *;

    function testUintToEqualPass(uint256 a) external {
        expect(a).toEqual(a);
        expect(a).toEqual(a, "a should equal a");
    }

    function testUintToEqualFail(uint256 a, uint256 b) external shouldFail {
        ctx.assume(a != b);
        expect(a).toEqual(b);
    }

    function testUintToEqualFailWithMessage(uint256 a, uint256 b) external shouldFail {
        ctx.assume(a != b);
        expect(a).toEqual(b, "a should equal b");
    }

    function testUintNotToEqualPass(uint256 a, uint256 b) external {
        ctx.assume(a != b);
        expect(a).not.toEqual(b);
        expect(a).not.toEqual(b, "a should not equal b");
    }

    function testUintNotToEqualFail(uint256 a) external shouldFail {
        expect(a).not.toEqual(a);
    }

    function testUintNotToEqualFailWithMessage(uint256 a) external shouldFail {
        expect(a).not.toEqual(a, "a should not equal a");
    }

    function testUintToBeCloseToPass(uint256 a, uint256 b, uint256 d) external {
        ctx.assume(delta(a, b) <= d);
        expect(a).toBeCloseTo(b, d);
        expect(a).toBeCloseTo(b, d, "a should be close to b");
    }

    function testUintToBeCloseToFail(uint256 a, uint256 b, uint256 d) external shouldFail {
        ctx.assume(delta(a, b) > d);
        expect(a).toBeCloseTo(b, d);
    }

    function testUintToBeCloseToFailWithMessage(uint256 a, uint256 b, uint256 d) external shouldFail {
        ctx.assume(delta(a, b) > d);
        expect(a).toBeCloseTo(b, d, "a should be close to b");
    }

    function testUintToBeLessThanPass(uint256 a, uint256 b) external {
        ctx.assume(a < b);
        expect(a).toBeLessThan(b);
        expect(a).toBeLessThan(b, "a should be less than b");
    }

    function testUintToBeLessThanOrEqualPass(uint256 a, uint256 b) external {
        ctx.assume(a <= b);
        expect(a).toBeLessThanOrEqual(b);
        expect(a).toBeLessThanOrEqual(a);
        expect(a).toBeLessThanOrEqual(b, "a should be less than or equal to b");
        expect(a).toBeLessThanOrEqual(a, "a should be less than or equal to a");
    }

    function testUintToBeGreaterThanPass(uint256 a, uint256 b) external {
        ctx.assume(a > b);
        expect(a).toBeGreaterThan(b);
        expect(a).toBeGreaterThan(b, "a should be greater than b");
    }

    function testUintToBeGreaterThanOrEqualPass(uint256 a, uint256 b) external {
        ctx.assume(a >= b);
        expect(a).toBeGreaterThanOrEqual(b);
        expect(a).toBeGreaterThanOrEqual(a);
        expect(a).toBeGreaterThanOrEqual(b, "a should be greater than or equal to b");
        expect(a).toBeGreaterThanOrEqual(a, "a should be greater than or equal to a");
    }

    function testIntToEqualPass(int256 a) external {
        expect(a).toEqual(a);
        expect(a).toEqual(a, "a should equal a");
    }

    function testIntToEqualFail(int256 a, int256 b) external shouldFail {
        ctx.assume(a != b);
        expect(a).toEqual(b);
    }

    function testIntToEqualFailWithMessage(int256 a, int256 b) external shouldFail {
        ctx.assume(a != b);
        expect(a).toEqual(b, "a should equal b");
    }

    function testIntNotToEqualPass(int256 a, int256 b) external {
        ctx.assume(a != b);
        expect(a).not.toEqual(b);
        expect(a).not.toEqual(b, "a should not equal b");
    }

    function testIntNotToEqualFail(int256 a) external shouldFail {
        expect(a).not.toEqual(a);
    }

    function testIntNotToEqualFailWithMessage(int256 a) external shouldFail {
        expect(a).not.toEqual(a, "a should not equal a");
    }

    function testIntToBeCloseToPass(int256 a, int256 b, uint256 d) external {
        ctx.assume(delta(a, b) <= d);
        expect(a).toBeCloseTo(b, d);
        expect(a).toBeCloseTo(b, d, "a should be close to b");
    }

    function testIntToBeCloseToFail(int256 a, int256 b, uint256 d) external shouldFail {
        ctx.assume(delta(a, b) > d);
        expect(a).toBeCloseTo(b, d);
    }

    function testIntToBeCloseToFailWithMessage(int256 a, int256 b, uint256 d) external shouldFail {
        ctx.assume(delta(a, b) > d);
        expect(a).toBeCloseTo(b, d, "a should be close to b");
    }

    function testIntToBeLessThanPass(int256 a, int256 b) external {
        ctx.assume(a < b);
        expect(a).toBeLessThan(b);
        expect(a).toBeLessThan(b, "a should be less than b");
    }

    function testIntToBeLessThanFail(int256 a, int256 b) external shouldFail {
        ctx.assume(a >= b);
        expect(a).toBeLessThan(b);
    }

    function testIntToBeLessThanFailWithMessage(int256 a, int256 b) external shouldFail {
        ctx.assume(a >= b);
        expect(a).toBeLessThan(b, "a should be less than b");
    }

    function testIntToBeLessThanOrEqualPass(int256 a, int256 b) external {
        ctx.assume(a <= b);
        expect(a).toBeLessThanOrEqual(b);
        expect(a).toBeLessThanOrEqual(a);
        expect(a).toBeLessThanOrEqual(b, "a should be less than or equal to b");
        expect(a).toBeLessThanOrEqual(a, "a should be less than or equal to a");
    }

    function testIntToBeLessThanOrEqualFail(int256 a, int256 b) external shouldFail {
        ctx.assume(a > b);
        expect(a).toBeLessThanOrEqual(b);
    }

    function testIntToBeLessThanOrEqualFailWithMessage(int256 a, int256 b) external shouldFail {
        ctx.assume(a > b);
        expect(a).toBeLessThanOrEqual(b, "a should be less than or equal to b");
    }

    function testIntToBeGreaterThanPass(int256 a, int256 b) external {
        ctx.assume(a > b);
        expect(a).toBeGreaterThan(b);
        expect(a).toBeGreaterThan(b, "a should be greater than b");
    }

    function testIntToBeGreaterThanFail(int256 a, int256 b) external shouldFail {
        ctx.assume(a <= b);
        expect(a).toBeGreaterThan(b);
    }

    function testIntToBeGreaterThanFailWithMessage(int256 a, int256 b) external shouldFail {
        ctx.assume(a <= b);
        expect(a).toBeGreaterThan(b, "a should be greater than b");
    }

    function testIntToBeGreaterThanOrEqualPass(int256 a, int256 b) external {
        ctx.assume(a >= b);
        expect(a).toBeGreaterThanOrEqual(b);
        expect(a).toBeGreaterThanOrEqual(a);
        expect(a).toBeGreaterThanOrEqual(b, "a should be greater than or equal to b");
        expect(a).toBeGreaterThanOrEqual(a, "a should be greater than or equal to a");
    }

    function testIntToBeGreaterThanOrEqualFail(int256 a, int256 b) external shouldFail {
        ctx.assume(a < b);
        expect(a).toBeGreaterThanOrEqual(b);
    }

    function testIntToBeGreaterThanOrEqualFailWithMessage(int256 a, int256 b) external shouldFail {
        ctx.assume(a < b);
        expect(a).toBeGreaterThanOrEqual(b, "a should be greater than or equal to b");
    }

    function testBoolToEqualPass(bool a) external {
        if (a) {
            expect(a).toEqual(true);
            expect(a).toEqual(true, "a should be true");
            expect(a).toBeTrue();
            expect(a).toBeTrue("a should be true");
        } else {
            expect(a).toEqual(false);
            expect(a).toEqual(false, "a should be false");
            expect(a).toBeFalse();
            expect(a).toBeFalse("a should be false");
        }
    }

    /* BYTES32 */

    function testBytes32ToEqualPass(bytes32 a) external {
        expect(a).toEqual(a);
        expect(a).toEqual(a, "a should equal a");
    }

    function testBytes32ToEqualFail(bytes32 a, bytes32 b) external shouldFail {
        ctx.assume(a != b);
        expect(a).toEqual(b);
    }

    function testBytes32ToEqualFailWithMessage(bytes32 a, bytes32 b) external shouldFail {
        ctx.assume(a != b);
        expect(a).toEqual(b, "a should equal b");
    }

    function testBytes32NotToEqualPass(bytes32 a, bytes32 b) external {
        ctx.assume(a != b);
        expect(a).not.toEqual(b);
        expect(a).not.toEqual(b, "a should not equal b");
    }

    function testBytes32NotToEqualFail(bytes32 a) external shouldFail {
        expect(a).not.toEqual(a);
    }

    function testBytes32NotToEqualFailWithMessage(bytes32 a) external shouldFail {
        expect(a).not.toEqual(a, "a should not equal a");
    }

    function testBytes32ToBeTheHashOfPass(bytes memory a) external {
        expect(keccak256(a)).toBeTheHashOf(a);
        expect(keccak256(a)).toBeTheHashOf(a, "keccak(a) should be the hash of a");
    }

    function testBytes32ToBeTheHashOfFail(bytes32 a, bytes memory b) external shouldFail {
        ctx.assume(keccak256(b) != a);
        expect(a).toBeTheHashOf(b);
    }

    function testBytes32ToBeTheHashOfFailWithMessage(bytes32 a, bytes memory b) external shouldFail {
        ctx.assume(keccak256(b) != a);
        expect(a).toBeTheHashOf(b, "a should be the hash of b");
    }

    function testBytes32NotToBeTheHashOfPass(bytes32 a, bytes memory b) external {
        ctx.assume(keccak256(b) != a);
        expect(a).not.toBeTheHashOf(b);
        expect(a).not.toBeTheHashOf(b, "a should not be the hash of b");
    }

    /* STRING */

    function testStringToEqualPass(string memory a) external {
        expect(a).toEqual(a);
        expect(a).toEqual(a, "a should equal a");
    }

    function testStringToEqualFail(string memory a, string memory b) external shouldFail {
        ctx.assume(keccak256(bytes(a)) != keccak256(bytes(b)));
        expect(a).toEqual(b);
    }

    function testStringToEqualFailWithMessage(string memory a, string memory b) external shouldFail {
        ctx.assume(keccak256(bytes(a)) != keccak256(bytes(b)));
        expect(a).toEqual(b, "a should equal b");
    }

    function testStringNotToEqualPass(string memory a, string memory b) external {
        ctx.assume(keccak256(bytes(a)) != keccak256(bytes(b)));
        expect(a).not.toEqual(b);
        expect(a).not.toEqual(b, "a should not equal b");
    }

    function testStringNotToEqualFail(string memory a) external shouldFail {
        expect(a).not.toEqual(a);
    }

    function testStringNotToEqualFailWithMessage(string memory a) external shouldFail {
        expect(a).not.toEqual(a, "a should not equal a");
    }

    function testStringToContainPass(string memory a, string memory b, string memory c) external {
        expect(string.concat(a, b, c)).toContain(b);
        expect(string.concat(a, b, c)).toContain(b, "abc should contain b");
    }

    // TODO: fuzzing?
    function testStringToContainFail() external shouldFail {
        expect(string("abc")).toContain("d");
    }

    function testStringToContainFailWithMessage() external shouldFail {
        expect(string("abc")).toContain("d", "abc should contain d");
    }

    function testStringNotToContainPass() external {
        expect(string("abc")).not.toContain("d");
        expect(string("abc")).not.toContain("d", "abc should not contain d");
        expect(string("abc")).not.toContain("abcde");
        expect(string("abc")).not.toContain("abcde", "abc should not contain abcde");
    }

    function testStringNotToContainFail(string memory a, string memory b, string memory c) external shouldFail {
        expect(string.concat(a, b, c)).not.toContain(b);
    }

    function testStringNotToContainFailWithMessage(string memory a, string memory b, string memory c)
        external
        shouldFail
    {
        expect(string.concat(a, b, c)).not.toContain(b, "abc should not contain b");
    }

    function testStringToHaveLengthPass(string memory a) external {
        expect(a).toHaveLength(bytes(a).length);
        expect(a).toHaveLength(bytes(a).length, "a should have length of bytes(a).length");
    }

    function testStringToHaveLengthFail(string memory a, uint256 len) external shouldFail {
        ctx.assume(len != bytes(a).length);
        expect(a).toHaveLength(len);
    }

    function testStringToHaveLengthFailWithMessage(string memory a, uint256 len) external shouldFail {
        ctx.assume(len != bytes(a).length);
        expect(a).toHaveLength(len, "a should have length of len");
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
        expect(address(t).getCall(0)).toHaveReverted("t.failWithRevert() should have reverted");
        expect(address(t).getCall(1)).toHaveReverted();
        expect(address(t).getCall(1)).toHaveReverted("t.failWithStringRevert() should have reverted");
        expect(address(t).getCall(2)).toHaveReverted();
        expect(address(t).getCall(2)).toHaveReverted("t.failWithRequire() should have reverted");
        expect(address(t).getCall(3)).toHaveReverted();
        expect(address(t).getCall(3)).toHaveReverted("t.failWithRequireMessage() should have reverted");
        expect(address(t).getCall(4)).toHaveReverted();
        expect(address(t).getCall(4)).toHaveReverted("t.failWithCustomError() should have reverted");
        expect(address(t).firstCall()).toHaveReverted();
        expect(address(t).firstCall()).toHaveReverted("first call to t should have reverted");
        expect(address(t).lastCall()).toHaveReverted();
        expect(address(t).lastCall()).toHaveReverted("last call to t should have reverted");
    }

    function testToHaveSucceeded() external {
        CallTest t = new CallTest();

        watchers.watch(address(t));

        uint256 result = t.ok();

        expect(address(t).getCall(0)).toHaveSucceeded();
        expect(address(t).getCall(0)).toHaveSucceeded("t.ok() should have succeeded");
        expect(address(t).firstCall()).toHaveSucceeded();
        expect(address(t).firstCall()).toHaveSucceeded("first call to t should have succeeded");
        expect(address(t).lastCall()).toHaveSucceeded();
        expect(address(t).lastCall()).toHaveSucceeded("last call to t should have succeeded");
        expect(result).toEqual(uint256(keccak256(abi.encodePacked(uint256(69)))));
        expect(result).toEqual(uint256(keccak256(abi.encodePacked(uint256(69)))), "result should equal keccak256(69)");
    }

    function testToHaveRevertedWith() external {
        CallTest t = new CallTest();

        watchers.watch(address(t)).captureReverts();

        t.failWithStringRevert();
        t.failWithRequireMessage();
        t.failWithCustomError();

        expect(address(t).getCall(0)).toHaveRevertedWith(string("Error"));
        expect(address(t).getCall(0)).toHaveRevertedWith(
            string("Error"), "t.failWithStringRevert() should have reverted with 'Error'"
        );
        expect(address(t).getCall(1)).toHaveRevertedWith(string("Require message"));
        expect(address(t).getCall(1)).toHaveRevertedWith(
            string("Require message"), "t.failWithRequireMessage() should have reverted with 'Require message'"
        );
        expect(address(t).getCall(2)).toHaveRevertedWith(CallTest.CustomError.selector);
        expect(address(t).getCall(2)).toHaveRevertedWith(
            CallTest.CustomError.selector, "t.failWithCustomError() should have reverted with CustomError"
        );
        expect(address(t).firstCall()).toHaveRevertedWith(string("Error"));
        expect(address(t).firstCall()).toHaveRevertedWith(
            string("Error"), "first call to t should have reverted with 'Error'"
        );
        expect(address(t).lastCall()).toHaveRevertedWith(CallTest.CustomError.selector);
        expect(address(t).lastCall()).toHaveRevertedWith(
            CallTest.CustomError.selector, "last call to t should have reverted with CustomError"
        );

        bytes memory expectedError = abi.encodeWithSelector(CallTest.CustomError.selector, uint256(69));
        expect(address(t).getCall(2)).toHaveRevertedWith(expectedError);
        expect(address(t).getCall(2)).toHaveRevertedWith(
            expectedError, "t.failWithCustomError() should have reverted with CustomError(69)"
        );
    }

    function testToHaveEmittedPass() external {
        CallTest t = new CallTest();

        watchers.watch(payable(address(t)));

        t.emitEvent("foo", 123);

        expect(address(t).getCall(0)).toHaveEmitted("Event(string,uint256)");
        expect(address(t).getCall(0)).toHaveEmitted(
            "Event(string,uint256)", string("t.emitEvent() should have emitted Event")
        );
    }

    function testToHaveEmittedFail() external shouldFail {
        CallTest t = new CallTest();

        watchers.watch(address(t));

        t.emitEvent("foo", 123);

        expect(address(t).getCall(0)).toHaveEmitted("Fake(string,uint256)");
    }

    function testToHaveEmittedFailWithMessage() external shouldFail {
        CallTest t = new CallTest();

        watchers.watch(address(t));

        t.emitEvent("foo", 123);

        expect(address(t).getCall(0)).toHaveEmitted(
            "Fake(string,uint256)", string("t.emitEvent() should have emitted Fake")
        );
    }

    function testToHaveEmittedWithDataPass() external {
        CallTest t = new CallTest();

        watchers.watch(address(t));

        t.emitEvent("foo", 123);

        expect(address(t).getCall(0)).toHaveEmitted("Event(string,uint256)", abi.encode(uint256(123)));
        expect(address(t).getCall(0)).toHaveEmitted(
            "Event(string,uint256)",
            abi.encode(uint256(123)),
            string("t.emitEvent() should have emitted Event with data")
        );
    }

    function testToHaveEmittedWithDataFail() external shouldFail {
        CallTest t = new CallTest();

        watchers.watch(address(t));

        t.emitEvent("foo", 123);

        expect(address(t).getCall(0)).toHaveEmitted("Event(string,uint256)", abi.encode(uint256(321)));
    }

    function testToHaveEmittedWithDataFailWithMessage() external shouldFail {
        CallTest t = new CallTest();

        watchers.watch(address(t));

        t.emitEvent("foo", 123);

        expect(address(t).getCall(0)).toHaveEmitted(
            "Event(string,uint256)",
            abi.encode(uint256(321)),
            string("t.emitEvent() should have emitted Event with data")
        );
    }

    event Event(string indexed a, uint256 b);

    function testToHaveEmittedWithTopicsPass() external {
        CallTest t = new CallTest();

        watchers.watch(payable(address(t)));

        t.emitEvent("foo", 123);

        expect(address(t).calls()[0]).toHaveEmitted("Event(string,uint256)", [any()]);
        expect(address(t).calls()[0]).toHaveEmitted(
            "Event(string,uint256)", [any()], string("t.emitEvent() should have emitted Event with topics")
        );
    }

    function testToHaveEmittedWithTopicsFail() external shouldFail {
        CallTest t = new CallTest();

        watchers.watch(payable(address(t)));

        t.emitEvent("foo", 123);

        expect(address(t).calls()[0]).toHaveEmitted(
            "Fake(string,uint256)", [events.topic(string("bar"))], abi.encode(uint256(123))
        );
    }

    function testToHaveEmittedWithTopicsFailWithMessage() external shouldFail {
        CallTest t = new CallTest();

        watchers.watch(payable(address(t)));

        t.emitEvent("foo", 123);

        expect(address(t).calls()[0]).toHaveEmitted(
            "Fake(string,uint256)",
            [events.topic(string("bar"))],
            abi.encode(uint256(123)),
            string("t.emitEvent() should have emitted Fake with topics")
        );
    }

    function testToBeAContractPass() external {
        CallTest t = new CallTest();

        expect(address(t)).toBeAContract();
        expect(address(t)).toBeAContract("address(t) should be a contract");
    }

    function testToBeAContractFail() external shouldFail {
        expect(address(0)).toBeAContract();
    }

    function testToBeAContractFailWithMessage() external shouldFail {
        expect(address(0)).toBeAContract("address(0) should be a contract");
    }

    function testNotToBeAContractPass() external {
        expect(address(0)).not.toBeAContract();
        expect(address(0)).not.toBeAContract("address(0) should not be a contract");
    }

    function testNotToBeAContractFail() external shouldFail {
        CallTest t = new CallTest();

        expect(address(t)).not.toBeAContract();
    }

    function testNotToBeAContractFailWithMessage() external shouldFail {
        CallTest t = new CallTest();

        expect(address(t)).not.toBeAContract("address(t) should not be a contract");
    }
}
