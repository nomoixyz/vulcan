// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

type __Any is uint256;

__Any constant ANY = __Any.wrap(0);

struct Event { 
    string _sig;
    Topic[] _topics;
    bytes _data;
} 

struct Topic {
    bytes32 _value;
    bool _any;
}

// @dev Main entry point to sest tests
library events {
    using events for Event;

    function _addTopic(Event memory _ev, Topic memory _topic) pure internal returns (Event memory) {
        if (_ev._topics.length == 4) {
            revert("Event already has 4 topics");
        }

        Topic[] memory _topics = _ev._topics;
        _ev._topics = new Topic[](_topics.length + 1);
        for (uint256 i = 0; i < _topics.length; i++) {
            _ev._topics[i] = _topics[i];
        }
        _ev._topics[_topics.length] = _topic;
        return _ev;
    }

    function create(Topic[] memory _topics, bytes memory _data) pure internal returns (Event memory) {
        return create("", _topics, _data);
    }

    function create(string memory _sig, Topic[] memory _topics, bytes memory _data) pure internal returns (Event memory) {
        Event memory _ev;
        if (bytes(_sig).length > 0) {
            _ev._sig = _sig;
            _ev.topic(_sig);
        }

        for (uint256 i = 0; i < _topics.length; i++) {
            _ev._addTopic(_topics[i]);
        }
        _ev._data = _data;
        return _ev;
    }

    function sig(string memory _sig) internal pure returns (Event memory ev) {
        ev._sig = _sig;
        return ev._addTopic(topic(_sig));
    }

    function topic(Event memory self, uint256 _param) internal pure returns (Event memory) {
        return self._addTopic(topic(_param));
    }

    function topic(uint256 _param) internal pure returns (Topic memory) {
        return Topic(bytes32(_param), false);
    }

    function topic(Event memory self, string memory _param) internal pure returns (Event memory) {
        return self._addTopic(topic(_param));
    }

    function topic(string memory _param) internal pure returns (Topic memory) {
        return Topic(keccak256(bytes(_param)), false);
    }

    function topic(Event memory self, address _param) internal pure returns (Event memory) {
        return self._addTopic(topic(_param));
    }

    function topic(address _param) internal pure returns (Topic memory) {
        return Topic(bytes32(uint256(uint160(_param))), false);
    }

    function topic(Event memory self, bytes32 _param) internal pure returns (Event memory) {
        return self._addTopic(topic(_param));
    }

    // Just here for consistency
    function topic(bytes32 _param) internal pure returns (Topic memory) {
        return Topic(_param, false);
    }

    function topic(Event memory self, bytes memory _param) internal pure returns (Event memory) {
        return self._addTopic(topic(_param));
    }

    function topic(bytes memory _param) internal pure returns (Topic memory) {
        return Topic(keccak256(_param), false);
    }

    function topic(Event memory self, bool _param) internal pure returns (Event memory) {
        return self._addTopic(topic(_param));
    }

    function topic(bool _param) internal pure returns (Topic memory) {
        return Topic(bytes32(uint256(_param ? 1 : 0)), false);
    }

    function topic(Event memory self, int256 _param) internal pure returns (Event memory) {
        return self._addTopic(topic(_param));
    }

    function topic(int256 _param) internal pure returns (Topic memory) {
        // TODO: is this correct?
        return Topic(bytes32(uint256(_param)), false);
    }

    function topic(Event memory self, __Any any) internal pure returns (Event memory) {
        return self._addTopic(topic(any));
    }

    function topic(__Any) internal pure returns (Topic memory) {
        return Topic(0, true);
    }

    function topics(Event memory self, Topic[] memory _topics) internal pure returns (Event memory) {
        for (uint256 i = 0; i < _topics.length; i++) {
            self._addTopic(_topics[i]);
        }
        return self;
    }

    function topics(Topic[] memory _topics) internal pure returns (Event memory ev) {
        for (uint256 i = 0; i < _topics.length; i++) {
            ev._addTopic(_topics[i]);
        }
        return ev;
    }

    function data(Event memory self, bytes memory _data) internal pure returns (Event memory) {
        self._data = _data;
        return self;
    }
}

using events for Event global;
using events for __Any global;