# Testing

Vulcan provides a simple testing framework through the base `Test` contract and the `expect` function.

```solidity
import { Test, expect } from "vulcan/test.sol";

contract ExampleTest is Test {
    function testSomething() external {
        uint256 value = 1;
        expect(value).toEqual(1);
        expect(value).not.toEqual(2);
        expect(value).toBeLessThan(2);
        expect("Hello World!).toContain("World");
    }
}
```
