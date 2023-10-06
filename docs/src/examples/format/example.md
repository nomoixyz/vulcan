## Examples
### Using templates

This example shows how to use templates with the `format` module

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, accounts, expect, fmt} from "vulcan/test.sol";

contract FormatExample01 is Test {
    using accounts for address;

    function test() external {
        address target = address(1).setBalance(1);
        uint256 balance = target.balance;

        expect(fmt.format("The account {address} has {uint} wei", abi.encode(target, balance))).toEqual(
            "The account 0x0000000000000000000000000000000000000001 has 1 wei"
        );
    }
}

```

### Formatting decimals

This example shows how to use the `{uint:dx}` placeholder to format numbers with decimals

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, accounts, expect, fmt} from "vulcan/test.sol";

contract FormatExample02 is Test {
    using accounts for address;

    function test() external {
        address target = address(1).setBalance(1e17);
        uint256 balance = target.balance;

        expect(fmt.format("The account {address} has {uint:d18} eth", abi.encode(target, balance))).toEqual(
            "The account 0x0000000000000000000000000000000000000001 has 0.1 eth"
        );
    }
}

```

