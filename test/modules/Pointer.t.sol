// SPDX-License-Identifier: MIT
pragma solidity >=0.8.13 <0.9.0;

import {Test, expect} from "src/test.sol";
import {Pointer} from "src/_internal/Pointer.sol";

contract PointerTest is Test {
    function testAsBytes32(bytes32 value) external {
        Pointer ptr;

        assembly {
            ptr := value
        }

        expect(ptr.asBytes32()).toEqual(value);
    }

    function testAsString(string memory value) external {
        Pointer ptr;

        assembly {
            ptr := value
        }

        expect(ptr.asString()).toEqual(value);
    }
}
