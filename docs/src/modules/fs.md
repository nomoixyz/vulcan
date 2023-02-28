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

## `readFile(path)`

## `readFileBinary(path)`

## `projectRoot()`

## `metadata(fileOrDir)`

## `readLine(path)`

## `writeFile(path, data)`

## `writeFileBinary(path, data)`

## `writeLine(path, data)`

## `closeFile(path)`

## `removeFile(path)`

## `copyFile(from, to)`

## `moveFile(from, to)`

## `fileExists(path)`

## `getCode(path)`

## `getDeployedCode(path)`
