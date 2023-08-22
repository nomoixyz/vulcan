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

    /// @dev Creates a new `Fe` struct with default values.
    function create() internal pure returns (Fe memory) {
        return Fe({compilerPath: "fe", filePath: "", emitOptions: "", outputDir: "", overwrite: false});
    }

    /// @dev Builds a binary file from a `.fe` file.
    /// @param self The `Fe` struct to build.
    function build(Fe memory self) internal returns (bytes memory) {
        bytes memory output = self.toCommand().run();
        // TODO: add error handling
        return output;
    }

    /// @dev Transforms a `Fe` struct to a `Command` struct.
    /// @param self The `Fe` struct to transform.
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

    /// @dev Sets the `fe` compiler path.
    /// @param self The `Fe` struct to modify.
    /// @param compilerPath The new compiler path.
    function setCompilerPath(Fe memory self, string memory compilerPath) internal pure returns (Fe memory) {
        self.compilerPath = compilerPath;
        return self;
    }

    /// @dev Sets the `fe` file path to build.
    /// @param self The `Fe` struct to modify.
    /// @param filePath The path to the `.fe` file to build.
    function setFilePath(Fe memory self, string memory filePath) internal pure returns (Fe memory) {
        self.filePath = filePath;
        return self;
    }

    /// @dev Sets the `fe` build command emit options.
    /// @param self The `Fe` struct to modify.
    /// @param emitOptions The build command emit options.
    function setEmitOptions(Fe memory self, string memory emitOptions) internal pure returns (Fe memory) {
        self.emitOptions = emitOptions;
        return self;
    }

    /// @dev Sets the `fe` build command output directory.
    /// @param self The `Fe` struct to modify.
    /// @param outputDir The directory where the binary file will be saved.
    function setOutputDir(Fe memory self, string memory outputDir) internal pure returns (Fe memory) {
        self.outputDir = outputDir;
        return self;
    }

    /// @dev Sets the `fe` build command overwrite flag.
    /// @param self The `Fe` struct to modify.
    /// @param overwrite If true it will overwrite the `outputDir with the new build binaries.
    function setOverwrite(Fe memory self, bool overwrite) internal pure returns (Fe memory) {
        self.overwrite = overwrite;
        return self;
    }
}

using fe for Fe global;
