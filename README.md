![Vulcan](./assets/landscape.png)

## WARNING

This library should be treated as highly experimental, its API WILL change, and there might be bugs in it. Don't use in production yet.

## Install

```
forge install nomoixyz/vulcan
```

## Writing tests with Vulcan

```Solidity
import { Test, expect } from "vulcan/lib.sol";

contract TestSomething is Test {

    function before() internal override { } // Optional

    function beforeEach() internal override { } // Optional

    function testSomething() external {
        expect(true).toBeTrue();
        expect(true).toEqual(true);
        expect(123).toBeGreaterThanOrEqual(123);
        expect(123).not.toEqual(321);
        expect("Hello world!").toContain("Hello");

        MyContract mc = new MyContract();
        address(mc).watch().captureReverts();
        mc.doSomething();

        expect(address(mc).calls[0]).toHaveRevertedWith("Something went wrong");
    }
}
```

## Modules

### Accounts

Account operations (balances, impersonation, etc.)

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

Execute external commands.

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

Print to the console.

```Solidity
import { Test, console } from "vulcan/lib.sol";

contract TestMyContract is Test {
    function testMyContract() external {
        // Same API as forge-std's console2
        console.log("Hello World");
    }
}
```

### Context

Functionality to change the current block data.

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

Set and read environmental variables.

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

// TODO

```Solidity
import { Test, events } from "vulcan/lib.sol";

contract TestMyContract is Test {
    using events for *;

    function testMyContract() external {
        // TODO
    }
}
```

### Fs

Filesystem access.

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

Manipulate JSON data.

```Solidity
import { Test, JsonObject, json } from "vulcan/lib.sol";

contract TestMyContract is Test {
    function testMyContract() external {
        JsonObject memory obj = json.create();
        obj.serialize("foo", true);
        expect(obj.serialized).toEqual('{"foo":true}');
    }
}
```

### Strings

Convert basic types from / to strings.

```Solidity
import { Test, strings } from "vulcan/lib.sol";

contract TestMyContract is Test {
    using strings for *;

    function testMyContract() external {
        uint256 val = 1;

        expect(val.toString()).toEqual("1");

        expect("1".parseUint()).toEqual(1);
    }
}
```

### Watchers

Monitor contract calls.

Watchers work by replacing an address code with a proxy contract that records all calls and events.

```Solidity
import { Test, watchers, expect, any } from "vulcan/lib.sol";

contract TestMyContract is Test {
    using watchers for *;
    function testMyContract() external {
        MyContract mc = new MyContract();

        address(mc).watch().captureReverts();

        mc.doSomething();
        mc.doSomethingElse();

        expect(address(mc).calls.length).toEqual(2);
        expect(address(mc).calls[0]).toHaveRevertedWith("Something went wrong");
        expect(address(mc).calls[1]).toHaveEmitted(
            "SomeEvent(address,bytes32,uint256)",
            [address(1).topic(), any()], // Event topics (indexed arguments)
            abi.encode(123) // Event data
        );
    }
}
```
