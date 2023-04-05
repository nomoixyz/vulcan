// SPDX-License-Identifier: MIT
pragma solidity >=0.8.13 <0.9.0;

// Adapted from forge-std stdMath https://github.com/foundry-rs/forge-std/blob/c2236853aadb8e2d9909bbecdc490099519b70a4/src/StdMath.sol#L7
function abs(int256 a) pure returns (uint256) {
    if (a == type(int256).min) {
        return uint256(type(int256).max) + 1;
    }

    return uint256(a > 0 ? a : -a);
}

