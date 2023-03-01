# Commands

Execute external commands.

```solidity
import { Test, Command, commands } from "vulcan/test.sol";

contract TestMyContract is Test {
    using commands for *;

    function testMyContract() external {
        bytes memory res = commands.run(["echo", "Hello World"]);

        // Or

        Command memory cmd = commands.create("echo").arg("Hello World");
        res = cmd.run();
        res = cmd.run();
        res = cmd.run();
    }
}
```

### create

*Creates a new `Command` struct using the provided `input` as the executable.*


```solidity
function create(string memory input) internal pure returns (Command memory);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`input`|`string`|The name of the command.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`Command`|A new `Command` struct with the specified input.|


### arg


```solidity
function arg(Command memory self, string memory _arg) internal pure returns (Command memory);
```

### args


```solidity
function args(Command memory self, string[] memory _args) internal pure returns (Command memory);
```

### args


```solidity
function args(Command memory self, string[1] memory _args) internal pure returns (Command memory);
```

### args


```solidity
function args(Command memory self, string[2] memory _args) internal pure returns (Command memory);
```

### args


```solidity
function args(Command memory self, string[3] memory _args) internal pure returns (Command memory);
```

### args


```solidity
function args(Command memory self, string[4] memory _args) internal pure returns (Command memory);
```

### args


```solidity
function args(Command memory self, string[5] memory _args) internal pure returns (Command memory);
```

### args


```solidity
function args(Command memory self, string[6] memory _args) internal pure returns (Command memory);
```

### args


```solidity
function args(Command memory self, string[7] memory _args) internal pure returns (Command memory);
```

### args


```solidity
function args(Command memory self, string[8] memory _args) internal pure returns (Command memory);
```

### args


```solidity
function args(Command memory self, string[9] memory _args) internal pure returns (Command memory);
```

### args


```solidity
function args(Command memory self, string[10] memory _args) internal pure returns (Command memory);
```

### args


```solidity
function args(Command memory self, string[11] memory _args) internal pure returns (Command memory);
```

### args


```solidity
function args(Command memory self, string[12] memory _args) internal pure returns (Command memory);
```

### args


```solidity
function args(Command memory self, string[13] memory _args) internal pure returns (Command memory);
```

### args


```solidity
function args(Command memory self, string[14] memory _args) internal pure returns (Command memory);
```

### args


```solidity
function args(Command memory self, string[15] memory _args) internal pure returns (Command memory);
```

### args


```solidity
function args(Command memory self, string[16] memory _args) internal pure returns (Command memory);
```

### args


```solidity
function args(Command memory self, string[17] memory _args) internal pure returns (Command memory);
```

### args


```solidity
function args(Command memory self, string[18] memory _args) internal pure returns (Command memory);
```

### args


```solidity
function args(Command memory self, string[19] memory _args) internal pure returns (Command memory);
```

### args


```solidity
function args(Command memory self, string[20] memory _args) internal pure returns (Command memory);
```

### run

*Runs a command using the specified `Command` struct as parameters and returns the result.*


```solidity
function run(Command memory self) internal returns (bytes memory);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`self`|`Command`|The `Command` struct that holds the parameters of the command.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`bytes`|The result of the command as a bytes array.|


### run

*Runs a command with the specified `inputs` as parameters and returns the result.*


```solidity
function run(string[] memory inputs) internal returns (bytes memory);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`inputs`|`string[]`|An array of strings representing the parameters of the command.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`bytes`|The result of the command as a bytes array.|


### run


```solidity
function run(string[1] memory inputs) internal returns (bytes memory);
```

### run


```solidity
function run(string[2] memory inputs) internal returns (bytes memory);
```

### run


```solidity
function run(string[3] memory inputs) internal returns (bytes memory);
```

### run


```solidity
function run(string[4] memory inputs) internal returns (bytes memory);
```

### run


```solidity
function run(string[5] memory inputs) internal returns (bytes memory);
```

### run


```solidity
function run(string[6] memory inputs) internal returns (bytes memory);
```

### run


```solidity
function run(string[7] memory inputs) internal returns (bytes memory);
```

### run


```solidity
function run(string[8] memory inputs) internal returns (bytes memory);
```

### run


```solidity
function run(string[9] memory inputs) internal returns (bytes memory);
```

### run


```solidity
function run(string[10] memory inputs) internal returns (bytes memory);
```

### run


```solidity
function run(string[11] memory inputs) internal returns (bytes memory);
```

### run


```solidity
function run(string[12] memory inputs) internal returns (bytes memory);
```

### run


```solidity
function run(string[13] memory inputs) internal returns (bytes memory);
```

### run


```solidity
function run(string[14] memory inputs) internal returns (bytes memory);
```

### run


```solidity
function run(string[15] memory inputs) internal returns (bytes memory);
```

### run


```solidity
function run(string[16] memory inputs) internal returns (bytes memory);
```

### run


```solidity
function run(string[17] memory inputs) internal returns (bytes memory);
```

### run


```solidity
function run(string[18] memory inputs) internal returns (bytes memory);
```

### run


```solidity
function run(string[19] memory inputs) internal returns (bytes memory);
```

### run


```solidity
function run(string[20] memory inputs) internal returns (bytes memory);
```
