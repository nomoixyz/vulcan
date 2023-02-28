# Commands

Execute external commands.

```solidity
import { Test, Command, commands } from "vulcan/test.sol";

contract TestMyContract is Test {
    using commands for *;

    function testMyContract() external {
        bytes memory res = commands.run(["echo", "Hello World"]);

        // Or

        Command memory cmd = commands.create("echo").arg("Hello World");
        res = cmd.run();
        res = cmd.run();
        res = cmd.run();
    }
}
```

## `create(input)`

Creates a new Command struct with the provided input string.

## `arg(cmd, input)`

Adds an argument to the command.

## `args(cmd, inputs)`

Adds multiple arguments to the command. Inputs can be a dynamic or fixed length (up to 20) string array.

## `run(cmd | inputs)`

Executes a command or the provided inputs.