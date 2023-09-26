// SPDX-License-Identifier: MIT
pragma solidity >=0.8.13 <0.9.0;

import {Test, expect, commands, Command, fe, Fe, fs, println, strings, StringResult} from "../../src/test.sol";

contract FeTest is Test {
    function testToCommandAllSet() external {
        string memory filePath = "./filePath.fe";
        Command memory command =
            fe.create().setFilePath(filePath).setCompilerPath("difffe").setOutputDir("./feoutput").toCommand();

        expect(command.inputs.length).toEqual(7);
        expect(command.inputs[0]).toEqual("difffe");
        expect(command.inputs[1]).toEqual("build");
        expect(command.inputs[2]).toEqual("-e");
        expect(command.inputs[3]).toEqual("bytecode");
        expect(command.inputs[4]).toEqual("-o");
        expect(command.inputs[5]).toEqual("./feoutput");
        expect(command.inputs[6]).toEqual(filePath);
    }

    function testToCommandMinimumSet() external {
        string memory filePath = "./filePath.fe";

        Command memory command = fe.create().setFilePath(filePath).toCommand();

        expect(command.inputs.length).toEqual(7);
        expect(command.inputs[0]).toEqual("fe");
        expect(command.inputs[1]).toEqual("build");
        expect(command.inputs[2]).toEqual("-e");
        expect(command.inputs[3]).toEqual("bytecode");
        expect(command.inputs[4]).toEqual("-o");
        expect(command.inputs[5]).toEqual("./out/__TMP/fe_builds");
        expect(command.inputs[6]).toEqual("./filePath.fe");
    }

    function testCompile() external {
        fe.create().setFilePath("./test/mocks/guest_book.fe").setOutputDir("./test/fixtures/fe/output").setOverwrite(
            true
        ).build().unwrap();

        StringResult result = fs.readFile("./test/fixtures/fe/output/A/A.bin");

        expect(bytes(result.unwrap()).length).toBeGreaterThan(0);
    }

    function testCompileAndRead() external {
        Fe memory feCmd = fe.create().setFilePath("./test/mocks/guest_book.fe").setOverwrite(true);

        feCmd.build().unwrap();

        string memory expectedBytecode = "600180600c6000396000f3fe00";

        expect(string(feCmd.getBytecode("A").toValue())).toEqual(expectedBytecode);
    }
}
