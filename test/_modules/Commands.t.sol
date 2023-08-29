pragma solidity >=0.8.13 <0.9.0;

import {Test, expect, commands, Command, CommandResult, ctx} from "../../src/test.sol";

contract CommandsTest is Test {
    using commands for *;

    function testCanCreateEmptyCommand() external {
        Command memory cmd = commands.create().arg("echo");

        expect(cmd.toString()).toEqual("echo");
    }

    function testItCanRunCommands() external {
        string[2] memory inputs = ["echo", "'Hello, World!'"];
        Command memory cmd = commands.create(inputs[0]).arg(inputs[1]);

        expect(string(cmd.run().stdout)).toEqual(inputs[1]);
    }

    function testItCanRunCommandsDirectly() external {
        string[2] memory inputs = ["echo", "'Hello, World!'"];
        CommandResult memory result = commands.run(inputs);

        expect(string(result.stdout)).toEqual(inputs[1]);
    }

    function testCommandToString() external {
        Command memory ping = commands.create("ping").args(["-c", "1", "nomoi.xyz"]);

        expect(ping.toString()).toEqual("ping -c 1 nomoi.xyz");
    }

    function testIsOk() external {
        CommandResult memory result = commands.run(["echo", "'Hello World'"]);

        expect(result.isOk()).toBeTrue();
    }

    function testIsNotOk() external {
        CommandResult memory result = commands.run(["forge", "--hlkfshjfhjas"]);

        expect(result.isOk()).toBeFalse();
    }

    function testIsError() external {
        CommandResult memory result = commands.run(["forge", "--hlkfshjfhjas"]);

        expect(result.isError()).toBeTrue();
    }

    function testIsNotError() external {
        CommandResult memory result = commands.run(["echo", "'Hello World'"]);

        expect(result.isError()).toBeFalse();
    }

    function testUnwrap() external {
        CommandResult memory result = commands.run(["echo", "'Hello World'"]);

        bytes memory output = result.unwrap();

        expect(string(output)).toEqual("'Hello World'");
    }

    function testUnwrapReverts() external {
        CommandResult memory result = commands.run(["forge", "--hlkfshjfhjas"]);

        bytes memory expectedError = bytes(
            string.concat(
                "Failed to run command forge --hlkfshjfhjas:\n\n",
                "error: unexpected argument '--hlkfshjfhjas' found\n\n",
                "Usage: forge <COMMAND>\n\n" "For more information, try '--help'.\n"
            )
        );

        ctx.expectRevert(expectedError);

        result.unwrap();
    }
}
