// SPDX-License-Identifier: MIT
pragma solidity >=0.8.13 <0.9.0;

import {Test} from "src/test.sol";
import {expect} from "src/test/Expect.sol";
import {watchersUnsafe as watchers, Watcher} from "src/_internal/Watchers.sol";

contract WatcherTarget {
    struct SomeStruct {
        string foo;
    }

    event SomeEvent(SomeStruct indexed s);

    uint256 public i;

    function emitEvent() external {
        emit SomeEvent(SomeStruct("bar"));
    }

    function success(uint256 val) external returns (uint256) {
        i = val;

        return val;
    }

    function fail() external {
        // Silcence function visibility warning
        i = 0;
        revert("Fail");
    }
}

contract WatchersTest is Test {
    using watchers for *;

    function testItCanWatchAnAddress() external {
        WatcherTarget target = new WatcherTarget();
        address t = address(target);

        watchers.watch(t);

        expect(address(t.watcher())).toBeAContract();
    }

    function testItCanCaptureCalls(uint256 i) external {
        WatcherTarget target = new WatcherTarget();
        address t = address(target);

        watchers.watch(t);

        target.success(i);

        expect(t.calls()[0].success).toBeTrue();
        expect(t.calls()[0].returnData).toEqual(abi.encodePacked(i));
    }

    function testItCanCaptureMultipleCalls() external {
        WatcherTarget target = new WatcherTarget();
        address t = address(target);

        watchers.watch(t);

        for (uint256 i; i < 10; ++i) {
            target.success(i);
        }

        for (uint256 i; i < 10; ++i) {
            expect(t.calls()[i].success).toBeTrue();
            expect(t.calls()[i].returnData).toEqual(abi.encodePacked(i));
        }
    }

    function testItCanCaptureCallsThatRevert() external {
        WatcherTarget target = new WatcherTarget();
        address t = address(target);

        bytes memory expectedError = abi.encodeWithSignature("Error(string)", "Fail");

        watchers.watch(t).captureReverts();

        target.fail();

        expect(t.calls()[0].success).toBeFalse();
        expect(t.calls()[0].returnData).toEqual(expectedError);
    }

    function testItCanCaptureMultipleCallsThatRevert() external {
        WatcherTarget target = new WatcherTarget();
        address t = address(target);

        bytes memory expectedError = abi.encodeWithSignature("Error(string)", "Fail");

        watchers.watch(t).captureReverts();

        for (uint256 i; i < 10; ++i) {
            target.fail();
        }

        for (uint256 i; i < 10; ++i) {
            expect(t.getCall(i).success).toBeFalse();
            expect(t.getCall(i).returnData).toEqual(expectedError);
        }
    }

    function testItCanCaptureMixedCalls(uint256 i) external {
        WatcherTarget target = new WatcherTarget();
        address t = address(target);

        bytes memory expectedError = abi.encodeWithSignature("Error(string)", "Fail");

        watchers.watch(t).captureReverts();

        target.fail();
        target.success(i);

        expect(t.calls()[0].success).toBeFalse();
        expect(t.calls()[0].returnData).toEqual(expectedError);

        expect(t.calls()[1].success).toBeTrue();
        expect(t.calls()[1].returnData).toEqual(abi.encodePacked(i));
    }

    function testItRestoresTheOriginalStateAfterStop() external {
        WatcherTarget target = new WatcherTarget();
        address t = address(target);

        bytes32 originalCode = keccak256(t.code);

        watchers.watch(t);

        target.success(0);

        expect(t.calls().length).toEqual(1);

        t.stopWatcher();

        // Check that the addresses codes are restored to the original state
        expect(keccak256(t.code)).toEqual(originalCode);
        expect(keccak256(t.watcherAddress().code)).toEqual(keccak256(bytes("")));

        // Check that we can watch again after stoping the watcher
        watchers.watch(t);

        target.success(0);
        target.success(0);
        target.success(0);

        expect(t.calls().length).toEqual(3);
    }

    event SomeEvent(WatcherTarget.SomeStruct indexed s);

    function testEmittedWithSelector() external {
        WatcherTarget target = new WatcherTarget();

        watchers.watch(address(target));

        target.emitEvent();

        bytes32[2] memory topics = [SomeEvent.selector, keccak256(abi.encode(WatcherTarget.SomeStruct("bar")))];
        expect(address(target).lastCall()).toHaveEmitted(topics);
    }
}
