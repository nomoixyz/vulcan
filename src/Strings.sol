// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.13 <0.9.0;

import "./Vulcan.sol";

type Strings is bytes32;

library StringsLib {
    function toString(address value) internal pure returns (string memory) {
        return vulcan.hevm.toString(value);
    }
    function toString(bytes memory value) internal pure returns (string memory) {
        return vulcan.hevm.toString(value);
    }

    function toString(bytes32 value) internal pure returns (string memory) {
        return vulcan.hevm.toString(value);
    }
    function toString(bool value) internal pure returns (string memory) {
        return vulcan.hevm.toString(value);
    }
    function toString(uint256 value) internal pure returns (string memory) {
        return vulcan.hevm.toString(value);
    }
    function toString(int256 value) internal pure returns (string memory) {
        return vulcan.hevm.toString(value);
    }
    function parseBytes(string memory value) internal pure returns (bytes memory) {
        return vulcan.hevm.parseBytes(value);
    }
    function parseAddress(string memory value) internal pure returns (address) {
        return vulcan.hevm.parseAddress(value);
    }
    function parseUint(string memory value) internal pure returns (uint256) {
        return vulcan.hevm.parseUint(value);
    }
    function parseInt(string memory value) internal pure returns (int256) {
        return vulcan.hevm.parseInt(value);
    }
    function parseBytes32(string memory value) internal pure returns (bytes32) {
        return vulcan.hevm.parseBytes32(value);
    }
    function parseBool(string memory value) internal pure returns (bool) {
        return vulcan.hevm.parseBool(value);
    }
}

Strings constant strings = Strings.wrap(0);

using StringsLib for Strings global;