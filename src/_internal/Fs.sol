// SPDX-License-Identifier: MIT
pragma solidity >=0.8.13 <0.9.0;

import "./Vulcan.sol";
import {Pointer} from "./Pointer.sol";
import {ResultType, Ok, StringResult, BoolResult, BytesResult, EmptyResult, LibResultPointer} from "./Result.sol";
import {LibError, Error} from "./Error.sol";
import {removeSelector} from "./Utils.sol";

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
    using LibError for *;
    using FsErrors for Error;

    /// @dev Reads the file on `path` and returns its content as a `StringResult`.
    /// @param path The path to the file.
    /// @return The content of the file as `StringResult`.
    function readFile(string memory path) internal view returns (StringResult) {
        try vulcan.hevm.readFile(path) returns (string memory content) {
            return Ok(content);
        } catch Error(string memory reason) {
            return FsErrors.FailedToRead(reason).toStringResult();
        } catch (bytes memory reason) {
            return FsErrors.FailedToRead(abi.decode(removeSelector(reason), (string))).toStringResult();
        }
    }

    /// @dev Reads the file on `path` and returns its content as a `BytesResult`.
    /// @param path The path to the file.
    /// @return The content of the file as `BytesResult`.
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
    /// @return The current project's root as `StringResult`.
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
    /// @return data The metadata of the file or directory as `FsMetadataResult`.
    function metadata(string memory fileOrDir) internal view returns (FsMetadataResult) {
        try vulcan.hevm.fsMetadata(fileOrDir) returns (Hevm.FsMetadata memory md) {
            FsMetadata memory data;
            assembly {
                data := md
            }

            return Ok(data);
        } catch Error(string memory reason) {
            return FsErrors.FailedToReadMetadata(reason).toFsMetadataResult();
        } catch (bytes memory reason) {
            return FsErrors.FailedToReadMetadata(abi.decode(removeSelector(reason), (string))).toFsMetadataResult();
        }
    }

    /// @dev Reads the next line of the file on `path`.
    /// @param path The path to the file.
    /// @return The line that was read.
    function readLine(string memory path) internal view returns (StringResult) {
        try vulcan.hevm.readLine(path) returns (string memory line) {
            return Ok(line);
        } catch Error(string memory reason) {
            return FsErrors.FailedToReadLine(reason).toStringResult();
        } catch (bytes memory reason) {
            return FsErrors.FailedToReadLine(abi.decode(removeSelector(reason), (string))).toStringResult();
        }
    }

    /// @dev Modifies the content of the file on `path` with `data`.
    /// @param path The path to the file.
    /// @param data The new content of the file.
    function writeFile(string memory path, string memory data) internal returns (EmptyResult) {
        try vulcan.hevm.writeFile(path, data) {
            return Ok();
        } catch Error(string memory reason) {
            return FsErrors.FailedToWrite(reason).toEmptyResult();
        } catch (bytes memory reason) {
            return FsErrors.FailedToWrite(abi.decode(removeSelector(reason), (string))).toEmptyResult();
        }
    }

    /// @dev Modifies the content of the file on `path` with `data`.
    /// @param path The path to the file.
    /// @param data The new content of the file.
    function writeFileBinary(string memory path, bytes memory data) internal returns (EmptyResult) {
        try vulcan.hevm.writeFileBinary(path, data) {
            return Ok();
        } catch Error(string memory reason) {
            return FsErrors.FailedToWrite(reason).toEmptyResult();
        } catch (bytes memory reason) {
            return FsErrors.FailedToWrite(abi.decode(removeSelector(reason), (string))).toEmptyResult();
        }
    }

    /// @dev Adds a new line to the file on `path`.
    /// @param path The path to the file.
    /// @param data The content of the new line.
    function writeLine(string memory path, string memory data) internal returns (EmptyResult) {
        try vulcan.hevm.writeLine(path, data) {
            return Ok();
        } catch Error(string memory reason) {
            return FsErrors.FailedToWriteLine(reason).toEmptyResult();
        } catch (bytes memory reason) {
            return FsErrors.FailedToWriteLine(abi.decode(removeSelector(reason), (string))).toEmptyResult();
        }
    }

    /// @dev Resets the state of the file on `path`.
    /// @param path The path to the file.
    function closeFile(string memory path) internal returns (EmptyResult) {
        try vulcan.hevm.closeFile(path) {
            return Ok();
        } catch Error(string memory reason) {
            return FsErrors.FailedToCloseFile(reason).toEmptyResult();
        } catch (bytes memory reason) {
            return FsErrors.FailedToCloseFile(abi.decode(removeSelector(reason), (string))).toEmptyResult();
        }
    }

    /// @dev Deletes the file on `path`.
    /// @param path The path to the file.
    function removeFile(string memory path) internal returns (EmptyResult) {
        try vulcan.hevm.removeFile(path) {
            return Ok();
        } catch Error(string memory reason) {
            return FsErrors.FailedToRemoveFile(reason).toEmptyResult();
        } catch (bytes memory reason) {
            return FsErrors.FailedToRemoveFile(abi.decode(removeSelector(reason), (string))).toEmptyResult();
        }
    }

    /// @dev Copies a file from `origin` to `target`.
    /// @param origin The file to copy.
    /// @param target The destination of the copied data.
    function copyFile(string memory origin, string memory target) internal returns (EmptyResult) {
        BytesResult readResult = readFileBinary(origin);

        if (readResult.isError()) {
            return readResult.toError().toEmptyResult();
        }

        EmptyResult writeResult = writeFileBinary(target, readResult.toValue());

        if (writeResult.isError()) {
            return writeResult;
        }

        return Ok();
    }

    /// @dev Moves a file from `origin` to `target`.
    /// @param origin The file to be moved.
    /// @param target The destination of the data.
    function moveFile(string memory origin, string memory target) internal returns (EmptyResult) {
        EmptyResult copyResult = copyFile(origin, target);

        if (copyResult.isError()) {
            return copyResult;
        }

        EmptyResult removeResult = removeFile(origin);

        if (removeResult.isError()) {
            return removeResult;
        }

        return Ok();
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
            bytes32 errorHash = keccak256(bytes(abi.decode(removeSelector(reason), (string))));
            string memory linuxErrorMessage =
                string.concat("The path \"", path, "\" is not allowed to be accessed for read operations.");
            bytes32 linuxErrorHash = keccak256(bytes(linuxErrorMessage));

            string memory macErrorMessage =
                string.concat("the path ", path, " is not allowed to be accessed for read operations");
            bytes32 macErrorHash = keccak256(bytes(macErrorMessage));
            if (errorHash == linuxErrorHash || errorHash == macErrorHash) {
                return FsErrors.Forbidden(linuxErrorMessage).toBoolResult();
            }
            return Ok(false);
        }
    }

    /// @dev Obtains the creation code from an artifact file located at `path`
    /// @param path The file or directory to check.
    /// @return The creation bytecode.
    function getCode(string memory path) internal view returns (BytesResult) {
        try vulcan.hevm.getCode(path) returns (bytes memory code) {
            return Ok(code);
        } catch Error(string memory reason) {
            return FsErrors.FailedToGetCode(reason).toBytesResult();
        } catch (bytes memory reason) {
            return FsErrors.FailedToGetCode(abi.decode(removeSelector(reason), (string))).toBytesResult();
        }
    }

    /// @dev Obtains the deployed code from an artifact file located at `path`
    /// @param path The file or directory to check.
    /// @return The deployed bytecode.
    function getDeployedCode(string memory path) internal view returns (BytesResult) {
        try vulcan.hevm.getDeployedCode(path) returns (bytes memory code) {
            return Ok(code);
        } catch Error(string memory reason) {
            return FsErrors.FailedToGetCode(reason).toBytesResult();
        } catch (bytes memory reason) {
            return FsErrors.FailedToGetCode(abi.decode(removeSelector(reason), (string))).toBytesResult();
        }
    }
}

