## Examples
### Create an address

This example shows how to create an address

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, expect, accounts} from "vulcan/test.sol";

contract AccountsExample01 is Test {
    function test() external {
        address alice = accounts.create();

        expect(alice).not.toEqual(address(0));
    }
}

```

### Create a labeled address

This example shows how to create an address labeled as "Alice"

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, expect, accounts} from "vulcan/test.sol";

contract AccountsExample02 is Test {
    function test() external {
        address alice = accounts.create("Alice");

        expect(alice).not.toEqual(address(0));
    }
}

```

### Create multiple addresses

This example shows how to create multiple addresses

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, expect, accounts} from "vulcan/test.sol";

contract AccountsExample03 is Test {
    function test() external {
        address[] memory addresses = accounts.createMany(10);

        expect(addresses.length).toEqual(10);
    }
}

```

### Create multiple labeled addresses with a prefix

This example shows how to create multiple addresses labeled with the prefix `Account`

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, expect, accounts} from "vulcan/test.sol";

contract AccountsExample04 is Test {
    function test() external {
        address[] memory addresses = accounts.createMany(10, "Account");

        expect(addresses.length).toEqual(10);
    }
}

```

### Use method chaining on addresses

This example shows how to use method chaining on addresses

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, expect, accounts} from "vulcan/test.sol";

contract AccountsExample05 is Test {
    using accounts for address;

    function test() external {
        address alice = accounts.create("Alice").setNonce(666).setBalance(100e18);

        address bob = accounts.create("Bob").setBalance(10e18).impersonateOnce();

        payable(alice).transfer(bob.balance);

        expect(alice.balance).toEqual(110e18);
        expect(alice.getNonce()).toEqual(666);
        expect(bob.balance).toEqual(0);
    }
}

```

