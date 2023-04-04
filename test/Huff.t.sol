pragma solidity >=0.8.13 <0.9.0;

import {Test, expect, Command, console, huff, Huffc} from "../src/test.sol";

bytes32 constant SLOT = 0x0000000000000000000000000000000000000000000000000000000000000001;
bytes32 constant OTHER_SLOT = 0x0000000000000000000000000000000000000000000000000000000000000002;
string constant SLOTS_AS_STRING =
    "SLOT=0x0000000000000000000000000000000000000000000000000000000000000001 OTHER_SLOT=0x0000000000000000000000000000000000000000000000000000000000000002";

contract HuffTest is Test {
    using huff for *;

    function testToCommand() external {
    Command memory command = huff.create()
        .setCompilerPath("diffhuff")
        .setFilePath("./filePath.huff")
        .setOutputPath("./outputPath.json")
        .setMainName("ALT_MAIN")
        .setConstructorName("ALT_CONSTRUCTOR")
        .setOnlyRuntime(true)
        .addConstantOverride("SLOT", SLOT)
        .addConstantOverride("OTHER_SLOT", OTHER_SLOT)
        .toCommand();

        expect(command.inputs.length).toEqual(12);
        expect(command.inputs[0]).toEqual("diffhuff");
        expect(command.inputs[1]).toEqual("-ao");
        expect(command.inputs[2]).toEqual("./outputPath.json");
        expect(command.inputs[3]).toEqual("-m");
        expect(command.inputs[4]).toEqual("ALT_MAIN");
        expect(command.inputs[5]).toEqual("-l");
        expect(command.inputs[6]).toEqual("ALT_CONSTRUCTOR");
        expect(command.inputs[7]).toEqual("-r");
        expect(command.inputs[8]).toEqual("-c");
        expect(command.inputs[9]).toEqual(SLOTS_AS_STRING);
        expect(command.inputs[10]).toEqual("-b");
        expect(command.inputs[11]).toEqual("./filePath.huff");
    }

    function testCompile() external {
        expect(huff.create().setFilePath("./test/mocks/Getter.huff").compile()).toEqual(
            hex"602e8060093d393df360003560e01c806360fe47b11461001b57636d4ce63c14610022575b6004356000555b60005460005160206000f3"
        );
    }
}
