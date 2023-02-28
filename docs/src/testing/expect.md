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

The `.not` property allows you invert the result of the assertion.

```solidity
function testSomething() external {
    expect(1).not.toEqual(2);
}
```

# Matchers

## `toEqual(value)`

## `toBeTrue()`

## `toBeFalse()`

## `toBeGreaterThan(value)`

## `toBeGreaterThanOrEqual(value)`

## `toBeLessThan(value)`

## `toBeLessThanOrEqual(value)`

## `toBeAContract()`

## `toBeTheHashOf(value)`

## `toContain(value)`

## `toHaveLength(value)`

## `toBeCloseTo(value, delta)`

## `toHaveReverted()`

## `toHaveRevertedWith(selector|message)`

## `toHaveSucceeded()`

## `toHaveEmitted(topics)`
## `toHaveEmitted(topics, data)`
## `toHaveEmitted(signature, topics, data)`

