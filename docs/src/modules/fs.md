# Fs

Provides utilities to interact with the filesystem. In order to use this module the
`fs_permissions` setting must be set correctly in `foundry.toml`.

```solidity
import { Test, fs } from "vulcan/test.sol";

contract TestMyContract is Test {
    function testMyContract() external {
        // Write a string to a file
        fs.write("test.txt", "Hello World");

        // Write bytes to a file
        fs.writeBinary("test.bin", abi.encodeWithSignature("test(uint256)", 1e18));

        // Read a file as a string
        string memory content = fs.read("test.txt");

        // Read a file as bytes
        bytes memory binContent = fs.readBinary("test.bin");

        // Delete files
        fs.remove("delete.me");

        // Copy files
        fs.copy("file.original", "file.backup");

        // Move files
        fs.move("hold.txt", "hodl.txt");

        // Check if a file or directory exists
        if (fs.exists("some_file.txt")) {
            fs.remove("some_file.txt");
        }
    }
}
```
[**Fs API reference**](../reference/modules/fs.md)
