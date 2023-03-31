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

struct Placeholder {
    uint256 start;
    uint256 end;
    Type t;
}

bytes32 constant ADDRESS_HASH = keccak256(bytes("address"));
bytes32 constant BYTES32_HASH = keccak256(bytes("bytes32"));
bytes32 constant STRING_HASH = keccak256(bytes("string"));
bytes32 constant BYTES_HASH = keccak256(bytes("bytes"));
bytes32 constant UINT_HASH = keccak256(bytes("uint"));
bytes32 constant BOOL_HASH = keccak256(bytes("bool"));
bytes32 constant INT_HASH = keccak256(bytes("int"));

function parseTemplate(string memory template) pure returns (Placeholder[] memory) {
    bytes memory templateBytes = bytes(template);

    Placeholder[] memory placeholders = new Placeholder[](countPlaceholders(templateBytes));

    if (placeholders.length == 0) {
        return placeholders;
    }

    uint256 currentIndex = 0;

    for (uint256 i; i < placeholders.length; i++) {
        uint256 placeholderStart = findPlaceholderStart(templateBytes, currentIndex);

        uint256 placeholderEnd = findPlaceholderEnd(templateBytes, placeholderStart);

        bytes memory placeholderBytes = new bytes(placeholderEnd - placeholderStart - 2);

        for (uint256 j; j < placeholderBytes.length; j++) {
            placeholderBytes[j] = templateBytes[placeholderStart + j + 1];
        }

        bytes32 placeholderHash = keccak256(placeholderBytes);

        if (placeholderHash == UINT_HASH) {
            placeholders[i] = Placeholder(placeholderStart, placeholderEnd, Type.Uint256);
        } else if (placeholderHash == ADDRESS_HASH) {
            placeholders[i] = Placeholder(placeholderStart, placeholderEnd, Type.Address);
        } else if (placeholderHash == BOOL_HASH) {
            placeholders[i] = Placeholder(placeholderStart, placeholderEnd, Type.Bool);
        } else if (placeholderHash == STRING_HASH) {
            placeholders[i] = Placeholder(placeholderStart, placeholderEnd, Type.String);
        } else if (placeholderHash == INT_HASH) {
            placeholders[i] = Placeholder(placeholderStart, placeholderEnd, Type.Int256);
        } else if (placeholderHash == BYTES_HASH) {
            placeholders[i] = Placeholder(placeholderStart, placeholderEnd, Type.Bytes);
        } else if (placeholderHash == BYTES32_HASH) {
            placeholders[i] = Placeholder(placeholderStart, placeholderEnd, Type.Bytes32);
        } else {
            continue;
        }

        currentIndex = placeholderEnd;
    }

    return placeholders;
}

function countPlaceholders(bytes memory template) pure returns (uint256) {
    uint256 count = 0;
    uint256 currentIndex = 0;
    while (true) {
        uint256 placeholderStart = findPlaceholderStart(template, currentIndex);
        if (placeholderStart == template.length) {
            break; // No more placeholders found
        }
        count++;
        currentIndex = findPlaceholderEnd(template, placeholderStart);
    }
    return count;
}

function findPlaceholderStart(bytes memory template, uint256 offset) pure returns (uint256) {
    for (uint256 i = offset; i < template.length - 1; i++) {
        if (template[i] == "{") {
            return i;
        }
    }
    return template.length;
}

function findPlaceholderEnd(bytes memory template, uint256 start) pure returns (uint256) {
    for (uint256 i = start + 1; i < template.length; i++) {
        if (template[i] == "}") {
            return i + 1;
        }
    }
    return template.length;
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

function abiDecode(Placeholder[] memory placeholders, bytes memory data) pure returns (string[] memory) {
    string[] memory result = new string[](placeholders.length);
    for (uint256 i = 0; i < placeholders.length; i++) {
        Placeholder memory p = placeholders[i];
        uint256 offset = i * 32;
        string memory value;
        if (p.t == Type.Bool) {
            value = strings.toString(uint256(readWord(data, offset)) == 1);
        } else if (p.t == Type.Uint256) {
            value = strings.toString(uint256(readWord(data, offset)));
        } else if (p.t == Type.Int256) {
            value = strings.toString(int256(uint256(readWord(data, offset))));
        } else if (p.t == Type.Address) {
            value = strings.toString(address(uint160(uint256(readWord(data, offset)))));
        } else if (p.t == Type.Bytes32) {
            value = strings.toString(readWord(data, offset));
        } else if (p.t == Type.Bytes) {
            offset = uint256(readWord(data, offset));
            uint256 len = uint256(readWord(data, offset));
            value = strings.toString(readSlice(data, offset + 32, len));
        } else if (p.t == Type.String) {
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

function format(string memory template, bytes memory args) returns (string memory) {
    Placeholder[] memory placeholders = parseTemplate(template);
    string[] memory decoded = abiDecode(placeholders, args);
    return _format(template, decoded, placeholders);
}

function _format(string memory template, string[] memory decoded, Placeholder[] memory placeholders) pure returns (string memory) {
    uint256 resultLength = bytes(template).length;

    for (uint256 i = 0; i < decoded.length; i++) {
        resultLength += bytes(decoded[i]).length;
    }

    for (uint256 i = 0; i < placeholders.length; i++) {
        Placeholder memory p = placeholders[i];
        resultLength -= p.end - p.start;
    }

    bytes memory result = new bytes(resultLength);

    // Copy template to result, replacing placeholders with decoded values
    uint256 resultIndex = 0;
    uint256 placeholderIndex = 0;
    for (uint256 i = 0; i < bytes(template).length; i++) {
        if (placeholderIndex < placeholders.length && i == placeholders[placeholderIndex].start) {
            // Copy decoded value
            bytes memory decodedValue = bytes(decoded[placeholderIndex]);
            for (uint256 j = 0; j < decodedValue.length; j++) {
                result[resultIndex++] = decodedValue[j];
            }
            i = placeholders[placeholderIndex].end - 1;
            placeholderIndex++;
        } else {
            result[resultIndex++] = bytes(template)[i];
        }
    }

    return string(result);
}