library FsErrors {
    using LibError for *;

    function FailedToRead(string memory reason) internal pure returns (Error) {
        string memory message = string.concat("Failed to read file: \"", reason, "\"");
        return FailedToRead.encodeError(message, reason);
    }

    function FailedToReadLine(string memory reason) internal pure returns (Error) {
        string memory message = string.concat("Failed to read line: \"", reason, "\"");
        return FailedToReadLine.encodeError(message, reason);
    }

    function FailedToReadMetadata(string memory reason) internal pure returns (Error) {
        string memory message = string.concat("Failed to read metadata: \"", reason, "\"");
        return FailedToReadMetadata.encodeError(message, reason);
    }

    function FailedToGetProjectRoot(string memory reason) internal pure returns (Error) {
        string memory message = string.concat("Failed to get project root: \"", reason, "\"");
        return FailedToGetProjectRoot.encodeError(message, reason);
    }

    function Forbidden(string memory reason) internal pure returns (Error) {
        string memory message = string.concat("Not enough permissions to access file: \"", reason, "\"");
        return Forbidden.encodeError(message, reason);
    }

    function FailedToWrite(string memory reason) internal pure returns (Error) {
        string memory message = string.concat("Failed to write file: \"", reason, "\"");
        return FailedToWrite.encodeError(message, reason);
    }

    function FailedToWriteLine(string memory reason) internal pure returns (Error) {
        string memory message = string.concat("Failed to write line: \"", reason, "\"");
        return FailedToWriteLine.encodeError(message, reason);
    }

    function FailedToCloseFile(string memory reason) internal pure returns (Error) {
        string memory message = string.concat("Failed to close file: \"", reason, "\"");
        return FailedToCloseFile.encodeError(message, reason);
    }

    function FailedToRemoveFile(string memory reason) internal pure returns (Error) {
        string memory message = string.concat("Failed to remove file: \"", reason, "\"");
        return FailedToRemoveFile.encodeError(message, reason);
    }

    function FailedToGetCode(string memory reason) internal pure returns (Error) {
        string memory message = string.concat("Failed to get code: \"", reason, "\"");
        return FailedToGetCode.encodeError(message, reason);
    }

    function toFsMetadataResult(Error self) internal pure returns (FsMetadataResult) {
        return FsMetadataResult.wrap(Pointer.unwrap(self.toPointer()));
    }

    function toEmptyResult(Error self) internal pure returns (EmptyResult) {
        return EmptyResult.wrap(Pointer.unwrap(self.toPointer()));
    }
}

