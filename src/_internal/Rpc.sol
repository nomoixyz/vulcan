// SPDX-License-Identifier: MIT
pragma solidity >=0.8.13 <0.9.0;

import {vulcan} from "./Vulcan.sol";
import {forksUnsafe, Fork} from "./Forks.sol";
import {JsonObject} from "./Json.sol";

library rpc {
    /// @dev Calls an JSON-RPC method on a specific RPC endpoint. If there was a previous active
    /// fork it will return back to that one once the method is called.
    /// @param url The url of the RPC endpoint to use
    /// @param method The JSON-RPC method to call
    /// @param params The method params as a JSON string
    function call(string memory url, string memory method, string memory params) internal returns (bytes memory data) {
        uint256 currentFork;
        bool hasActiveFork;

        try vulcan.hevm.activeFork() returns (uint256 forkId) {
            currentFork = forkId;
            hasActiveFork = true;
        } catch (bytes memory) {}

        forksUnsafe.create(url).select();

        bytes memory result = call(method, params);

        if (hasActiveFork) {
            vulcan.hevm.selectFork(currentFork);
        }

        return result;
    }

    /// @dev Calls an JSON-RPC method on a specific RPC endpoint. If there was a previous active
    /// fork it will return back to that one once the method is called.
    /// @param url The url of the RPC endpoint to use
    /// @param method The JSON-RPC method to call
    /// @param params The method params as a JsonObject
    function call(string memory url, string memory method, JsonObject memory params)
        internal
        returns (bytes memory data)
    {
        return call(url, method, params.serialized);
    }

    /// @dev Calls an JSON-RPC method on the current active fork
    /// @param method The JSON-RPC method to call
    /// @param params The method params as a JsonObject
    function call(string memory method, JsonObject memory params) internal returns (bytes memory data) {
        return call(method, params.serialized);
    }

    /// @dev Calls an JSON-RPC method on the current active fork
    /// @param method The JSON-RPC method to call
    /// @param params The method params as a JSON string
    function call(string memory method, string memory params) internal returns (bytes memory data) {
        return vulcan.hevm.rpc(method, params);
    }
}
