// SPDX-License-Identifier: MIT
pragma solidity >=0.8.13 <0.9.0;

import {fmt} from "./Fmt.sol";

uint256 constant UINT256_MAX = type(uint256).max;
uint256 constant INT256_MIN_ABS = uint256(type(int256).max) + 1;

// Extracted from forge-std stdUtils: https://github.com/foundry-rs/forge-std/blob/7b4876e8de2a232a54159035f173e35421000c19/src/StdUtils.sol
// The main difference is that we use file-level functions instead of an abstract contract.
function bound(uint256 x, uint256 min, uint256 max) pure returns (uint256 result) {
    require(min <= max, formatError("_utils", "bound(uint256,uint256,uint256)", "Max is less than min."));
    // If x is between min and max, return x directly. This is to ensure that dictionary values
    // do not get shifted if the min is nonzero. More info: https://github.com/foundry-rs/forge-std/issues/188
    if (x >= min && x <= max) return x;

    uint256 size = max - min + 1;

    // If the value is 0, 1, 2, 3, wrap that to min, min+1, min+2, min+3. Similarly for the UINT256_MAX side.
    // This helps ensure coverage of the min/max values.
    if (x <= 3 && size > x) return min + x;
    if (x >= UINT256_MAX - 3 && size > UINT256_MAX - x) return max - (UINT256_MAX - x);

    // Otherwise, wrap x into the range [min, max], i.e. the range is inclusive.
    if (x > max) {
        uint256 diff = x - max;
        uint256 rem = diff % size;
        if (rem == 0) return max;
        result = min + rem - 1;
    } else if (x < min) {
        uint256 diff = min - x;
        uint256 rem = diff % size;
        if (rem == 0) return min;
        result = max - rem + 1;
    }
}

function bound(int256 x, int256 min, int256 max) pure returns (int256 result) {
    require(min <= max, formatError("_utils", "bound(int256,int256,int256)", "Max is less than min."));

    // Shifting all int256 values to uint256 to use _bound function. The range of two types are:
    // int256 : -(2**255) ~ (2**255 - 1)
    // uint256:     0     ~ (2**256 - 1)
    // So, add 2**255, INT256_MIN_ABS to the integer values.
    //
    // If the given integer value is -2**255, we cannot use `-uint256(-x)` because of the overflow.
    // So, use `~uint256(x) + 1` instead.
    uint256 _x = x < 0 ? (INT256_MIN_ABS - ~uint256(x) - 1) : (uint256(x) + INT256_MIN_ABS);
    uint256 _min = min < 0 ? (INT256_MIN_ABS - ~uint256(min) - 1) : (uint256(min) + INT256_MIN_ABS);
    uint256 _max = max < 0 ? (INT256_MIN_ABS - ~uint256(max) - 1) : (uint256(max) + INT256_MIN_ABS);

    uint256 y = bound(_x, _min, _max);

    // To move it back to int256 value, subtract INT256_MIN_ABS at here.
    result = y < INT256_MIN_ABS ? int256(~(INT256_MIN_ABS - y) + 1) : int256(y - INT256_MIN_ABS);
}

// Adapted from forge-std stdMath https://github.com/foundry-rs/forge-std/blob/c2236853aadb8e2d9909bbecdc490099519b70a4/src/StdMath.sol#L7
function abs(int256 a) pure returns (uint256) {
    if (a == type(int256).min) {
        return uint256(type(int256).max) + 1;
    }

    return uint256(a > 0 ? a : -a);
}

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

function format(string memory template, bytes memory args) pure returns (string memory) {
    return fmt.format(template, args);
}

function formatError(string memory module, string memory func, string memory message) pure returns (string memory) {
    return string.concat("vulcan.", module, ".", func, ": ", message);
}

function println(string memory template, bytes memory args) view {
    rawConsoleLog(fmt.format(template, args));
}

function println(string memory arg) view {
    rawConsoleLog(arg);
}

function rawConsoleLog(string memory arg) view {
    address console2Addr = 0x000000000000000000636F6e736F6c652e6c6f67;
    (bool status,) = console2Addr.staticcall(abi.encodeWithSignature("log(string)", arg));
    status;
}

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
