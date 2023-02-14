// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.13 <0.9.0;

import {Vm as Hevm} from "forge-std/Vm.sol";
import "./Vulcan.sol";

struct FsMetadata {
    bool isDir;
    bool isSymlink;
    uint256 length;
    bool readOnly;
    uint256 modified;
    uint256 accessed;
    uint256 created;
}

library fs {
    function readFile(string memory path) internal view returns (string memory) {
        return vulcan.hevm.readFile(path);
    }

    function readFileBinary(string memory path) internal view returns (bytes memory) {
        return vulcan.hevm.readFileBinary(path);
    }

    function projectRoot() internal view returns (string memory) {
        return vulcan.hevm.projectRoot();
    }

    function fsMetadata(string memory fileOrDir) internal returns (FsMetadata memory metadata) {
        Hevm.FsMetadata memory md = vulcan.hevm.fsMetadata(fileOrDir);
        assembly {
            metadata := md
        }
    }

    function readLine(string memory path) internal view returns (string memory) {
        return vulcan.hevm.readLine(path);
    }

    function writeFile(string memory path, string memory data) internal {
        vulcan.hevm.writeFile(path, data);
    }

    function writeFileBinary(string memory path, bytes memory data) internal {
        vulcan.hevm.writeFileBinary(path, data);
    }

    function writeLine(string memory path, string memory data) internal {
        vulcan.hevm.writeLine(path, data);
    }

    function closeFile(string memory path) internal {
        vulcan.hevm.closeFile(path);
    }

    function removeFile(string memory path) internal {
        vulcan.hevm.removeFile(path);
    }

    /// @dev Gets the creation bytecode from an artifact file. Takes in the relative path to the json file
    /// @param path the relative path to the json file
    /// @return the creation code
    function getCode(string memory path) internal view returns (bytes memory) {
        return vulcan.hevm.getCode(path);
    }
    /// @dev Gets the deployed bytecode from an artifact file. Takes in the relative path to the json file
    /// @param path the relative path to the json file
    /// @return the deployed code

    function getDeployedCode(string memory path) internal view returns (bytes memory) {
        return vulcan.hevm.getDeployedCode(path);
    }
}
