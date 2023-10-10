## Examples
### Working with result values

Different methods of getting the underlyng value of a `Result`

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, expect, StringResult, Ok} from "vulcan/test.sol";

contract ResultExample is Test {
    function test() external {
        StringResult result = Ok(string("foo"));

        // Use unwrap to get the value or revert if the result is an `Error`
        string memory unwrapValue = result.unwrap();
        expect(unwrapValue).toEqual("foo");

        // Use expect to get the value or revert with a custom message if
        // the result is an `Error`
        string memory expectValue = result.expect("Result failed");
        expect(expectValue).toEqual("foo");

        // Safely getting the value
        if (result.isOk()) {
            string memory value = result.toValue();
            expect(value).toEqual("foo");
        }
    }
}

```

### Working with Errors

Different ways of handling errors.

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, commands, ctx, expect, CommandResult, CommandError} from "vulcan/test.sol";

contract ResultExample is Test {
    function test() external {
        // Run a non existent command
        CommandResult result = commands.run(["asdf12897u391723"]);

        // Use unwrap to revert with the default error message
        ctx.expectRevert(
            "The command was not executed: \"Failed to execute command: No such file or directory (os error 2)\""
        );
        result.unwrap();

        // Use expect to revert with a custom error message
        ctx.expectRevert("Command not executed");
        result.expect("Command not executed");

        bool failed = false;

        // Handle the error manually
        if (result.isError()) {
            if (result.toError().matches(CommandError.NotExecuted)) {
                failed = true;
            }
        }

        expect(failed).toBeTrue();
    }
}

```

