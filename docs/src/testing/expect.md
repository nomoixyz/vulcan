# Expect

## `expect(value)`

The `expect` function allows you to assert that a value meets a certain condition through the use of matchers.

```solidity
import { Test, expect } from "vulcan/test.sol";

function testSomething() external {
    expect(1).toEqual(1);
}
```

## `.not`

> Note: `.not` is not yet implemented for all matchers.

The `.not` property inverts the result of the assertion.

```solidity
function testSomething() external {
    expect(1).not.toEqual(2);
}
```

# Matchers

> Note: Matchers are only implemented for basic types for now. Arrays, structs and other types will be supported in the future.

### `toEqual(value)`

### `toBeTrue()`

### `toBeFalse()`

### `toBeGreaterThan(value)`

### `toBeGreaterThanOrEqual(value)`

### `toBeLessThan(value)`

### `toBeLessThanOrEqual(value)`

### `toBeAContract()`

### `toBeTheHashOf(value)`

### `toContain(value)`

### `toHaveLength(value)`

### `toBeCloseTo(value, delta)`

### `toHaveReverted()`

### `toHaveRevertedWith(selector|message)`

### `toHaveSucceeded()`

### `toHaveEmitted(topics)`
### `toHaveEmitted(topics, data)`
### `toHaveEmitted(signature, topics, data)`

