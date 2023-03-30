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

bytes32 constant ADDRESS_HASH = keccak256(bytes("address"));
bytes32 constant BYTES32_HASH = keccak256(bytes("bytes32"));
bytes32 constant STRING_HASH = keccak256(bytes("string"));
bytes32 constant BYTES_HASH = keccak256(bytes("bytes"));
bytes32 constant UINT_HASH = keccak256(bytes("uint"));
bytes32 constant BOOL_HASH = keccak256(bytes("bool"));
bytes32 constant INT_HASH = keccak256(bytes("int"));

function parseFormat(string memory format) view returns (Type[] memory) {
    bytes memory formatBytes = bytes(format);

    Type[] memory types = new Type[](countPlaceholders(formatBytes));

    uint256 currentIndex = 0;

    for (uint256 i; i < types.length; i++) {
        uint256 placeholderStart = findPlaceholderStart(formatBytes, currentIndex);

        uint256 placeholderEnd = findPlaceholderEnd(formatBytes, placeholderStart);

        bytes memory placeholderBytes = new bytes(placeholderEnd - placeholderStart);

        for (uint256 j; j < placeholderEnd - placeholderStart; j++) {
            placeholderBytes[j] = formatBytes[placeholderStart + j];
        }

        bytes32 placeholderHash = keccak256(placeholderBytes);

        if (placeholderHash == UINT_HASH) {
            types[i] = Type.Uint256;
        } else if (placeholderHash == ADDRESS_HASH) {
            types[i] = Type.Address;
        } else if (placeholderHash == BOOL_HASH) {
            types[i] = Type.Bool;
        } else if (placeholderHash == STRING_HASH) {
            types[i] = Type.String;
        } else if (placeholderHash == INT_HASH) {
            types[i] = Type.Int256;
        } else if (placeholderHash == BYTES_HASH) {
            types[i] = Type.Bytes;
        } else if (placeholderHash == BYTES32_HASH) {
            types[i] = Type.Bytes32;
        } else {
            continue;
        }

        currentIndex = placeholderEnd;
    }

    return types;
}

function countPlaceholders(bytes memory format) view returns (uint256) {
    uint256 count = 0;
    uint256 currentIndex = 0;
    while (true) {
        uint256 placeholderStart = findPlaceholderStart(format, currentIndex);
        if (placeholderStart == format.length) {
            break; // No more placeholders found
        }
        count++;
        currentIndex = findPlaceholderEnd(format, placeholderStart);
    }
    return count;
}

function findPlaceholderStart(bytes memory format, uint256 offset) pure returns (uint256) {
    for (uint256 i = offset; i < format.length - 1; i++) {
        if (format[i] == bytes("{")[0]) {
            return i + 1;
        }
    }
    return format.length;
}

function findPlaceholderEnd(bytes memory format, uint256 start) pure returns (uint256) {
    for (uint256 i = start + 1; i < format.length; i++) {
        if (format[i] == bytes("}")[0]) {
            return i;
        }
    }
    return format.length;
}

function readWord(bytes memory data, uint256 offset) pure returns (bytes32) {
    bytes32 result;

    assembly {
        result := mload(add(add(data, 0x20), offset))
    }

    return result;
}

function readSlice(bytes memory data, uint256 start, uint256 len) pure returns (bytes memory) {
    require(start + len <= data.length, "Slice out of bounds");

    bytes memory result = new bytes(len);
    assembly {
        result := add(data, start)
    }
    return result;
}

function abiDecode(Type[] memory types, bytes memory data) pure returns (string[] memory) {
    string[] memory result = new string[](types.length);
    for (uint256 i = 0; i < types.length; i++) {
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
            offset = uint256(readWord(data, offset));
            uint256 len = uint256(readWord(data, offset));
            value = strings.toString(readSlice(data, offset + 32, len));
        } else if (types[i] == Type.String) {
            offset = uint256(readWord(data, offset));
            uint256 len = uint256(readWord(data, offset));
            value = string(readSlice(data, offset + 32, len));
        } else {
            revert("Unsupported type");
        }
        result[i] = value;
    }

    return result;
}
