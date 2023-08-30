// SPDX-License-Identifier: MIT
pragma solidity >=0.8.13 <0.9.0;

import {JsonObject} from "../_modules/Json.sol";
import {Error} from "./Error.sol";

struct JsonResult {
    JsonObject value;
    Error _error;
}

library JsonResultLib {
    /// @dev Checks if a `JsonResult` is not an error.
    function isOk(JsonResult memory self) internal pure returns (bool) {
        return self._error.id == bytes32(0);
    }

    /// @dev Checks if a `JsonResult` struct is an error.
    function isError(JsonResult memory self) internal pure returns (bool) {
        return !self.isOk();
    }

    /// @dev Returns the output of a `JsonResult` or reverts if the result was an error.
    function unwrap(JsonResult memory self) internal pure returns (JsonObject memory) {
        return expect(self, self._error.message);
    }

    /// @dev Returns the output of a `JsonResult` or reverts if the result was an error.
    /// @param error The error message that will be used when reverting.
    function expect(JsonResult memory self, string memory error) internal pure returns (JsonObject memory) {
        if (self.isError()) {
            revert(error);
        }

        return self.value;
    }
}

using JsonResultLib for JsonResult global;
