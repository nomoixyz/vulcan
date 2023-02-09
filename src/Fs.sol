// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.13 <0.9.0;

import { Vm as Hevm } from "forge-std/Vm.sol";
import "./Vulcan.sol";

type Fs is bytes32;

struct FsMetadata {
    bool isDir;
    bool isSymlink;
    uint256 length;
    bool readOnly;
    uint256 modified;
    uint256 accessed;
    uint256 created;
}

library FsLib {

    function readFile(Fs, string memory path) internal view returns (string memory) {
        return vulcan.hevm.readFile(path);
    }

    function readFileBinary(Fs, string memory path) internal view returns (bytes memory) {
        return vulcan.hevm.readFileBinary(path);
    }

    function projectRoot(Fs) internal view returns (string memory) {
        return vulcan.hevm.projectRoot();
    }
    
    function fsMetadata(string memory fileOrDir) internal returns (FsMetadata memory metadata) {
        Hevm.FsMetadata memory md = vulcan.hevm.fsMetadata(fileOrDir);
        assembly {
            metadata := md
        }
    }

    function readLine(Fs, string memory path) internal view returns (string memory) {
        return vulcan.hevm.readLine(path);
    }

    function writeFile(Fs, string memory path, string memory data) internal {
        vulcan.hevm.writeFile(path, data);
    }

    function writeFileBinary(Fs, string memory path, bytes memory data) internal {
        vulcan.hevm.writeFileBinary(path, data);
    }
    function writeLine(Fs, string memory path, string memory data) internal {
        vulcan.hevm.writeLine(path, data);
    }
    function closeFile(Fs, string memory path) internal {
        vulcan.hevm.closeFile(path);
    }
    function removeFile(Fs, string memory path) internal {
        vulcan.hevm.removeFile(path);
    }

    /// @dev Gets the creation bytecode from an artifact file. Takes in the relative path to the json file
    /// @param path the relative path to the json file
    /// @return the creation code
    function getCode(Fs, string memory path) internal view returns (bytes memory) {
        return vulcan.evm.getCode(path);
    }
    /// @dev Gets the deployed bytecode from an artifact file. Takes in the relative path to the json file
    /// @param path the relative path to the json file
    /// @return the deployed code
    function getDeployedCode(Fs, string memory path) internal view returns (bytes memory) {
        return vulcan.hevm.getDeployedCode(path);
    }
}

Fs constant fs = Fs.wrap(0);

using FsLib for Fs global;