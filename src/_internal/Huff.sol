// SPDX-License-Identifier: MIT
pragma solidity >=0.8.13 <0.9.0;

import "./Commands.sol";
import "./Strings.sol";
import {formatError} from "./Utils.sol";

struct Huffc {
    string compilerPath;
    string filePath;
    string outputPath;
    string mainName;
    string constructorName;
    bool onlyRuntime;
    string[] constantOverrides;
}

using huff for Huffc global;

library huff {
    using strings for bytes32;

    function create() internal pure returns (Huffc memory) {
        return Huffc({
            compilerPath: "huffc",
            filePath: "",
            outputPath: "",
            mainName: "",
            constructorName: "",
            onlyRuntime: false,
            constantOverrides: new string[](0)
        });
    }

    function compile(Huffc memory self) internal returns (CommandResult) {
        return self.toCommand().run();
    }

    function toCommand(Huffc memory self) internal pure returns (Command memory) {
        Command memory command = commands.create(self.compilerPath);
        require(bytes(self.filePath).length > 0, _formatError("toCommand(Huffc)", "self.filePath not set"));

        if (bytes(self.outputPath).length > 0) command = command.args(["-ao", self.outputPath]);
        if (bytes(self.mainName).length > 0) command = command.args(["-m", self.mainName]);
        if (bytes(self.constructorName).length > 0) command = command.args(["-l", self.constructorName]);
        if (self.onlyRuntime) command = command.args(["-r"]);
        if (self.constantOverrides.length > 0) {
            string memory overrides = "";
            for (uint256 i; i < self.constantOverrides.length; i++) {
                overrides = string.concat(overrides, (i == 0 ? "" : " "), self.constantOverrides[i]);
            }
            command = command.args(["-c", overrides]);
        }

        // MUST be last
        command = command.args(["-b", self.filePath]);
        return command;
    }

    function setCompilerPath(Huffc memory self, string memory compilerPath) internal pure returns (Huffc memory) {
        self.compilerPath = compilerPath;
        return self;
    }

    function setFilePath(Huffc memory self, string memory filePath) internal pure returns (Huffc memory) {
        self.filePath = filePath;
        return self;
    }

    function setOutputPath(Huffc memory self, string memory outputPath) internal pure returns (Huffc memory) {
        self.outputPath = outputPath;
        return self;
    }

    function setMainName(Huffc memory self, string memory mainName) internal pure returns (Huffc memory) {
        self.mainName = mainName;
        return self;
    }

    function setConstructorName(Huffc memory self, string memory constructorName)
        internal
        pure
        returns (Huffc memory)
    {
        self.constructorName = constructorName;
        return self;
    }

    function setOnlyRuntime(Huffc memory self, bool onlyRuntime) internal pure returns (Huffc memory) {
        self.onlyRuntime = onlyRuntime;
        return self;
    }

    function addConstantOverride(Huffc memory self, string memory const, bytes32 value)
        internal
        pure
        returns (Huffc memory)
    {
        string[] memory overrides = new string[](self.constantOverrides.length + 1);
        for (uint256 i; i < self.constantOverrides.length; i++) {
            overrides[i] = self.constantOverrides[i];
        }
        overrides[overrides.length - 1] = string.concat(const, "=", value.toString());
        self.constantOverrides = overrides;
        return self;
    }

    function _formatError(string memory func, string memory message) private pure returns (string memory) {
        return formatError("huff", func, message);
    }
}
