# Testing

Vulcan provides a simple testing framework through the base `Test` contract and the `expect` function.

```solidity
import { Test, expect } from "vulcan/test.sol";

contract ExampleTest is Test {
    function testSomething() external {
        expect(1).toBeLessThan(2);
        expect(1).not.toEqual(2);
        expect(1).toEqual(1);
    }
}
```
