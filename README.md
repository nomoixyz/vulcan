<h1 align=center>
    Vulcan
</h1>

Development framework for Foundry projects, with a focus on developer experience and readability.

Built on top of [`forge-std`](https://github.com/foundry-rs/forge-std) :heart:

Initially, Vulcan will provide functionality similar to what is already included in forge's VM and `forge-std`.

Over time, Vulcan will grow to include more functionality and utilities, eventually becoming a feature-rich development framework.

> **Warning**
> This library should be treated as highly experimental, its API WILL change, and there might be bugs in it. Don't use in production yet.

## Installation

```
$ forge install nomoixyz/vulcan@alpha-1
```

## Usage

See the [Vulcan Book](https://nomoixyz.github.io/vulcan/) for detailed usage information.

## Why Vulcan?

Our goal is to provide:
- Better naming for VM functionality (no more `prank`, `roll`, `warp`, ...)
- A testing framework with better readability and a familiar syntax
- Improved ergonomics
- ...

Vulcan test example:

```solidity
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

## Planned Features

- [Huff language](https://huff.sh/) support out of the box
- Mocking framework
- Deployment management framework

## Contributing

At this stage we are looking for all kinds of feedback, as the general direction of the project is not fully defined yet. If you have any ideas to improve naming, ergonomics, or anything else, please open an issue or a PR.
