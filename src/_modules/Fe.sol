// SPDX-License-Identifier: MIT
pragma solidity >=0.8.13 <0.9.0;

import "./Commands.sol";
import "./Strings.sol";

struct Fe {
    string compilerPath;
    string filePath;
    string emitOptions;
    string outputDir;
    bool overwrite;
}

library fe {
    using strings for bytes32;

    function create() internal pure returns (Fe memory) {
        return Fe({compilerPath: "fe", filePath: "", emitOptions: "", outputDir: "", overwrite: false});
    }

    function build(Fe memory self) internal returns (bytes memory) {
        bytes memory output = self.toCommand().run();
        // TODO: add error handling
        return output;
    }

    function toCommand(Fe memory self) internal pure returns (Command memory) {
        Command memory command = commands.create(self.compilerPath);
        require(bytes(self.filePath).length > 0, "fe.toCommand: self.filePath not set");

        // MUST be last
        command = command.arg("build");

        if (bytes(self.outputDir).length > 0) command = command.args(["-o", self.outputDir]);
        if (bytes(self.emitOptions).length > 0) command = command.args(["-e", self.emitOptions]);
        if (self.overwrite) command = command.arg("--overwrite");

        command = command.arg(self.filePath);

        return command;
    }

    function setCompilerPath(Fe memory self, string memory compilerPath) internal pure returns (Fe memory) {
        self.compilerPath = compilerPath;
        return self;
    }

    function setFilePath(Fe memory self, string memory filePath) internal pure returns (Fe memory) {
        self.filePath = filePath;
        return self;
    }

    function setEmitOptions(Fe memory self, string memory emitOptions) internal pure returns (Fe memory) {
        self.emitOptions = emitOptions;
        return self;
    }

    function setOutputDir(Fe memory self, string memory outputDir) internal pure returns (Fe memory) {
        self.outputDir = outputDir;
        return self;
    }

    function setOverwrite(Fe memory self, bool overwrite) internal pure returns (Fe memory) {
        self.overwrite = overwrite;
        return self;
    }
}

using fe for Fe global;
