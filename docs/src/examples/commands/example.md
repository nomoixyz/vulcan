## Examples
### Run a simple command

Run a simple command and obtain the output

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, expect, commands, CommandResult, CommandOutput} from "vulcan/test.sol";

contract RunCommandExample is Test {
    function test() external {
        // Run a command to get a result
        CommandResult cmdResult = commands.run(["echo", "Hello, World!"]);

        // Obtain the output from the result
        CommandOutput memory output = cmdResult.expect("Failed to run command");

        // Check the output
        expect(string(output.stdout)).toEqual("Hello, World!");
    }
}

```

### Reuse a command

Reuse a command with different arguments

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, expect, commands, Command, CommandResult, CommandOutput} from "vulcan/test.sol";

contract ReuseACommandExample is Test {
    function test() external {
        // Create a command
        Command memory echo = commands.create("echo");

        // Run the commands and get the results
        CommandResult fooResult = echo.arg("foo").run();
        CommandResult barResult = echo.arg("bar").run();

        // Obtain the outputs from the results
        CommandOutput memory fooOutput = fooResult.expect("Failed to run echo 'foo'");
        CommandOutput memory barOutput = barResult.expect("Failed to run echo 'bar'");

        // Check the outputs
        expect(string(fooOutput.stdout)).toEqual("foo");
        expect(string(barOutput.stdout)).toEqual("bar");
    }
}

```

