// SPDX-License-Identifier: MIT
pragma solidity >=0.8.13 <0.9.0;

import {strings} from "./Strings.sol";
import {formatError} from "./Utils.sol";

struct Semver {
    uint256 major;
    uint256 minor;
    uint256 patch;
}

library semver {
    using strings for uint256;
    using strings for string;

    function create(uint256 major, uint256 minor, uint256 patch) internal pure returns (Semver memory) {
        return Semver(major, minor, patch);
    }

    function create(uint256 major, uint256 minor) internal pure returns (Semver memory) {
        return create(major, minor, 0);
    }

    function create(uint256 major) internal pure returns (Semver memory) {
        return create(major, 0, 0);
    }

    function parse(string memory input) internal pure returns (Semver memory) {
        bytes memory inputBytes = bytes(input);

        if (inputBytes.length > 0 && inputBytes[0] == bytes1("v")) {
            input = _substring(input, 1, inputBytes.length);
        }

        string[] memory parts = _split(input, ".");

        require(parts.length == 3, _formatError("create(string)", "Invalid Semver format"));

        return Semver(parts[0].parseUint(), parts[1].parseUint(), parts[2].parseUint());
    }

    function toString(Semver memory self) internal pure returns (string memory) {
        return string.concat(self.major.toString(), ".", self.minor.toString(), ".", self.patch.toString());
    }

    function equals(Semver memory self, Semver memory other) internal pure returns (bool) {
        return self.major == other.major && self.minor == other.minor && self.patch == other.patch;
    }

    function greaterThan(Semver memory self, Semver memory other) internal pure returns (bool) {
        return (self.major > other.major || self.minor > other.minor || self.patch > other.patch);
    }

    function greaterThanOrEqual(Semver memory self, Semver memory other) internal pure returns (bool) {
        return equals(self, other) || greaterThan(self, other);
    }

    function lessThan(Semver memory self, Semver memory other) internal pure returns (bool) {
        return !greaterThanOrEqual(self, other);
    }

    function lessThanOrEqual(Semver memory self, Semver memory other) internal pure returns (bool) {
        return !greaterThan(self, other);
    }

    function _split(string memory input, string memory delimiter) private pure returns (string[] memory) {
        bytes memory inputBytes = bytes(input);
        bytes memory delimiterBytes = bytes(delimiter);

        uint256 partsCount = 1;

        for (uint256 i = 0; i < inputBytes.length; i++) {
            if (inputBytes[i] == delimiterBytes[0]) {
                partsCount++;
            }
        }

        string[] memory parts = new string[](partsCount);

        uint256 partIndex = 0;
        uint256 startIndex = 0;

        for (uint256 i = 0; i < inputBytes.length; i++) {
            if (inputBytes[i] == delimiterBytes[0]) {
                parts[partIndex] = _substring(input, startIndex, i);
                startIndex = i + 1;
                partIndex++;
            }
        }

        parts[partIndex] = _substring(input, startIndex, inputBytes.length);

        return parts;
    }

    function _substring(string memory input, uint256 startIndex, uint256 endIndex)
        private
        pure
        returns (string memory)
    {
        bytes memory inputBytes = bytes(input);
        require(
            startIndex < inputBytes.length, _formatError("_substring(uint256,uint256,uint256)", "Invalid start index")
        );
        require(endIndex <= inputBytes.length, _formatError("_substring(uint256,uint256,uint256)", "Invalid end index"));

        bytes memory result = new bytes(endIndex - startIndex);
        for (uint256 i = startIndex; i < endIndex; i++) {
            result[i - startIndex] = inputBytes[i];
        }

        return string(result);
    }

    function _formatError(string memory func, string memory message) private pure returns (string memory) {
        return formatError("semver", func, message);
    }
}

using semver for Semver global;
