// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

type __Any is uint256;

__Any constant ANY = __Any.wrap(0);

struct Topic {
    bytes32 _value;
    bool _any;
}

// @dev Main entry point to sest tests
library events {
    function toDynamic(Topic[1] memory topics) pure internal returns (Topic[] memory _topics) {
        _topics = new Topic[](1);
        _topics[0] = topics[0];
    }

    function toDynamic(Topic[2] memory topics) pure internal returns (Topic[] memory _topics) {
        _topics = new Topic[](2);
        _topics[0] = topics[0];
        _topics[1] = topics[1];
    }

    function toDynamic(Topic[3] memory topics) pure internal returns (Topic[] memory _topics) {
        _topics = new Topic[](3);
        _topics[0] = topics[0];
        _topics[1] = topics[1];
        _topics[2] = topics[2];
    }

    function toDynamic(Topic[4] memory topics) pure internal returns (Topic[] memory _topics) {
        _topics = new Topic[](4);
        _topics[0] = topics[0];
        _topics[1] = topics[1];
        _topics[2] = topics[2];
        _topics[3] = topics[3];
    }

    function topic(uint256 _param) internal pure returns (Topic memory) {
        return Topic(bytes32(_param), false);
    }

    function topic(string memory _param) internal pure returns (Topic memory) {
        return Topic(keccak256(bytes(_param)), false);
    }

    function topic(address _param) internal pure returns (Topic memory) {
        return Topic(bytes32(uint256(uint160(_param))), false);
    }

    // Just here for consistency
    function topic(bytes32 _param) internal pure returns (Topic memory) {
        return Topic(_param, false);
    }

    function topic(bytes memory _param) internal pure returns (Topic memory) {
        return Topic(keccak256(_param), false);
    }

    function topic(bool _param) internal pure returns (Topic memory) {
        return Topic(bytes32(uint256(_param ? 1 : 0)), false);
    }

    function topic(int256 _param) internal pure returns (Topic memory) {
        // TODO: is this correct?
        return Topic(bytes32(uint256(_param)), false);
    }

    function topic(__Any) internal pure returns (Topic memory) {
        return Topic(0, true);
    }
}

using events for __Any global;