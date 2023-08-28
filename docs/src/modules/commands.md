# Commands

Execute external commands. The `ffi` setting must be enabled on `foundry.toml` for this module to
work.

```solidity
import { Test, Command, commands, CommandResult } from "vulcan/test.sol";

contract TestMyContract is Test {
    using commands for *;

    function testMyContract() external {
        // run `echo Hello World`.
        // There is no need to create a dynamic array for the arguments
        CommandResult memory res = commands.run(["echo", "Hello World"]);

        if (res.isOk()) {
            // do something
        }

        if (res.isError()) {
            // do something else
        }

        // This will return the output from `stdout` or revert if the command failed.
        bytes memory output = res.unwrap();

        // A comand can be created to facilitate multiple executions
        Command memory cmd = commands.create("echo").arg("Hello World");
        res = cmd.run();
        res = cmd.run();
        res = cmd.run();

        // A base command can be created and then be executed with different arguments
        Command memory ping = commands.create("ping").args(["-c", "1"]);
        res = ping.arg("etherscan.io").run();
        res = ping.arg("arbiscan.io").run();
    }
}
```
[**Commands API reference**](../reference/modules/commands.md)
