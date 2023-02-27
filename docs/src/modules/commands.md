# Commands
Execute external commands.

```Solidity
import { Test, Command, commands } from "vulcan/test.sol";

contract TestMyContract is Test {
    function testMyContract() external {
        bytes memory res = commands.run(["echo", "Hello World"]);

        // Or

        Command memory cmd = commands.create("echo").arg("Hello World");
        res = cmd.run();
        res = cmd.run();
        res = cmd.run();
    }
}
```
