<h1 align=center>
    Vulcan
</h1>

Development framework for Foundry projects, with a focus on developer experience and readability.

Built on top of [`forge-std`](https://github.com/foundry-rs/forge-std) :heart:

Initially, Vulcan will provide functionality similar to what is already included in forge's VM and `forge-std`.

Over time, Vulcan will grow to include more functionality and utilities, eventually becoming a feature-rich development framework.

## Installation

```
$ forge install nomoixyz/vulcan@v0.3.0
```

## Usage

See the [Vulcan Book](https://nomoixyz.github.io/vulcan/) for detailed usage information.

## Why Vulcan?

Our goal is to provide:

- Better naming for VM functionality (no more `prank`, `roll`, `warp`, ...)
- A testing framework with better readability and a familiar syntax
- Improved ergonomics
- [Huff language](https://huff.sh/) support out of the box

Vulcan test example:

```solidity
import { Test, expect, accounts, any, commands, Command,  watchers, println } from "vulcan/test.sol";

contract TestSomething is Test {
    using accounts for *;
    using watchers for *;

    function testSomething() external {
        // Format strings with rust-like syntax
        println("Hello {s}", abi.encode("world!")); // Hello world!
        println("Balance: {u:d18}", abi.encode(1e17)); // Balance: 0.1

        // Create an address from a string, set the ETH balance and impersonate calls
        address alice = accounts.create("Alice").setBalance(123).impersonate();

        // Expect style assertions!
        expect(true).toBeTrue();
        expect("Hello world!").toContain("Hello");

        // Nice external command API!
        Command memory ping = commands.create("ping").args(["-c", "1"]);
        res = ping.arg("etherscan.io").run();
        res = ping.arg("arbiscan.io").run();

        // Monitor calls and events!
        MyContract mc = new MyContract();
        address(mc).watch().captureReverts(); // Watch calls and record their execution
        mc.doSomething();

        expect(address(mc).lastCall()).toHaveRevertedWith("Something went wrong");

        mc.doSomethingElse();

        // Check event emissions
        expect(address(mc).lastCall()).toHaveEmitted(
            "SomeEvent(address,bytes32,uint256)",
            [address(1).topic(), any()], // Event topics
            abi.encode(123) // Event data
        );

        // And much more!
    }
}
```

## Planned Features

- Mocking framework
- Deployment management framework

## Contributing

At this stage we are looking for all kinds of feedback, as the general direction of the project is not fully defined yet. If you have any ideas to improve naming, ergonomics, or anything else, please open an issue or a PR.

## Acknowledgments

Some of the ideas and code in Vulcan are directly inspired by or adapted from the following projects:

- [forge-std](https://github.com/foundry-rs/forge-std/)
- [memester-xyz/surl](https://github.com/memester-xyz/surl)
