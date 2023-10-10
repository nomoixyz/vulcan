# Testing

Vulcan provides a simple testing framework through the base `Test` contract and the `expect` function.

```solidity
import { Test, expect } from "vulcan/test.sol";

contract ExampleTest is Test {
    function test_something() external {
        uint256 value = 1;
        expect(value).toEqual(1);
        expect(value).not.toEqual(2);
        expect(value).toBeLessThan(2);
        expect("Hello World!").toContain("World");
    }
}
```

# Invariant testing

In addition to the basic testing framework, Vulcan also provides utilities to facilitate the use of Foundry's invariant testing. These functions are provided through the `invariants` module.

```solidity
import { Test, invariants, accounts } from "vulcan/test.sol";

contract ExampleTest is Test {
    function setUp() external {
        // { Bootstrap invariant testing scenario }

        invariants.excludeContract(myContract);

        // Use 10 different senders
        invariants.targetSenders(accounts.createMany(10));
    }

    function invariant_checkSomething() external {
        //...
    }
}
```
