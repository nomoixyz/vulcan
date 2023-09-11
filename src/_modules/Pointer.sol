// SPDX-License-Identifier: MIT
pragma solidity >=0.8.13 <0.9.0;

type Pointer is bytes32;

library LibPointer {
    function asBytes32(Pointer self) internal pure returns (bytes32) {
        return Pointer.unwrap(self);
    }

    function asString(Pointer self) internal pure returns (string memory val) {
        bytes32 memoryAddr = self.asBytes32();

        assembly {
            val := memoryAddr
        }
    }

    function asBytes(Pointer self) internal pure returns (bytes memory val) {
        bytes32 memoryAddr = self.asBytes32();

        assembly {
            val := memoryAddr
        }
    }

    function asBool(Pointer self) internal pure returns (bool val) {
        bytes32 memoryAddr = self.asBytes32();

        assembly {
            val := memoryAddr
        }
    }

    function asUint256(Pointer self) internal pure returns (uint256 val) {
        bytes32 memoryAddr = self.asBytes32();

        assembly {
            val := memoryAddr
        }
    }
}

using LibPointer for Pointer global;
