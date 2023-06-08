# Format

The format function defined under the `fmt` module enables you to format strings dynamically by using a template string and the ABI encoded arguments:

```solidity
import {Test, expect, console, fmt} from "vulcan/test.sol";

contract TestMyContract is Test {
    function testFormat() external {
        string memory template = "{address} hello {string} world {bool}";

        // You can also use abbreviations: "{a} hello {s} world {b}";
        template = "{a} hello {s} world {b}";

        string memory result = fmt.format(template, abi.encode(address(123), "foo", true));
        expect(result).toEqual("0x000000000000000000000000000000000000007B hello foo world true");

        // For numerical values, you can even specify the number of decimals to format with
        expect(fmt.format("{uint:d18}", abi.encode(1e17))).toEqual("0.1");
    }
}
```

This example demonstrates the use of a string template with placeholders and a custom formatting function to generate a formatted string. It is a simple and efficient way to manage dynamic values on strings.