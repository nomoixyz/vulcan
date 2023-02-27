<h1 align=center>
    Vulcan
</h1>

<p align=center>
    Development framework for Foundry projects, with a focus on developer experience and readability.
</p>

> **Warning**
> This library should be treated as highly experimental, its API WILL change, and there might be bugs in it. Don't use in production yet.

## Installation

```
$ forge install nomoixyz/vulcan
```

## Usage

See the [Vulcan Book](https://nomoixyz.github.io/vulcan/) for detailed usage information.

## Why Vulcan?

Our goal is to provide:
- Better naming for VM functionality (no more `prank`, `roll`, `warp`, ...)
- Improved ergonomics
- Familiar testing function syntax
- ...

Vulcan test example:

```Solidity
import { Test, expect } from "vulcan/test.sol";

contract TestSomething is Test {

    function testSomething() external {
        expect(true).toBeTrue();
        expect(true).toEqual(true);
        expect(123).toBeGreaterThanOrEqual(123);
        expect(123).not.toEqual(321);
        expect("Hello world!").toContain("Hello");

        MyContract mc = new MyContract();
        address(mc).watch().captureReverts();
        mc.doSomething();

        expect(address(mc).calls[0]).toHaveRevertedWith("Something went wrong");
    }
}
```

## Contributing

At this stage we are looking for all kinds of feedback, as the general direction of the project is not fully defined yet. If you have any ideas to improve naming, ergonomics, or anything else, please open an issue or a PR.
