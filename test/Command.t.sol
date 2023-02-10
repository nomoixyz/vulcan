pragma solidity >=0.8.13 <0.9.0;

import {Test, expect, commands, Command} from "../src/lib.sol";

contract CommandTest is Test {
    using commands for *;

    function testItCanCreateCommands() external {
        string[] memory inputs = _echo();
        Command memory cmd = commands.create(inputs);

        expect(cmd.inputs[0]).toEqual(inputs[0]);
        expect(cmd.inputs[1]).toEqual(inputs[1]);
    }

    function testItCanRunCommands() external {
        string[] memory inputs = _echo();
        Command memory cmd = commands.create(inputs);

        expect(string(cmd.run())).toEqual(inputs[1]);
    }

    function testItCanRunCommandsDirectly() external {
        string[] memory inputs = _echo();
        bytes memory output = commands.run(inputs);

        expect(string(output)).toEqual(inputs[1]);
    }

    function _echo() internal returns (string[] memory) {
        string[] memory echoInputs = new string[](2);

        echoInputs[0] = "echo";
        echoInputs[1] = "'Hello, World!'";

        return echoInputs;
    }
}

