# Fs

Filesystem access.

```Solidity
import { Test, fs } from "vulcan/test.sol";

contract TestMyContract is Test {
    function testMyContract() external {
        fs.write("test.txt", "Hello World");
        string memory content = fs.read("test.txt");
    }
}
```
