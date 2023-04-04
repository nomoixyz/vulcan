# Huff

Provides Huff compiler support. The `ffi` setting must be enabled on `foundry.toml` for this module
to work.

```solidity
import { Test, huff } from "vulcan/test.sol";

contract TestMyContract is Test {
    using huff for *;

    function testMyContractSimple() external {
        // create the `Huffc` structure, mutate the configuration, and compile.
        //
        // runs:
        // `huffc -b ./filePath.huff`
        bytes memory initcode = huffc.create()
            .setFilePath("./filePath.huff")
            .compile();
    }

    function testMyContractComplex() external {
        bytes32 SLOT = 0x0000000000000000000000000000000000000000000000000000000000000000;

        // create the `Huffc` structure, mutate the configuration, and compile.
        //
        // runs:
        // `dhuff -ao ./outputPath.json -m ALT_MAIN -l ALT_CON -r -c SLOT=0x00 -b ./filePath.huff`
        bytes memory runtimecode = huffc.create()
            .setCompilerPath("dhuff")
            .setFilePath("./filePath.huff")
            .setOutputPath("./outputPath.json")
            .setMainName("ALT_MAIN")
            .setConstructorName("ALT_CON")
            .setOnlyRuntime(true)
            .addConstantOverride("SLOT", SLOT)
            .compile();
    }
}
```
[**Huff API reference**](../reference/modules/huff.md)
