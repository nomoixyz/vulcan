// SPDX-License-Identifier: MIT
pragma solidity >=0.8.13 <0.9.0;

import {vulcan} from "./Vulcan.sol";
import {forksUnsafe} from "./Forks.sol";

library rpc {
    /// @dev Calls an JSON-RPC method on a specific RPC endpoint. If there was a previous active fork it will return back to that one once the method is called.
    /// @param urlOrName The url or name of the RPC endpoint to use
    /// @param method The JSON-RPC method to call
    /// @param params The method params as a JSON string
    function call(string memory urlOrName, string memory method, string memory params)
        internal
        returns (bytes memory data)
    {
        uint256 currentFork;
        bool hasActiveFork;

        try vulcan.hevm.activeFork() returns (uint256 forkId) {
            currentFork = forkId;
            hasActiveFork = true;
        } catch (bytes memory) {}

        forksUnsafe.create(urlOrName).select();

        bytes memory result = call(method, params);

        if (hasActiveFork) {
            vulcan.hevm.selectFork(currentFork);
        }

        return result;
    }

    /// @dev Calls an JSON-RPC method on the current active fork
    /// @param method The JSON-RPC method to call
    /// @param params The method params as a JSON string
    function call(string memory method, string memory params) internal returns (bytes memory data) {
        return vulcan.hevm.rpc(method, params);
    }
}
