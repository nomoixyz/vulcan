// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, expect, commands, Command, CommandResult, CommandOutput} from "vulcan/test.sol";

/// @title Reuse a command
/// @dev Reuse a command with different arguments
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
