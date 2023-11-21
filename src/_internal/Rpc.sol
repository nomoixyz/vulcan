// SPDX-License-Identifier: MIT
pragma solidity >=0.8.13 <0.9.0;

import {vulcan} from "./Vulcan.sol";
import {JsonObject} from "./Json.sol";

library rpc {
    function call(string memory method, JsonObject memory params) internal returns (bytes memory data) {
        return call(method, params.serialized);
    }

    function call(string memory method, string memory params) internal returns (bytes memory data) {
        return vulcan.hevm.rpc(method, params);
    }
}

