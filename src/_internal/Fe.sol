// SPDX-License-Identifier: MIT
pragma solidity >=0.8.13 <0.9.0;

import "./Commands.sol";
import "./Strings.sol";
import "./Fs.sol";
import {formatError} from "./Utils.sol";
import {BoolResult, BytesResult} from "./Result.sol";

struct Fe {
    string compilerPath;
    string filePath;
    string outputDir;
    bool overwrite;
}

library fe {
    using strings for bytes32;

    /// @dev Creates a new `Fe` struct with default values.
    function create() internal pure returns (Fe memory) {
        return Fe({compilerPath: "fe", filePath: "", outputDir: "", overwrite: false});
    }

    /// @dev Builds a binary file from a `.fe` file.
    /// @param self The `Fe` struct to build.
    function build(Fe memory self) internal returns (CommandResult) {
        return self.toCommand().run();
    }

    /// @dev Transforms a `Fe` struct to a `Command` struct.
    /// @param self The `Fe` struct to transform.
    function toCommand(Fe memory self) internal pure returns (Command memory) {
        Command memory command = commands.create(self.compilerPath);

        command = command.arg("build").args(["-e", "bytecode"]);

        if (bytes(self.outputDir).length == 0) {
            self.outputDir = "./out/__TMP/fe_builds";
        }

        command = command.args(["-o", self.outputDir]);
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

    /// @dev Obtains the bytecode of a compiled contract with `contractName`.
    /// @param contractName The name of the contract from which to retrive the bytecode.
    function getBytecode(Fe memory self, string memory contractName) internal view returns (BytesResult) {
        string memory path = string.concat(self.outputDir, "/", contractName, "/", contractName, ".bin");

        return fs.readFileBinary(path);
    }

    function _formatError(string memory func, string memory message) private pure returns (string memory) {
        return formatError("fe", func, message);
    }
}

using fe for Fe global;
