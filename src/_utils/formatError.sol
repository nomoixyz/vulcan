// SPDX-License-Identifier: MIT
pragma solidity >=0.8.13 <0.9.0;

function formatError(string memory module, string memory func, string memory message) pure returns (string memory) {
    return string.concat("vulcan.", module, ".", func, ": ", message);
}
