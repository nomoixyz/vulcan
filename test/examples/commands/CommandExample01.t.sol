// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, expect, commands, CommandResult, CommandOutput} from "vulcan/test.sol";

/// @title Run a simple command
/// @dev Run a simple command and obtain the output
contract RunCommandExample is Test {
    function test() external {
        // Run the command
        CommandOutput memory result = commands.run(["echo", "Hello, World!"]).unwrap();

        // Check the output
        expect(string(result.stdout)).toEqual("Hello, World!");
    }
}
