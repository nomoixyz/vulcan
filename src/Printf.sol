// SPDX-License-Identifier: MIT
pragma solidity >=0.8.13 <0.9.0;

import "./Strings.sol";
import "./Console.sol";

enum Type {
    Bool,
    Uint256,
    Int256,
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

function readSlice(bytes memory data, uint start, uint len) pure returns (bytes memory) {
        require(start + len <= data.length, "Slice out of bounds");

        bytes memory result = new bytes(len);
        assembly {
            result := add(data, start)
        }
        return result;
}

function abiDecode(Type[] memory types, bytes memory data) pure returns (string[] memory) {
    string[] memory result = new string[](types.length);
    for (uint i = 0; i < types.length; i++) {
        uint256 offset = i * 32;
        string memory value;
        if (types[i] == Type.Bool) {
            value = strings.toString(uint256(readWord(data, offset)) == 1);
        } else if (types[i] == Type.Uint256) {
            value = strings.toString(uint256(readWord(data, offset)));
        } else if (types[i] == Type.Int256) {
            value = strings.toString(int256(uint256(readWord(data, offset))));
        } else if (types[i] == Type.Address) {
            value = strings.toString(address(uint160(uint256(readWord(data, offset)))));
        } else if (types[i] == Type.Bytes32) {
            value = strings.toString(readWord(data, offset));
        } else if (types[i] == Type.Bytes) {
            offset = uint(readWord(data, offset));
            uint256 len = uint(readWord(data, offset));
            value = strings.toString(readSlice(data, offset + 32, len));
        } else if (types[i] == Type.String) {
            offset = uint(readWord(data, offset));
            uint256 len = uint(readWord(data, offset));
            value = string(readSlice(data, offset + 32, len));
        } else {
            revert("Unsupported type");
        }
        result[i] = value;
    }

    return result;
}
