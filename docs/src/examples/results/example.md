## Examples
### Working with result values

Different methods of getting the underlyng value of a `Result`

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, expect, StringResult} from "vulcan/test.sol";
// This import is just to demonstration, it's not meant to be imported on projects using Vulcan
import {Ok} from "vulcan/_internal/Result.sol";

contract ResultExample is Test {
    function test() external {
        StringResult result = Ok(string("foo"));

        // Use unwrap to get the value or revert if the result is an `Error`
        string memory value = result.unwrap();
        expect(value).toEqual("foo");

        // Use expect to get the value or revert with a custom message if
        // the result is an `Error`
        value = result.expect("Result failed");
        expect(value).toEqual("foo");

        // Safely handling the result
        if (result.isOk()) {
            value = result.toValue();
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

        ctx.expectRevert();

        // Use unwrap to revert with the default error message
        result.unwrap();

        ctx.expectRevert("Command not executed");

        // Use expect to revert with a custom error message
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

