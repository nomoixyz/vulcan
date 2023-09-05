// SPDX-License-Identifier: MIT
pragma solidity >=0.8.13 <0.9.0;

function removeSelector(bytes memory data) pure returns (bytes memory) {
    require(data.length >= 4, "Input data is too short");

    // Create a new bytes variable to store the result
    bytes memory result = new bytes(data.length - 4);

    // Copy the remaining data (excluding the first 4 bytes) into the result
    for (uint256 i = 4; i < data.length; i++) {
        result[i - 4] = data[i];
    }

    return result;
}
