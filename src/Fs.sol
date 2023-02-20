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

    function copyFile(string memory origin, string memory target) internal {
        writeFileBinary(target, readFileBinary(origin));
    }

    function moveFile(string memory origin, string memory target) internal {
        copyFile(origin, target);
        removeFile(origin);
    }

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

    function getCode(string memory path) internal view returns (bytes memory) {
        return vulcan.hevm.getCode(path);
    }

    function getDeployedCode(string memory path) internal view returns (bytes memory) {
        return vulcan.hevm.getDeployedCode(path);
    }
}
