# Fe

Provides [Fe](https://fe-lang.org/) compiler support. The `ffi` setting must be enabled on `foundry.toml` for this module
to work.

```solidity
import { Test, fe } from "vulcan/test.sol";

contract TestMyContract is Test {
    function testCompile() external {
        fe
            .create()
            .setFilePath("./test/mocks/guest_book.fe")
            .setOutputDir("./test/fixtures/fe/output")
            .setOverwrite(true)
            .build()
            .unwrap();

        bytes memory bytecode = fe.getBytecode("GuestBook").unwrap();
    }

}
```
[**Fe API reference**](../reference/modules/fe.md)

