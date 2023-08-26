pragma solidity >=0.8.13 <0.9.0;

import {Test, expect, commands, Command, CommandResult} from "../../src/test.sol";

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
}
