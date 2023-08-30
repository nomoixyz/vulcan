// SPDX-License-Identifier: MIT
pragma solidity >=0.8.13 <0.9.0;

import {Error} from "./Error.sol";
import {Response} from "../_modules/Request.sol";

struct ResponseResult {
    Response value;
    Error _error;
}

library ResponseResultLib {
    /// @dev Checks if a `StringResult` is not an error.
    function isOk(ResponseResult memory self) internal pure returns (bool) {
        return self._error.id == bytes32(0);
    }

    /// @dev Checks if a `StringResult` struct is an error.
    function isError(ResponseResult memory self) internal pure returns (bool) {
        return !self.isOk();
    }

    /// @dev Returns the output of a `StringResult` or reverts if the result was an error.
    function unwrap(ResponseResult memory self) internal pure returns (Response memory) {
        return expect(self, self._error.message);
    }

    /// @dev Returns the output of a `StringResult` or reverts if the result was an error.
    /// @param error The error message that will be used when reverting.
    function expect(ResponseResult memory self, string memory error) internal pure returns (Response memory) {
        if (self.isError()) {
            revert(error);
        }

        return self.value;
    }
}

using ResponseResultLib for ResponseResult global;
