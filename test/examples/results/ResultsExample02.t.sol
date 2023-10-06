// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, commands, ctx, expect, CommandResult, CommandError} from "vulcan/test.sol";

/// @title Working with Errors
/// @dev This example shows different ways of handling errors.
contract ResultExample02 is Test {
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
