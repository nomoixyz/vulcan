// SPDX-License-Identifier: MIT
pragma solidity >=0.8.13 <0.9.0;

import {Error} from "./Error.sol";

struct BytesResult {
    bytes value;
    Error _error;
}

library BytesResultLib {
    /// @dev Checks if a `BytesResult` is not an error.
    function isOk(BytesResult memory self) internal pure returns (bool) {
        return self._error.id != bytes32(0);
    }

    /// @dev Checks if a `BytesResult` struct is an error.
    function isError(BytesResult memory self) internal pure returns (bool) {
        return !self.isOk();
    }

    function isError(BytesResult memory self, bytes32 id) internal pure returns (bool) {
        return self._error.id == id;
    }

    /// @dev Returns the output of a `BytesResult` or reverts if the result was an error.
    function unwrap(BytesResult memory self) internal pure returns (bytes memory) {
        return expect(self, self._error.message);
    }

    /// @dev Returns the output of a `BytesResult` or reverts if the result was an error.
    /// @param error The error message that will be used when reverting.
    function expect(BytesResult memory self, string memory error) internal pure returns (bytes memory) {
        if (self.isError()) {
            revert(error);
        }

        return self.value;
    }
}

using BytesResultLib for BytesResult global;
