# Fe

Provides [Fe](https://fe-lang.org/) compiler support. The `ffi` setting must be enabled on `foundry.toml` for this module
to work.

```solidity
import { Test, fe } from "vulcan/test.sol";

contract TestMyContract is Test {
    function testCompile() external {
        fe.create().setFilePath("./test/mocks/guest_book.fe").setOutputDir("./test/fixtures/fe/output").setOverwrite(
            true
        ).build();

        string memory result = fs.readFile("./test/fixtures/fe/output/GuestBook/GuestBook.bin");

        expect(bytes(result).length).toBeGreaterThan(0);
    }

}
```
[**Fe API reference**](../reference/modules/fe.md)

