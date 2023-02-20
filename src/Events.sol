// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.13 <0.9.0;

import {Vm as Hevm} from "forge-std/Vm.sol";
import "./Vulcan.sol";

library events {
    function toDynamic(bytes32[1] memory topics) internal pure returns (bytes32[] memory _topics) {
        _topics = new bytes32[](1);
        _topics[0] = topics[0];
    }

    function toDynamic(bytes32[2] memory topics) internal pure returns (bytes32[] memory _topics) {
        _topics = new bytes32[](2);
        _topics[0] = topics[0];
        _topics[1] = topics[1];
    }

    function toDynamic(bytes32[3] memory topics) internal pure returns (bytes32[] memory _topics) {
        _topics = new bytes32[](3);
        _topics[0] = topics[0];
        _topics[1] = topics[1];
        _topics[2] = topics[2];
    }

    function toDynamic(bytes32[4] memory topics) internal pure returns (bytes32[] memory _topics) {
        _topics = new bytes32[](4);
        _topics[0] = topics[0];
        _topics[1] = topics[1];
        _topics[2] = topics[2];
        _topics[3] = topics[3];
    }

    function topic(uint256 _param) internal pure returns (bytes32) {
        return bytes32(_param);
    }

    function topic(string memory _param) internal pure returns (bytes32) {
        return keccak256(bytes(_param));
    }

    function topic(address _param) internal pure returns (bytes32) {
        return bytes32(uint256(uint160(_param)));
    }

    // Just here for consistency
    function topic(bytes32 _param) internal pure returns (bytes32) {
        return _param;
    }

    function topic(bytes memory _param) internal pure returns (bytes32) {
        return keccak256(_param);
    }

    function topic(bool _param) internal pure returns (bytes32) {
        return bytes32(uint256(_param ? 1 : 0));
    }

    function topic(int256 _param) internal pure returns (bytes32) {
        // TODO: is this correct?
        return bytes32(uint256(_param));
    }

    function recordLogs() internal {
        vulcan.hevm.recordLogs();
    }

    function getRecordedLogs() internal returns (Log[] memory logs) {
        Hevm.Log[] memory recorded = vulcan.hevm.getRecordedLogs();
        assembly {
            logs := recorded
        }
    }
}
