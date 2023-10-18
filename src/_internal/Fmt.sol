// SPDX-License-Identifier: MIT
pragma solidity >=0.8.13 <0.9.0;

import "./Strings.sol";
import {formatError} from "./Utils.sol";

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

library fmt {
    bytes32 constant ADDRESS_HASH = keccak256(bytes("address"));
    bytes32 constant ABBREVIATED_ADDRESS_HASH = keccak256(bytes("a"));
    bytes32 constant BYTES32_HASH = keccak256(bytes("bytes32"));
    bytes32 constant ABBREVIATED_BYTES32_HASH = keccak256(bytes("b32"));
    bytes32 constant STRING_HASH = keccak256(bytes("string"));
    bytes32 constant ABBREVIATED_STRING_HASH = keccak256(bytes("s"));
    bytes32 constant BYTES_HASH = keccak256(bytes("bytes"));
    bytes32 constant ABBREVIATED_BYTES_HASH = keccak256(bytes("b"));
    bytes32 constant UINT_HASH = keccak256(bytes("uint"));
    bytes32 constant ABBREVIATED_UINT_HASH = keccak256(bytes("u"));
    bytes32 constant INT_HASH = keccak256(bytes("int"));
    bytes32 constant ABBREVIATED_INT_HASH = keccak256(bytes("i"));
    bytes32 constant BOOL_HASH = keccak256(bytes("bool"));

    function format(string memory template, bytes memory args) internal pure returns (string memory) {
        Placeholder[] memory placeholders = _parseTemplate(template);
        string[] memory decoded = _decodeArgs(placeholders, args);
        return _format(template, decoded, placeholders);
    }

    function _parseTemplate(string memory template) private pure returns (Placeholder[] memory) {
        bytes memory templateBytes = bytes(template);

        Placeholder[] memory placeholders = new Placeholder[](_countPlaceholders(templateBytes));

        if (placeholders.length == 0) {
            return placeholders;
        }

        uint256 currentIndex = 0;

        for (uint256 i; i < placeholders.length; i++) {
            placeholders[i] = _findPlaceholder(templateBytes, currentIndex);
            currentIndex = placeholders[i].end;
        }

        return placeholders;
    }

    function _countPlaceholders(bytes memory template) private pure returns (uint256) {
        uint256 count = 0;
        uint256 currentIndex = 0;
        while (true) {
            uint256 placeholderStart = _findPlaceholderStart(template, currentIndex);
            if (placeholderStart == template.length) {
                break; // No more placeholders found
            }
            count++;
            currentIndex = _findPlaceholderEnd(template, placeholderStart);
        }
        return count;
    }

    function _findPlaceholderStart(bytes memory template, uint256 offset) private pure returns (uint256) {
        for (uint256 i = offset; i < template.length - 1; i++) {
            if (template[i] == "{") {
                return i;
            }
        }
        return template.length;
    }

    function _findPlaceholderEnd(bytes memory template, uint256 start) private pure returns (uint256) {
        for (uint256 i = start + 1; i < template.length; i++) {
            if (template[i] == "}") {
                return i + 1;
            }
        }
        return template.length;
    }

    function _findModifierStart(bytes memory template, uint256 start, uint256 end) private pure returns (uint256) {
        for (uint256 i = start + 1; i < end - 1; i++) {
            if (template[i] == ":") {
                return i + 1;
            }
        }

        return end;
    }

    function _findPlaceholder(bytes memory template, uint256 start) private pure returns (Placeholder memory) {
        uint256 placeholderStart = _findPlaceholderStart(template, start);

        uint256 placeholderEnd = _findPlaceholderEnd(template, placeholderStart);

        uint256 modifierStart = _findModifierStart(template, placeholderStart, placeholderEnd);

        bytes32 typeHash = keccak256(_readSlice(template, placeholderStart + 1, modifierStart - placeholderStart - 2));

        Type t;
        if (typeHash == UINT_HASH || typeHash == ABBREVIATED_UINT_HASH) {
            t = Type.Uint256;
        } else if (typeHash == ADDRESS_HASH || typeHash == ABBREVIATED_ADDRESS_HASH) {
            t = Type.Address;
        } else if (typeHash == BOOL_HASH) {
            t = Type.Bool;
        } else if (typeHash == STRING_HASH || typeHash == ABBREVIATED_STRING_HASH) {
            t = Type.String;
        } else if (typeHash == INT_HASH || typeHash == ABBREVIATED_INT_HASH) {
            t = Type.Int256;
        } else if (typeHash == BYTES_HASH || typeHash == ABBREVIATED_BYTES_HASH) {
            t = Type.Bytes;
        } else if (typeHash == BYTES32_HASH || typeHash == ABBREVIATED_BYTES32_HASH) {
            t = Type.Bytes32;
        } else {
            revert(_formatError("_findPlaceholder(bytes,uint256)", "Unsupported placeholder type"));
        }

        bytes memory mod = modifierStart == placeholderEnd
            ? new bytes(0)
            : _readSlice(template, modifierStart, placeholderEnd - modifierStart - 1);
        return Placeholder(placeholderStart, placeholderEnd, t, mod);
    }

    function _readWord(bytes memory data, uint256 offset) private pure returns (bytes32) {
        bytes32 result;

        assembly {
            result := mload(add(add(data, 0x20), offset))
        }

        return result;
    }

    function _readSlice(bytes memory data, uint256 start, uint256 len) private pure returns (bytes memory) {
        if (len == 0) {
            return new bytes(0);
        }

        require(start + len <= data.length, _formatError("_readSlice(bytes,uint256,uint256)", "Slice out of bounds"));

        bytes memory result = new bytes(len);

        for (uint256 i = 0; i < len; i++) {
            result[i] = data[start + i];
        }

        return result;
    }

    // @dev Performs abi decoding of the given data using the given placeholders.
    function _decodeArgs(Placeholder[] memory placeholders, bytes memory data) private pure returns (string[] memory) {
        string[] memory result = new string[](placeholders.length);
        for (uint256 i = 0; i < placeholders.length; i++) {
            Placeholder memory p = placeholders[i];
            uint256 offset = i * 32;
            string memory value;
            if (p.t == Type.Bool) {
                value = strings.toString(uint256(_readWord(data, offset)) == 1);
            } else if (p.t == Type.Uint256) {
                value = _display(uint256(_readWord(data, offset)), p.mod);
            } else if (p.t == Type.Int256) {
                value = strings.toString(int256(uint256(_readWord(data, offset))));
            } else if (p.t == Type.Address) {
                value = strings.toString(address(uint160(uint256(_readWord(data, offset)))));
            } else if (p.t == Type.Bytes32) {
                value = strings.toString(_readWord(data, offset));
            } else if (p.t == Type.Bytes) {
                offset = uint256(_readWord(data, offset));
                uint256 len = uint256(_readWord(data, offset));
                value = strings.toString(_readSlice(data, offset + 32, len));
            } else if (p.t == Type.String) {
                offset = uint256(_readWord(data, offset));
                uint256 len = uint256(_readWord(data, offset));
                value = string(_readSlice(data, offset + 32, len));
            } else {
                revert(_formatError("_decodeArgs(Placeholder[],bytes)", "Unsupported type"));
            }
            result[i] = value;
        }

        return result;
    }

    // Note: create other display functions for different types if necessary
    function _display(uint256 value, bytes memory mod) private pure returns (string memory) {
        if (mod.length == 0) {
            return strings.toString(value);
        } else if (mod[0] == "d" && mod.length <= 4) {
            // Max decimals is 256
            uint8 decimals = uint8(strings.parseUint(string(_readSlice(mod, 1, mod.length - 1))));
            string memory integer = strings.toString(value / 10 ** decimals);

            // Get decimal part and pad with zeroes
            string memory remainder = strings.toString(value % 10 ** decimals);

            while (bytes(remainder).length < decimals) {
                remainder = string.concat("0", remainder);
            }

            // Get expected remainder length without trailing zeroes
            uint256 len = decimals;
            while (len > 1 && bytes(remainder)[len - 1] == "0") {
                len--;
            }

            // Set new length to remove trailing zeroes
            assembly {
                mstore(remainder, len)
            }

            return string.concat(integer, ".", remainder);
        } else {
            revert(_formatError("_display(uint256,bytes)", "Unsupported modifier"));
        }
    }

    function _format(string memory template, string[] memory decoded, Placeholder[] memory placeholders)
        private
        pure
        returns (string memory)
    {
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

    function _formatError(string memory func, string memory message) private pure returns (string memory) {
        return formatError("fmt", func, message);
    }
}
