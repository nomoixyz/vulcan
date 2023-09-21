// SPDX-License-Identifier: MIT
pragma solidity >=0.8.13 <0.9.0;

type Pointer is bytes32;

library LibPointer {
    function asBytes32(Pointer self) internal pure returns (bytes32) {
        return Pointer.unwrap(self);
    }

    function asString(Pointer self) internal pure returns (string memory val) {
        assembly {
            val := self
        }
    }

    function asBytes(Pointer self) internal pure returns (bytes memory val) {
        assembly {
            val := self
        }
    }

    function asBool(Pointer self) internal pure returns (bool val) {
        assembly {
            val := self
        }
    }

    function asUint256(Pointer self) internal pure returns (uint256 val) {
        assembly {
            val := self
        }
    }

    function asInt256(Pointer self) internal pure returns (int256 val) {
        assembly {
            val := self
        }
    }

    function asAddress(Pointer self) internal pure returns (address val) {
        assembly {
            val := self
        }
    }

    function toPointer(bytes32 value) internal pure returns (Pointer ptr) {
        assembly {
            ptr := value
        }
    }

    function toPointer(string memory value) internal pure returns (Pointer ptr) {
        assembly {
            ptr := value
        }
    }

    function toPointer(bytes memory value) internal pure returns (Pointer ptr) {
        assembly {
            ptr := value
        }
    }

    function toPointer(bool value) internal pure returns (Pointer ptr) {
        assembly {
            ptr := value
        }
    }

    function toPointer(uint256 value) internal pure returns (Pointer ptr) {
        assembly {
            ptr := value
        }
    }

    function toPointer(int256 value) internal pure returns (Pointer ptr) {
        assembly {
            ptr := value
        }
    }

    function toPointer(address value) internal pure returns (Pointer ptr) {
        assembly {
            ptr := value
        }
    }
}

using LibPointer for Pointer global;
