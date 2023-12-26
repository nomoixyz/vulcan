// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, commands, ctx, expect, CommandResult, CommandError} from "vulcan/test.sol";

/// @title Working with Errors
/// @dev Different ways of handling errors.
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
