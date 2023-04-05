# Format

The format function defined under the Fmt module enables you to format strings dinamically by creating a template and then sending some arguments in it.

```solidity
//// SPDX-License-Identifier: MIT
pragma solidity >=0.8.13 <0.9.0;

import {Test, expect, config, Rpc, console} from "../src/test.sol";
import {Type, Placeholder, fmt} from "../src/Fmt.sol";

contract FormatTest is Test {
    function testFormat() external {
        string memory template = "{address} hello {string} world {bool}";
        string memory result = fmt.format(template, abi.encode(address(123), "foo", true));

        expect(result).toEqual("0x000000000000000000000000000000000000007B hello foo world true");
    }
}
```

In this exampledemonstrates the use of a string template with placeholders and a custom formatting function to generate a formatted string. It is a simple and efficient way to manage dynamic values on strings.

