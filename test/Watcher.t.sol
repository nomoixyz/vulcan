pragma solidity >=0.8.13 <0.9.0;

import {Test, expect, watchers} from "../src/lib.sol";

contract WatcherTest is Test {
    using watchers for *;

    function testItCanWatchAnAddress() external {
        WatcherTarget target = new WatcherTarget();
        address t = address(target);

        watchers.watch(t);

        expect(address(t.watcher().watcherStorage)).toBeAContract();
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

    function testItCanCaptureCallsThatRevert(uint256 i) external {
        WatcherTarget target = new WatcherTarget();
        address t = address(target);

        bytes memory expectedError = abi.encodeWithSignature("Error(string)", "Fail");

        watchers.watch(t).captureReverts();

        target.fail(i);

        expect(t.calls()[0].success).toBeFalse();
        expect(t.calls()[0].returnData).toEqual(expectedError);
    }

    function testItCanCaptureMultipleCallsThatRevert() external {
        WatcherTarget target = new WatcherTarget();
        address t = address(target);

        bytes memory expectedError = abi.encodeWithSignature("Error(string)", "Fail");

        watchers.watch(t).captureReverts();

        for (uint256 i; i < 10; ++i) {
            target.fail(i);
        }

        for (uint256 i; i <10; ++i) {
            expect(t.calls()[i].success).toBeFalse();
            expect(t.calls()[i].returnData).toEqual(expectedError);
        }
    }

    function testItCanCaptureMixedCalls(uint256 i) external {
        WatcherTarget target = new WatcherTarget();
        address t = address(target);

        bytes memory expectedError = abi.encodeWithSignature("Error(string)", "Fail");

        watchers.watch(t).captureReverts();

        target.fail(i);
        target.success(i);

        expect(t.calls()[0].success).toBeFalse();
        expect(t.calls()[0].returnData).toEqual(expectedError);

        expect(t.calls()[1].success).toBeTrue();
        expect(t.calls()[1].returnData).toEqual(abi.encodePacked(i));
    }
}

contract WatcherTarget {
    uint256 public i;

    function success(uint256 val) external returns (uint256) {
        i = val;

        return val;
    }

    function fail(uint256 val) external {
        if (val >= 0) {
            revert("Fail");
        }

        i = val;
    }
}
