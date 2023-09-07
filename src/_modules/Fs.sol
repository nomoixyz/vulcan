// SPDX-License-Identifier: MIT
pragma solidity >=0.8.13 <0.9.0;

import "./Vulcan.sol";
import {Result, ResultType, Ok, StringResult, BoolResult, BytesResult} from "./Result.sol";
import {LibError, Error} from "./Error.sol";
import {removeSelector} from "../_utils/removeSelector.sol";

type FsMetadataResult is bytes32;

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
    using FsErrors for Error;

    /// @dev Reads the file on `path` and returns its content as a `string`.
    /// @param path The path to the file.
    /// @return The content of the file as `string`.
    function readFile(string memory path) internal view returns (StringResult) {
        try vulcan.hevm.readFile(path) returns (string memory content) {
            return Ok(content);
        } catch Error(string memory reason) {
            return FsErrors.FailedToRead(reason).toStringResult();
        } catch (bytes memory reason) {
            return FsErrors.FailedToRead(abi.decode(removeSelector(reason), (string))).toStringResult();
        }
    }

    /// @dev Reads the file on `path` and returns its content as a `bytes`.
    /// @param path The path to the file.
    /// @return The content of the file as `bytes`.
    function readFileBinary(string memory path) internal view returns (BytesResult) {
        try vulcan.hevm.readFileBinary(path) returns (bytes memory content) {
            return Ok(content);
        } catch Error(string memory reason) {
            return FsErrors.FailedToRead(reason).toBytesResult();
        } catch (bytes memory reason) {
            return FsErrors.FailedToRead(abi.decode(removeSelector(reason), (string))).toBytesResult();
        }
    }

    /// @dev Obtains the current project's root.
    /// @return The current project's root.
    function projectRoot() internal view returns (StringResult) {
        try vulcan.hevm.projectRoot() returns (string memory path) {
            return Ok(path);
        } catch Error(string memory reason) {
            return FsErrors.FailedToGetProjectRoot(reason).toStringResult();
        } catch (bytes memory reason) {
            return FsErrors.FailedToGetProjectRoot(abi.decode(removeSelector(reason), (string))).toStringResult();
        }
    }

    /// @dev Obtains the metadata of the specified file or directory.
    /// @param fileOrDir The path to the file or directory.
    /// @return data The metadata of the file or directory.
    function metadata(string memory fileOrDir) internal view returns (FsMetadata memory data) {
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
        BytesResult result = readFileBinary(origin);

        if (result.isError()) {
            // wrap copy error
        }

        writeFileBinary(target, result.toValue());
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
    function fileExists(string memory path) internal view returns (BoolResult) {
        try vulcan.hevm.readFile(path) {
            return Ok(true);
        } catch Error(string memory) {
            return Ok(false);
        } catch (bytes memory reason) {
            bytes4 selector = 0x0bc44503;
            string memory errorMessage =
                string.concat("The path \"", path, "\" is not allowed to be accessed for read operations.");
            bytes32 errorHash = keccak256(abi.encodeWithSelector(selector, errorMessage));
            if (keccak256(reason) == errorHash) {
                return FsErrors.Forbidden(errorMessage).toBoolResult();
            }
            return Ok(false);
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

library FsErrors {
    using LibError for *;

    function FailedToRead(string memory reason) internal pure returns (Error) {
        return FailedToRead.encodeError("Failed to read file", reason);
    }

    function FailedToGetProjectRoot(string memory reason) internal pure returns (Error) {
        return FailedToGetProjectRoot.encodeError("Failed to get project root", reason);
    }

    function Forbidden(string memory reason) internal pure returns (Error) {
        return Forbidden.encodeError("Not enough permissions to access file", reason);
    }

    function toStringResult(Error self) internal pure returns (StringResult) {
        return StringResult.wrap(Result.unwrap(self.toResult()));
    }

    function toBytesResult(Error self) internal pure returns (BytesResult) {
        return BytesResult.wrap(Result.unwrap(self.toResult()));
    }

    function toBoolResult(Error self) internal pure returns (BoolResult) {
        return BoolResult.wrap(Result.unwrap(self.toResult()));
    }
}
