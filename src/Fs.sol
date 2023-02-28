// SPDX-License-Identifier: MIT
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
    /// @dev Reads the file on `path` and returns its content as a `string`.
    /// @param path The path to the file.
    /// @return The content of the file as `string`.
    function readFile(string memory path) internal view returns (string memory) {
        return vulcan.hevm.readFile(path);
    }

    /// @dev Reads the file on `path` and returns its content as a `bytes`.
    /// @param path The path to the file.
    /// @return The content of the file as `bytes`.
    function readFileBinary(string memory path) internal view returns (bytes memory) {
        return vulcan.hevm.readFileBinary(path);
    }

    /// @dev Obtains the current project's root.
    /// @return The current project's root.
    function projectRoot() internal view returns (string memory) {
        return vulcan.hevm.projectRoot();
    }

    /// @dev Obtains the metadata of the specified file or directory.
    /// @param fileOrDir The path to the file or directory.
    /// @return data The metadata of the file or directory.
    function metadata(string memory fileOrDir) internal returns (FsMetadata memory data) {
        Hevm.FsMetadata memory md = vulcan.hevm.fsMetadata(fileOrDir);
        assembly {
            data := md
        }
    }

    /// @dev Reads the next line of the file on `path`.
    /// @param path The path to the file.
    /// @return The line that was read.
    function readLine(string memory path) internal view returns (string memory) {
        return vulcan.hevm.readLine(path);
    }

    /// @dev Modifies the content of the file on `path` with `data`.
    /// @param path The path to the file.
    /// @param data The new content of the file.
    function writeFile(string memory path, string memory data) internal {
        vulcan.hevm.writeFile(path, data);
    }

    /// @dev Modifies the content of the file on `path` with `data`.
    /// @param path The path to the file.
    /// @param data The new content of the file.
    function writeFileBinary(string memory path, bytes memory data) internal {
        vulcan.hevm.writeFileBinary(path, data);
    }

    /// @dev Adds a new line to the file on `path`.
    /// @param path The path to the file.
    /// @param data The content of the new line.
    function writeLine(string memory path, string memory data) internal {
        vulcan.hevm.writeLine(path, data);
    }

    /// @dev Resets the state of the file on `path`.
    /// @param path The path to the file.
    function closeFile(string memory path) internal {
        vulcan.hevm.closeFile(path);
    }

    /// @dev Deletes the file on `path`.
    /// @param path The path to the file.
    function removeFile(string memory path) internal {
        vulcan.hevm.removeFile(path);
    }

    /// @dev Copies a file from `origin` to `target`.
    /// @param origin The file to copy.
    /// @param target The destination of the copied data.
    function copyFile(string memory origin, string memory target) internal {
        writeFileBinary(target, readFileBinary(origin));
    }

    /// @dev Moves a file from `origin` to `target`.
    /// @param origin The file to be moved.
    /// @param target The destination of the data.
    function moveFile(string memory origin, string memory target) internal {
        copyFile(origin, target);
        removeFile(origin);
    }

    /// @dev Checks if a file or directory exists.
    /// @param path The file or directory to check.
    /// @return Whether the file on `path` exists or not.
    function fileExists(string memory path) internal returns (bool) {
        try vulcan.hevm.fsMetadata(path) {
            return true;
        } catch Error(string memory) {
            return false;
        } catch (bytes memory reason) {
            bytes4 selector = 0x0bc44503;
            string memory errorMessage = string.concat(
                "The path \"", string.concat(path, "\" is not allowed to be accessed for read operations.")
            );
            bytes32 errorHash = keccak256(abi.encodeWithSelector(selector, errorMessage));
            if (keccak256(reason) == errorHash) {
                assembly {
                    revert(add(reason, 32), mload(reason))
                }
            }
            return false;
        }
    }

    /// @dev Obtains the creation code from an artifact file located at `path`
    /// @param path The file or directory to check.
    /// @return The creation bytecode.
    function getCode(string memory path) internal view returns (bytes memory) {
        return vulcan.hevm.getCode(path);
    }

    /// @dev Obtains the deployed code from an artifact file located at `path`
    /// @param path The file or directory to check.
    /// @return The deployed bytecode.
    function getDeployedCode(string memory path) internal view returns (bytes memory) {
        return vulcan.hevm.getDeployedCode(path);
    }
}
