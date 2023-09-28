# Fs

Provides utilities to interact with the filesystem. In order to use this module the
`fs_permissions` setting must be set correctly in `foundry.toml`.

```solidity
import { Test, fs, BytesResult } from "vulcan/test.sol";

contract TestMyContract is Test {
    function testMyContract() external {
        // Write a string to a file
        fs.write("test.txt", "Hello World").unwrap();

        // Write bytes to a file
        fs.writeBinary("test.bin", abi.encodeWithSignature("test(uint256)", 1e18)).unwrap();

        // Read a file as a string
        string memory content = fs.read("test.txt").unwrap();

        // Read a file as bytes
        BytesResult binContentResult = fs.readBinary("test.bin");
        bytes memory binContent = binContentResult.unwrap();

        // Delete files
        fs.remove("delete.me").unwrap();

        // Copy files
        fs.copy("file.original", "file.backup").unwrap();

        // Move files
        fs.move("hold.txt", "hodl.txt").unwrap();

        // Check if a file or directory exists
        if (fs.exists("some_file.txt").unwrap()) {
            fs.remove("some_file.txt").unwrap();
        }
    }
}
```
[**Fs API reference**](../reference/modules/fs.md)
