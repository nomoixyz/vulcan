## Examples
### Using templates

Using templates with the `format` module to format data

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, accounts, expect, fmt, println} from "vulcan/test.sol";

contract FormatExample is Test {
    using accounts for address;

    function test() external {
        address target = address(1).setBalance(1);
        uint256 balance = target.balance;

        // Store it as a string
        // NOTE: The {address} and {uint} placeholders can be abbreviated as {a} and {u}
        // For available placeholders and abbreviations see: TODO
        string memory result = fmt.format("The account {address} has {uint} wei", abi.encode(target, balance));

        expect(result).toEqual("The account 0x0000000000000000000000000000000000000001 has 1 wei");

        // Format is also used internally by Vulcan's println, which you can use as an alternative to console.log
        println("The account {address} has {uint} wei", abi.encode(target, balance));
    }
}

```

### Formatting decimals

Use the `{uint:dx}` placeholder to format numbers with decimals

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, accounts, expect, fmt} from "vulcan/test.sol";

contract FormatExample is Test {
    using accounts for address;

    function test() external {
        address target = address(1).setBalance(1e17);
        uint256 balance = target.balance;

        // Store it as a string
        string memory result = fmt.format("The account {address} has {uint:d18} eth", abi.encode(target, balance));

        expect(result).toEqual("The account 0x0000000000000000000000000000000000000001 has 0.1 eth");
    }
}

```

