pragma solidity >=0.8.13 <0.9.0;

import {Test, expect, events, Log} from "../../src/test.sol";
import {events} from "src/test/Events.sol";
import {expect} from "src/test/Expect.sol";
import {Log} from "src/test/Vulcan.sol";

contract EventsTest is Test {
    using events for *;

    function testItCanConvertUintToTopic(uint256 value) external {
        expect(value.topic()).toEqual(bytes32(value));
    }

    function testItCanConvertStringToTopic(string memory value) external {
        expect(value.topic()).toEqual(keccak256(bytes(value)));
    }

    function testItCanConvertAddressToTopic(address value) external {
        expect(value.topic()).toEqual(bytes32(uint256(uint160(value))));
    }

    function testItCanConvertBytes32ToTopic(bytes32 value) external {
        expect(value.topic()).toEqual(value);
    }

    function testItCanConvertBytesToTopic(bytes memory value) external {
        expect(value.topic()).toEqual(keccak256(value));
    }

    function testItCanConvertBoolToTopic() external {
        expect(false.topic()).toEqual(bytes32(uint256(0)));
        expect(true.topic()).toEqual(bytes32(uint256(1)));
    }

    function testItCanConvertIntToTopic(int256 value) external {
        expect(value.topic()).toEqual(bytes32(uint256(value)));
    }

    event SomeEvent(uint256 indexed a, address b);

    function testItCanGetRecordedLogs(uint256 a, address b) external {
        events.recordLogs();

        emit SomeEvent(a, b);

        Log[] memory logs = events.getRecordedLogs();

        expect(logs.length).toEqual(1);
        expect(logs[0].emitter).toEqual(address(this));
        expect(logs[0].topics[0]).toEqual(SomeEvent.selector);
        expect(logs[0].topics[1]).toEqual(a.topic());
        expect(logs[0].data).toEqual(abi.encode(b));
    }
}
