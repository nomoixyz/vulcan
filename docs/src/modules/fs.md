# Fs

Filesystem access.

```solidity
import { Test, fs } from "vulcan/test.sol";

contract TestMyContract is Test {
    function testMyContract() external {
        fs.write("test.txt", "Hello World");
        string memory content = fs.read("test.txt");
    }
}
```

### readFile

*Reads the file on `path` and returns its content as a `string`.*


```solidity
function readFile(string memory path) internal view returns (string memory);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`path`|`string`|The path to the file.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`string`|The content of the file as `string`.|


### readFileBinary

*Reads the file on `path` and returns its content as a `bytes`.*


```solidity
function readFileBinary(string memory path) internal view returns (bytes memory);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`path`|`string`|The path to the file.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`bytes`|The content of the file as `bytes`.|


### projectRoot

*Obtains the current project's root.*


```solidity
function projectRoot() internal view returns (string memory);
```
**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`string`|The current project's root.|


### metadata

*Obtains the metadata of the specified file or directory.*


```solidity
struct FsMetadata {
    bool isDir;
    bool isSymlink;
    uint256 length;
    bool readOnly;
    uint256 modified;
    uint256 accessed;
    uint256 created;
}

function metadata(string memory fileOrDir) internal returns (FsMetadata memory data);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`fileOrDir`|`string`|The path to the file or directory.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`data`|`FsMetadata`|The metadata of the file or directory.|


### readLine

*Reads the next line of the file on `path`.*


```solidity
function readLine(string memory path) internal view returns (string memory);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`path`|`string`|The path to the file.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`string`|The line that was read.|


### writeFile

*Modifies the content of the file on `path` with `data`.*


```solidity
function writeFile(string memory path, string memory data) internal;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`path`|`string`|The path to the file.|
|`data`|`string`|The new content of the file.|


### writeFileBinary

*Modifies the content of the file on `path` with `data`.*


```solidity
function writeFileBinary(string memory path, bytes memory data) internal;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`path`|`string`|The path to the file.|
|`data`|`bytes`|The new content of the file.|


### writeLine

*Adds a new line to the file on `path`.*


```solidity
function writeLine(string memory path, string memory data) internal;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`path`|`string`|The path to the file.|
|`data`|`string`|The content of the new line.|


### closeFile

*Resets the state of the file on `path`.*


```solidity
function closeFile(string memory path) internal;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`path`|`string`|The path to the file.|


### removeFile

*Deletes the file on `path`.*


```solidity
function removeFile(string memory path) internal;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`path`|`string`|The path to the file.|


### copyFile

*Copies a file from `origin` to `target`.*


```solidity
function copyFile(string memory origin, string memory target) internal;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`origin`|`string`|The file to copy.|
|`target`|`string`|The destination of the copied data.|


### moveFile

*Moves a file from `origin` to `target`.*


```solidity
function moveFile(string memory origin, string memory target) internal;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`origin`|`string`|The file to be moved.|
|`target`|`string`|The destination of the data.|


### fileExists

*Checks if a file or directory exists.*


```solidity
function fileExists(string memory path) internal returns (bool);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`path`|`string`|The file or directory to check.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`bool`|Whether the file on `path` exists or not.|


### getCode

*Obtains the creation code from an artifact file located at `path`*


```solidity
function getCode(string memory path) internal view returns (bytes memory);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`path`|`string`|The file or directory to check.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`bytes`|The creation bytecode.|


### getDeployedCode

*Obtains the deployed code from an artifact file located at `path`*


```solidity
function getDeployedCode(string memory path) internal view returns (bytes memory);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`path`|`string`|The file or directory to check.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`bytes`|The deployed bytecode.|


