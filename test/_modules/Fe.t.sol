pragma solidity >=0.8.13 <0.9.0;

import {Test, expect, commands, Command, fe, Fe, fs} from "../../src/test.sol";

contract FeTest is Test {
    function testToCommandAllSet() external {
        Command memory command = fe.create().setCompilerPath("difffe").setFilePath("./filePath.fe").setEmitOptions(
            "abi"
        ).setOutputDir("./feoutput").toCommand();

        expect(command.inputs.length).toEqual(7);
        expect(command.inputs[0]).toEqual("difffe");
        expect(command.inputs[1]).toEqual("build");
        expect(command.inputs[2]).toEqual("-o");
        expect(command.inputs[3]).toEqual("./feoutput");
        expect(command.inputs[4]).toEqual("-e");
        expect(command.inputs[5]).toEqual("abi");
        expect(command.inputs[6]).toEqual("./filePath.fe");
    }

    function testToCommandMinimumSet() external {
        Command memory command = fe.create().setFilePath("./filePath.fe").toCommand();

        expect(command.inputs.length).toEqual(3);
        expect(command.inputs[0]).toEqual("fe");
        expect(command.inputs[1]).toEqual("build");
        expect(command.inputs[2]).toEqual("./filePath.fe");
    }

    function testCompile() external {
        fe.create().setFilePath("./test/mocks/guest_book.fe").setOutputDir("./test/fixtures/fe/output").setOverwrite(
            true
        ).build();

        string memory result = fs.readFile("./test/fixtures/fe/output/GuestBook/GuestBook.bin");

        expect(bytes(result).length).toBeGreaterThan(0);
    }
}
