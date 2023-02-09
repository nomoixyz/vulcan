// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.13 <0.9.0;

import { Vm as Hevm } from "forge-std/Vm.sol";
import "./Vulcan.sol";

type Events is bytes32;

// @dev Main entry point to sest tests
library EventsLib {
    function toDynamic(bytes32[1] memory topics) pure internal returns (bytes32[] memory _topics) {
        _topics = new bytes32[](1);
        _topics[0] = topics[0];
    }

    function toDynamic(bytes32[2] memory topics) pure internal returns (bytes32[] memory _topics) {
        _topics = new bytes32[](2);
        _topics[0] = topics[0];
        _topics[1] = topics[1];
    }

    function toDynamic(bytes32[3] memory topics) pure internal returns (bytes32[] memory _topics) {
        _topics = new bytes32[](3);
        _topics[0] = topics[0];
        _topics[1] = topics[1];
        _topics[2] = topics[2];
    }

    function toDynamic(bytes32[4] memory topics) pure internal returns (bytes32[] memory _topics) {
        _topics = new bytes32[](4);
        _topics[0] = topics[0];
        _topics[1] = topics[1];
        _topics[2] = topics[2];
        _topics[3] = topics[3];
    }

    function topic(Events, uint256 _param) internal pure returns (bytes32) {
        return bytes32(_param);
    }

    function topic(Events, string memory _param) internal pure returns (bytes32) {
        return keccak256(bytes(_param));
    }

    function topic(Events, address _param) internal pure returns (bytes32) {
        return bytes32(uint256(uint160(_param)));
    }

    // Just here for consistency
    function topic(Events, bytes32 _param) internal pure returns (bytes32) {
        return _param;
    }

    function topic(Events, bytes memory _param) internal pure returns (bytes32) {
        return keccak256(_param);
    }

    function topic(Events, bool _param) internal pure returns (bytes32) {
        return bytes32(uint256(_param ? 1 : 0));
    }

    function topic(Events, int256 _param) internal pure returns (bytes32) {
        // TODO: is this correct?
        return bytes32(uint256(_param));
    }

    function recordLogs(Events) internal {
        vulcan.hevm.recordLogs();
    }
    function getRecordedLogs(Events) internal returns (Log[] memory logs) {
        Hevm.Log[] memory recorded = vulcan.hevm.getRecordedLogs();
        assembly {
            logs := recorded
        }
    }
}

Events constant events = Events.wrap(0);

using EventsLib for Events global;