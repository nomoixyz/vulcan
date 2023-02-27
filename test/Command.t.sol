pragma solidity >=0.8.13 <0.9.0;

import {Test, expect, commands, Command} from "../src/test.sol";

contract CommandTest is Test {
    using commands for *;

    function testItCanRunCommands() external {
        string[2] memory inputs = ["echo", "'Hello, World!'"];
        Command memory cmd = commands.create(inputs[0]).arg(inputs[1]);

        expect(string(cmd.run())).toEqual(inputs[1]);
    }

    function testItCanRunCommandsDirectly() external {
        string[2] memory inputs = ["echo", "'Hello, World!'"];
        bytes memory output = commands.run(inputs);

        expect(string(output)).toEqual(inputs[1]);
    }
}
