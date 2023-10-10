// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, expect, commands, CommandResult, CommandOutput} from "vulcan/test.sol";

/// @title Run a simple command
/// @dev Run a simple command and obtain the output
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
