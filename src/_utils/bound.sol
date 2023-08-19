// SPDX-License-Identifier: MIT
pragma solidity >=0.8.13 <0.9.0;

// Extracted from forge-std stdUtils: https://github.com/foundry-rs/forge-std/blob/7b4876e8de2a232a54159035f173e35421000c19/src/StdUtils.sol
// The main difference is that we use file-level functions instead of an abstract contract.

uint256 constant UINT256_MAX = type(uint256).max;
uint256 constant INT256_MIN_ABS = uint256(type(int256).max) + 1;

function bound(uint256 x, uint256 min, uint256 max) pure returns (uint256 result) {
    require(min <= max, "Vulcan bound(uint256,uint256,uint256): Max is less than min.");
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
    require(min <= max, "Vulcan bound(int256,int256,int256): Max is less than min.");

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