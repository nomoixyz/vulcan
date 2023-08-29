// SPDX-License-Identifier: MIT
pragma solidity >=0.8.13 <0.9.0;

import {Error} from "./Error.sol";

struct StringResult {
    string value;
    Error _error;
}

library StringResultLib {
    /// @dev Checks if a `StringResult` is not an error.
    function isOk(StringResult memory self) internal pure returns (bool) {
        return self._error.id != bytes32(0);
    }

    /// @dev Checks if a `StringResult` struct is an error.
    function isError(StringResult memory self) internal pure returns (bool) {
        return !self.isOk();
    }

    /// @dev Returns the output of a `StringResult` or reverts if the result was an error.
    function unwrap(StringResult memory self) internal pure returns (string memory) {
        return expect(self, self._error.message);
    }

    /// @dev Returns the output of a `StringResult` or reverts if the result was an error.
    /// @param error The error message that will be used when reverting.
    function expect(StringResult memory self, string memory error) internal pure returns (string memory) {
        if (self.isError()) {
            revert(error);
        }

        return self.value;
    }
}

using StringResultLib for StringResult global;
