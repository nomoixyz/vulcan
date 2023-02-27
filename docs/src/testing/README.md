# Testing

```solidity
import { Test, expect } from "vulcan";

contract ExampleTest is Test {

    function before() internal override {
        // Do something only once
    }

    function beforeEach() internal override {
        // Do something before each test
    }

    function testSomething() external {
        expect(1).toBeLessThan(2);
        expect(1).not.toEqual(2);
        expect(1).toEqual(1);
    }
}
```