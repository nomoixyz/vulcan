// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

struct Event { 
    bytes32[] topics;
    bytes _data;
} 

// @dev Main entry point to sest tests
library events {
    using events for Event;

    function addTopic(Event memory _ev, bytes32 _topic) pure internal returns (Event memory) {
        if (_ev.topics.length == 4) {
            revert("Event already has 4 topics");
        }

        bytes32[] memory topics = _ev.topics;
        _ev.topics = new bytes32[](topics.length + 1);
        for (uint256 i = 0; i < topics.length; i++) {
            _ev.topics[i] = topics[i];
        }
        _ev.topics[topics.length] = _topic;
        return _ev;
    }

    function sig(string memory _sig) internal pure returns (Event memory ev) {
        // if (ev.topics.length != 0) {
        //     revert("Event already has topics");
        // }

        return ev.addTopic(keccak256(bytes(_sig)));
    }

    function indexedParam(Event memory self, uint256 _param) internal pure returns (Event memory) {
        return self.addTopic(bytes32(_param));
    }

    function indexedParam(Event memory self, string memory _param) internal pure returns (Event memory) {
        return self.addTopic(keccak256(bytes(_param)));
    }

    function indexedParam(Event memory self, address _param) internal pure returns (Event memory) {
        return self.addTopic(bytes32(uint256(uint160(_param))));
    }

    function indexedParam(Event memory self, bytes32 _param) internal pure returns (Event memory) {
        return self.addTopic(_param);
    }

    function indexedParam(Event memory self, bytes memory _param) internal pure returns (Event memory) {
        return self.addTopic(keccak256(_param));
    }

    function indexedParam(Event memory self, bool _param) internal pure returns (Event memory) {
        return self.addTopic(bytes32(uint256(_param ? 1 : 0)));
    }

    function indexedParam(Event memory self, int256 _param) internal pure returns (Event memory) {
        // TODO: is this correct?
        return self.addTopic(bytes32(uint256(_param)));
    }

    function data(Event memory self, bytes memory _data) internal pure returns (Event memory) {
        self._data = _data;
        return self;
    }

}

using events for Event global;
