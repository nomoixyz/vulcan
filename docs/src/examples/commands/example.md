## Examples
### Run a simple command

Run a simple command and obtain the output

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, expect, commands, CommandResult, CommandOutput} from "vulcan/test.sol";

contract RunCommandExample is Test {
    function test() external {
        // Run the command
        CommandOutput memory result = commands.run(["echo", "Hello, World!"]).unwrap();

        // Check the output
        expect(string(result.stdout)).toEqual("Hello, World!");
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

        // Run the commands and unwrap the results
        CommandOutput memory fooOutput = echo.arg("foo").run().unwrap();
        CommandOutput memory barOutput = echo.arg("bar").run().unwrap();

        // Check the outputs
        expect(string(fooOutput.stdout)).toEqual("foo");
        expect(string(barOutput.stdout)).toEqual("bar");
    }
}

```

