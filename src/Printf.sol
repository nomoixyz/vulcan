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
    bytes mod;
}

bytes32 constant ADDRESS_HASH = keccak256(bytes("address"));
bytes32 constant BYTES32_HASH = keccak256(bytes("bytes32"));
bytes32 constant STRING_HASH = keccak256(bytes("string"));
bytes32 constant BYTES_HASH = keccak256(bytes("bytes"));
bytes32 constant UINT_HASH = keccak256(bytes("uint"));
bytes32 constant BOOL_HASH = keccak256(bytes("bool"));
bytes32 constant INT_HASH = keccak256(bytes("int"));

function parseTemplate(string memory template) view returns (Placeholder[] memory) {
    bytes memory templateBytes = bytes(template);

    Placeholder[] memory placeholders = new Placeholder[](countPlaceholders(templateBytes));

    if (placeholders.length == 0) {
        return placeholders;
    }

    uint256 currentIndex = 0;

    for (uint256 i; i < placeholders.length; i++) {
        placeholders[i] = findPlaceholder(templateBytes, currentIndex);
        currentIndex = placeholders[i].end;
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

function findModifierStart(bytes memory template, uint256 start, uint256 end) pure returns (uint256) {
    for (uint256 i = start + 1; i < end - 1; i++) {
        if (template[i] == ":") {
            return i + 1;
        }
    }

    return end;
}


function findPlaceholder(bytes memory template, uint256 start) view returns (Placeholder memory) {
        uint256 placeholderStart = findPlaceholderStart(template, start);

        uint256 placeholderEnd = findPlaceholderEnd(template, placeholderStart);

        uint256 modifierStart = findModifierStart(template, placeholderStart, placeholderEnd);

        bytes32 typeHash = keccak256(readSlice(template, placeholderStart + 1, modifierStart - placeholderStart - 2));

        Type t;
        if (typeHash == UINT_HASH) {
            t = Type.Uint256;
        } else if (typeHash == ADDRESS_HASH) {
            t = Type.Address;
        } else if (typeHash == BOOL_HASH) {
            t = Type.Bool;
        } else if (typeHash == STRING_HASH) {
            t = Type.String;
        } else if (typeHash == INT_HASH) {
            t = Type.Int256;
        } else if (typeHash == BYTES_HASH) {
            t = Type.Bytes;
        } else if (typeHash == BYTES32_HASH) {
            t = Type.Bytes32;
        } else {
            revert("Unsupported placeholder type");
        }


        bytes memory mod = modifierStart == placeholderEnd ? new bytes(0) : readSlice(template, modifierStart, placeholderEnd - modifierStart - 1);
        return Placeholder(placeholderStart, placeholderEnd, t, mod);
}

function readWord(bytes memory data, uint256 offset) pure returns (bytes32) {
    bytes32 result;

    assembly {
        result := mload(add(add(data, 0x20), offset))
    }

    return result;
}

function readSlice(bytes memory data, uint256 start, uint256 len) pure returns (bytes memory) {
    if (len == 0) {
        return new bytes(0);
    }

    require(start + len <= data.length, "Slice out of bounds");

    bytes memory result = new bytes(len);

    for (uint256 i = 0; i < len; i++) {
        result[i] = data[start + i];
    }

    return result;
}

// @dev Performs abi decoding of the given data using the given placeholders.
function decodeArgs(Placeholder[] memory placeholders, bytes memory data) pure returns (string[] memory) {
    string[] memory result = new string[](placeholders.length);
    for (uint256 i = 0; i < placeholders.length; i++) {
        Placeholder memory p = placeholders[i];
        uint256 offset = i * 32;
        string memory value;
        if (p.t == Type.Bool) {
            value = strings.toString(uint256(readWord(data, offset)) == 1);
        } else if (p.t == Type.Uint256) {
            value = display(uint256(readWord(data, offset)), p.mod);
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

// Note: create other display functions for different types if necessary
function display(uint256 value, bytes memory mod) pure returns (string memory) {
    if (mod.length == 0) {
        return strings.toString(value);
    } else if (mod[0] == "d" && mod.length <= 4) { // Max decimals is 256
        uint8 decimals = uint8(strings.parseUint(string(readSlice(mod, 1, mod.length - 1))));
        string memory integer = strings.toString(value / 10 ** decimals);

        // Get decimal part and remove trailing zeroes
        string memory decimal = strings.toString(value % 10 ** decimals);
        uint256 trailing = 0;
        for (uint256 i = bytes(decimal).length - 1; i > 0; i--) {
            if (bytes(decimal)[i] == "0") {
                trailing++;
            } else {
                break;
            }
        }

        // Set new length to remove trailing zeroes
        assembly {
            mstore(decimal, sub(mload(decimal), trailing))
        }

        return string.concat(integer, ".", decimal);
    } else {
        revert("Unsupported modifier");
    }
}

function format(string memory template, bytes memory args) view returns (string memory) {
    Placeholder[] memory placeholders = parseTemplate(template);
    string[] memory decoded = decodeArgs(placeholders, args);
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
