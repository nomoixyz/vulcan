> :warning: **Vulcan is not actively maintained. Thank you for your support.**

<h1 align=center>
    Vulcan
</h1>

![test workflow](https://github.com/nomoixyz/vulcan/actions/workflows/forge.yml/badge.svg)
[![GitHub release](https://img.shields.io/github/v/release/nomoixyz/vulcan?link=https%3A%2F%2Fgithub.com%2Fnomoixyz%2Fvulcan%2Freleases)](https://github.com/nomoixyz/vulcan/releases)
[![Telegram](https://img.shields.io/badge/chat-gray?logo=telegram)](https://t.me/+XYA0By2mKls3OWIx)



Development framework for Foundry projects, with a focus on developer experience and readability.

Built on top of [`forge-std`](https://github.com/foundry-rs/forge-std) :heart:

Initially, Vulcan will provide functionality similar to what is already included in forge's VM and `forge-std`.

Over time, Vulcan will grow to include more functionality and utilities, eventually becoming a feature-rich development framework.

## Installation

Install the latest release by running:

```
$ forge install nomoixyz/vulcan
```

Or install a specific release with:

```
$ forge install nomoixyz/vulcan@x.y.z
```

Release tags can be found [here](https://github.com/nomoixyz/vulcan/releases)

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
import { Test, expect, commands, Command, CommandResult, println } from "vulcan/test.sol";

contract TestSomething is Test {

    function testSomething() external {
        // Format strings with rust-like syntax
        println("Hello {s}", abi.encode("world!")); // Hello world!

        // Format numbers as decimals
        println("Balance: {u:d18}", abi.encode(1e17)); // Balance: 0.1

        // Nice external command API!
        Command memory ping = commands.create("ping").args(["-c", "1"]);
        CommandResult pingResult = ping.arg("etherscan.io").run();

        // Rust-like results
        bytes memory pingOutput = pingResult.expect("Ping command failed").stdout;

        println("Ping result: {s}", abi.encode(pingOutput));

        // Expect style assertions!
        expect(pingResult.isError()).toBeFalse();
        expect(pingResult.isOk()).toBeTrue();

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
