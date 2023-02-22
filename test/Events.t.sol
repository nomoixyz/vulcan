pragma solidity >=0.8.13 <0.9.0;

import {Test, expect, events, Log} from "../src/test.sol";

contract EventsTest is Test {
    using events for *;

    function testItCanConvertFixedToDynamicArrays(bytes32 t0, bytes32 t1, bytes32 t2, bytes32 t3) external {
        bytes32[1] memory topics1 = [t0];
        bytes32[2] memory topics2 = [t0, t1];
        bytes32[3] memory topics3 = [t0, t1, t2];
        bytes32[4] memory topics4 = [t0, t1, t2, t3];

        bytes32[] memory dynamic1 = topics1.toDynamic();
        bytes32[] memory dynamic2 = topics2.toDynamic();
        bytes32[] memory dynamic3 = topics3.toDynamic();
        bytes32[] memory dynamic4 = topics4.toDynamic();

        for (uint256 i; i < topics1.length; ++i) {
            expect(topics1[i]).toEqual(dynamic1[i]);
        }

        for (uint256 i; i < topics2.length; ++i) {
            expect(topics2[i]).toEqual(dynamic2[i]);
        }

        for (uint256 i; i < topics3.length; ++i) {
            expect(topics3[i]).toEqual(dynamic3[i]);
        }

        for (uint256 i; i < topics4.length; ++i) {
            expect(topics4[i]).toEqual(dynamic4[i]);
        }
    }

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
