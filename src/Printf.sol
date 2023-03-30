// SPDX-License-Identifier: MIT
pragma solidity >=0.8.13 <0.9.0;

import "./Strings.sol";

enum Type {
    Uint256,
    String,
    Address,
    Bytes32,
    Bytes
}

function readWord(bytes memory data, uint256 offset) pure returns (bytes32) {
    bytes32 result;

    assembly {
        result := mload(add(add(data, 0x20), offset))
    }

    return result;
}

function abiDecode(Type[] memory types, bytes memory data) pure returns (string[] memory) {
    string[] memory result = new string[](types.length);
    for (uint i = 0; i < types.length; i++) {
        uint256 offset = i * 32;
        string memory value;
        if (types[i] == Type.Uint256) { // uint256
            value = strings.toString(uint256(readWord(data, offset)));
        } else {
            revert("Unsupported type");
        }
        result[i] = value;
    }

    return result;
}
