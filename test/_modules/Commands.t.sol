// SPDX-License-Identifier: MIT
pragma solidity >=0.8.13 <0.9.0;

import {
    Test,
    expect,
    commands,
    Command,
    CommandResult,
    CommandOutput,
    CommandError,
    Error,
    ctx,
    println
} from "../../src/test.sol";

contract CommandsTest is Test {
    using commands for *;

    function testCanCreateEmptyCommand() external {
        Command memory cmd = commands.create().arg("echo");

        expect(cmd.toString()).toEqual("echo");
    }

    function testItCanRunCommands() external {
        string[2] memory inputs = ["echo", "'Hello, World!'"];

        Command memory cmd = commands.create(inputs[0]).arg(inputs[1]);

        expect(string(cmd.run().unwrap().stdout)).toEqual(inputs[1]);
    }

    function testItCanRunCommandsDirectly() external {
        string[2] memory inputs = ["echo", "'Hello, World!'"];

        CommandResult result = commands.run(inputs);

        expect(string(result.unwrap().stdout)).toEqual(inputs[1]);
    }

    function testCommandToString() external {
        Command memory ping = commands.create("ping").args(["-c", "1", "nomoi.xyz"]);

        expect(ping.toString()).toEqual("ping -c 1 nomoi.xyz");
    }

    function testIsOk() external {
        CommandResult result = commands.run(["echo", "'Hello World'"]);

        expect(result.isOk()).toBeTrue();
    }

    function testIsNotOk() external {
        CommandResult result = commands.run(["nonexistentcommand", "--hlkfshjfhjas"]);

        expect(result.isOk()).toBeFalse();
    }

    function testIsError() external {
        CommandResult result = commands.run(["nonexistentcommand", "--hlkfshjfhjas"]);

        expect(result.isError()).toBeTrue();
    }

    function testIsNotError() external {
        CommandResult result = commands.run(["echo", "'Hello World'"]);

        expect(result.isError()).toBeFalse();
    }

    function testUnwrap() external {
        CommandResult result = commands.run(["echo", "'Hello World'"]);

        bytes memory output = result.unwrap().stdout;

        expect(string(output)).toEqual("'Hello World'");
    }

    function testUnwrapReverts() external {
        CommandResult result = commands.run(["nonexistentcommand", "--hlkfshjfhjas"]);

        bytes memory expectedError =
            bytes("The command was not executed: \"Failed to execute command: No such file or directory (os error 2)\"");

        ctx.expectRevert(expectedError);

        result.unwrap();
    }

    function testCommandError() external {
        Error error = CommandError.NotExecuted("Test");

        expect(error.matches(CommandError.NotExecuted)).toBeTrue();
    }
}
