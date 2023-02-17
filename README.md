![Vulcan](./assets/landscape.png)

## Install

```
forge install nomoixyz/vulcan
```

## Writting tests with Vulcan

```Solidity
import { Test, expect } from "vulcan/lib.sol";

contract TestSomething {
    function testSomething() external {
        expect(true).toBe(true);
        expect(123).toBeGreaterThanOrEqual(123);
        expect("Hello world!").not.toContain("Goodbye");
    }
}
```

## Modules

### Accounts

```Solidity
import { Test, accounts } from "vulcan/lib.sol";

contract TestMyContract is Test {
    using accounts for *;

    function testMyContract() external {
        address alice = accounts.create("Alice").setBalance(123).impersonate();

        // ...

        address bob = accounts.create("Bob").setBalance(456).impersonate();
    }
}
```

### Commands

```Solidity
import { Test, Command, commands } from "vulcan/lib.sol";

contract TestMyContract is Test {
    function testMyContract() external {
        bytes memory res = commands.run(["echo", "Hello World"]);

        // Or

        Command memory cmd = commands.create(["echo", "Hello World"]);
        res = cmd.run();
        res = cmd.run();
        res = cmd.run();
    }
}
```

### Console

```Solidity
TODO
```

### Context

```Solidity
import { Test, ctx } from "vulcan/lib.sol";

contract TestMyContract is Test {
    function testMyContract() external {
        ctx.setBlockTimestamp(123).setBlockNumber(456).setBlockDifficulty(789);

        uint256 snapshotId = ctx.snapshot();
        ctx.revertToSnapshot(snapshotId);
    }
}
```

### Env

```Solidity
import { Test, env } from "vulcan/lib.sol";

contract TestMyContract is Test {
    function testMyContract() external {
        env.set("MY_VAR", string("Hello World"));

        string memory MY_VAR = env.getString("MY_VAR");
    }
}
```

### Events

```Solidity
import { Test, events } from "vulcan/lib.sol";

contract TestMyContract is Test {
    function testMyContract() external {
        // TODO
    }
}
```

### Fs

```Solidity
import { Test, fs } from "vulcan/lib.sol";

contract TestMyContract is Test {
    function testMyContract() external {
        fs.write("test.txt", "Hello World");
        string memory content = fs.read("test.txt");
    }
}
```

### Json

```Solidity
import { Test, json } from "vulcan/lib.sol";

contract TestMyContract is Test {
    function testMyContract() external {
        // TODO
    }
}
```

### Strings

```Solidity
import { Test, strings } from "vulcan/lib.sol";

contract TestMyContract is Test {
    function testMyContract() external {
        // TODO
    }
}
```

### Watchers

```Solidity
import { Test, watchers, expect } from "vulcan/lib.sol";

contract TestMyContract is Test {
    using watchers for *;
    function testMyContract() external {
        MyContract mc = new MyContract();

        address(mc).watch().caputureReverts();

        mc.doSomething();

        expect(address(mc).calls[0]).toHaveRevertedWith("Something went wrong");
    }
}
```

### Expect

```Solidity
```