library LibFsMetadataPointer {
    function toFsMetadata(Pointer self) internal pure returns (FsMetadata memory metadata) {
        assembly {
            metadata := self
        }
    }

    function toFsMetadataResult(Pointer self) internal pure returns (FsMetadataResult ptr) {
        assembly {
            ptr := self
        }
    }

    function toPointer(FsMetadata memory self) internal pure returns (Pointer ptr) {
        assembly {
            ptr := self
        }
    }
}

library LibFsMetadataResult {
    function isOk(FsMetadataResult self) internal pure returns (bool) {
        return LibResultPointer.isOk(self.toPointer());
    }

    function isError(FsMetadataResult self) internal pure returns (bool) {
        return LibResultPointer.isError(self.toPointer());
    }

    function unwrap(FsMetadataResult self) internal pure returns (FsMetadata memory val) {
        return LibResultPointer.unwrap(self.toPointer()).toFsMetadata();
    }

    function expect(FsMetadataResult self, string memory err) internal pure returns (FsMetadata memory) {
        return LibResultPointer.expect(self.toPointer(), err).toFsMetadata();
    }

    function toError(FsMetadataResult self) internal pure returns (Error) {
        return LibResultPointer.toError(self.toPointer());
    }

    function toValue(FsMetadataResult self) internal pure returns (FsMetadata memory val) {
        (, Pointer ptr) = LibResultPointer.decode(self.toPointer());

        return ptr.toFsMetadata();
    }

    function toPointer(FsMetadataResult self) internal pure returns (Pointer) {
        return Pointer.wrap(FsMetadataResult.unwrap(self));
    }
}

function Ok(FsMetadata memory value) pure returns (FsMetadataResult) {
    return ResultType.Ok.encode(value.toPointer()).toFsMetadataResult();
}

using LibFsMetadataPointer for Pointer;
using LibFsMetadataPointer for FsMetadata;

using LibFsMetadataResult for FsMetadataResult global;
