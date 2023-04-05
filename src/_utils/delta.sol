// SPDX-License-Identifier: MIT
pragma solidity >=0.8.13 <0.9.0;

import {abs} from "./abs.sol";

function delta(uint256 a, uint256 b) pure returns (uint256) {
    return a > b ? a - b : b - a;
}

// Adapted from forge-std stdMath https://github.com/foundry-rs/forge-std/blob/c2236853aadb8e2d9909bbecdc490099519b70a4/src/StdMath.sol#L20
function delta(int256 a, int256 b) pure returns (uint256) {
    uint256 absA = abs(a);
    uint256 absB = abs(b);

    // Same sign
    if ((a ^ b) > -1) {
        return delta(absA, absB);
    } else {
        return absA + absB;
    }
}
