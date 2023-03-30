// SPDX-License-Identifier: MIT
pragma solidity >=0.8.13 <0.9.0;

import {strings} from "./Strings.sol";
import {console} from "./Console.sol";

struct Logger {
    string format;
    string[] values;
}

library logger {
    using strings for *;

    function printf(string memory format) internal pure returns (Logger memory) {
        string[] memory values;
        return Logger(format, values);
    }

    function with(Logger memory self, string memory value) internal pure returns (Logger memory) {
        return _with(self, value);
    }

    function with(Logger memory self, uint256 value) internal pure returns (Logger memory) {
        return _with(self, value.toString());
    }

    function with(Logger memory self, int256 value) internal pure returns (Logger memory) {
        return _with(self, value.toString());
    }

    function with(Logger memory self, bytes32 value) internal pure returns (Logger memory) {
        return _with(self, value.toString());
    }

    function with(Logger memory self, bool value) internal pure returns (Logger memory) {
        return _with(self, value.toString());
    }

    function with(Logger memory self, bytes memory value) internal pure returns (Logger memory) {
        return _with(self, value.toString());
    }

    function with(Logger memory self, address value) internal pure returns (Logger memory) {
        return _with(self, value.toString());
    }

    function log(Logger memory self) public view {
        bytes memory result;

        uint argIndex = 0;
        uint offset = 0;

        while (offset < bytes(self.format).length) {
            uint placeholderStart = _findPlaceholderStart(bytes(self.format), offset);

            if (placeholderStart == bytes(self.format).length) {
                break; // No more placeholders found
            }

            uint placeholderEnd = _findPlaceholderEnd(bytes(self.format), placeholderStart);

            require(argIndex < self.values.length, "Not enough replacement arguments");

            result = _concatenate(result, bytes(self.format), offset, placeholderStart);
            result = _concatenate(result, bytes(self.values[argIndex]));

            offset = placeholderEnd;

            argIndex++;
        }
        require(argIndex == self.values.length, "Too many replacement arguments");
        result = _concatenate(result, bytes(self.format), offset, bytes(self.format).length);

        console.logString(string(result));
    }

    function _findPlaceholderStart(bytes memory format, uint offset) private pure returns (uint) {
        for (uint i = offset; i < format.length - 1; i++) {
            if (format[i] == bytes("{}")[0] && format[i+1] == bytes("{}")[1]) {
                return i;
            }
        }
        return format.length;
    }

    function _findPlaceholderEnd(bytes memory format, uint start) private pure returns (uint) {
        for (uint i = start + 2; i < format.length; i++) {
            if (format[i] != bytes("{}")[1]) {
                return i;
            }
        }
        return format.length;
    }

    function _concatenate(bytes memory a, bytes memory b) private pure returns (bytes memory) {
        return abi.encodePacked(a, b);
    }

    function _concatenate(bytes memory a, bytes memory b, uint start, uint end) private pure returns (bytes memory) {
        bytes memory subset = new bytes(end - start);
        for (uint i = 0; i < end - start; i++) {
            subset[i] = b[i + start];
        }
        return _concatenate(a, subset);
    }

    function _with(Logger memory self, string memory value) private pure returns (Logger memory) {
        uint256 length = self.values.length;

        string[] memory newValues = new string[](length + 1);

        for (uint256 i; i < length; ++i) {
            newValues[i] = self.values[i];
        }

        newValues[length] = value;

        self.values = newValues;

        return self;
    }
}

using logger for Logger global;
