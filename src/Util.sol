pragma solidity >=0.8.13 <0.9.0;

// @dev Internal utilities
library util {
    // Adapted from forge-std stdMath https://github.com/foundry-rs/forge-std/blob/c2236853aadb8e2d9909bbecdc490099519b70a4/src/StdMath.sol#L7
    function abs(int256 a) internal pure returns (uint256) {
        if (a == type(int256).min) {
            return uint256(type(int256).max) + 1;
        }

        return uint256(a > 0 ? a : -a);
    }

    function delta(uint256 a, uint256 b) internal pure returns (uint256) {
        return a > b ? a - b : b - a;
    }

    // Adapted from forge-std stdMath https://github.com/foundry-rs/forge-std/blob/c2236853aadb8e2d9909bbecdc490099519b70a4/src/StdMath.sol#L20
    function delta(int256 a, int256 b) internal pure returns (uint256) {
        uint256 absA = abs(a);
        uint256 absB = abs(b);

        // Same sign
        if ((a ^ b) > -1) {
            return delta(absA, absB);
        } else {
            return absA + absB;
        }
    }
}
