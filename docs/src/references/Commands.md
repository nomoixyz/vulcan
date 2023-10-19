# Commands

## Custom types

### CommandResult

```solidity
type CommandResult is bytes32;
```



## Structs

### Command

```solidity
struct Command {
	string[] inputs
}
```

Struct used to hold command parameters. Useful for creating commands that can be run
multiple times

### CommandOutput

```solidity
struct CommandOutput {
	int32 exitCode
	bytes stdout
	bytes stderr
	Command command
}
```



## Functions

### **Ok(CommandOutput value) &rarr; (CommandResult)**



## commands



### **create() &rarr; (Command cmd)**

Creates a new 'Command' struct with empty arguments.

### **create(string input) &rarr; (Command)**

Creates a new `Command` struct using the provided `input` as the executable.

### **arg(Command self, string _arg) &rarr; (Command)**



### **args(Command self, string[] _args) &rarr; (Command)**



### **args(Command self, string[1] _args) &rarr; (Command)**



### **args(Command self, string[2] _args) &rarr; (Command)**



### **args(Command self, string[3] _args) &rarr; (Command)**



### **args(Command self, string[4] _args) &rarr; (Command)**



### **args(Command self, string[5] _args) &rarr; (Command)**



### **args(Command self, string[6] _args) &rarr; (Command)**



### **args(Command self, string[7] _args) &rarr; (Command)**



### **args(Command self, string[8] _args) &rarr; (Command)**



### **args(Command self, string[9] _args) &rarr; (Command)**



### **args(Command self, string[10] _args) &rarr; (Command)**



### **args(Command self, string[11] _args) &rarr; (Command)**



### **args(Command self, string[12] _args) &rarr; (Command)**



### **args(Command self, string[13] _args) &rarr; (Command)**



### **args(Command self, string[14] _args) &rarr; (Command)**



### **args(Command self, string[15] _args) &rarr; (Command)**



### **args(Command self, string[16] _args) &rarr; (Command)**



### **args(Command self, string[17] _args) &rarr; (Command)**



### **args(Command self, string[18] _args) &rarr; (Command)**



### **args(Command self, string[19] _args) &rarr; (Command)**



### **args(Command self, string[20] _args) &rarr; (Command)**



### **toString(Command self) &rarr; (string)**

Transforms a command to its string representation.

### **run(Command self) &rarr; (CommandResult)**

Runs a command using the specified `Command` struct as parameters and returns the result.

### **run(string[] inputs) &rarr; (CommandResult)**

Runs a command with the specified `inputs` as parameters and returns the result.

### **run(string[1] inputs) &rarr; (CommandResult)**



### **run(string[2] inputs) &rarr; (CommandResult)**



### **run(string[3] inputs) &rarr; (CommandResult)**



### **run(string[4] inputs) &rarr; (CommandResult)**



### **run(string[5] inputs) &rarr; (CommandResult)**



### **run(string[6] inputs) &rarr; (CommandResult)**



### **run(string[7] inputs) &rarr; (CommandResult)**



### **run(string[8] inputs) &rarr; (CommandResult)**



### **run(string[9] inputs) &rarr; (CommandResult)**



### **run(string[10] inputs) &rarr; (CommandResult)**



### **run(string[11] inputs) &rarr; (CommandResult)**



### **run(string[12] inputs) &rarr; (CommandResult)**



### **run(string[13] inputs) &rarr; (CommandResult)**



### **run(string[14] inputs) &rarr; (CommandResult)**



### **run(string[15] inputs) &rarr; (CommandResult)**



### **run(string[16] inputs) &rarr; (CommandResult)**



### **run(string[17] inputs) &rarr; (CommandResult)**



### **run(string[18] inputs) &rarr; (CommandResult)**



### **run(string[19] inputs) &rarr; (CommandResult)**



### **run(string[20] inputs) &rarr; (CommandResult)**



## CommandError



### **NotExecuted(string reason) &rarr; (Error)**



### **toCommandResult(Error self) &rarr; (CommandResult)**



## LibCommandOutputPointer



### **toCommandOutput(Pointer self) &rarr; (CommandOutput output)**



### **toCommandResult(Pointer self) &rarr; (CommandResult result)**



### **toPointer(CommandOutput self) &rarr; (Pointer ptr)**



## LibCommandResult



### **isOk(CommandResult self) &rarr; (bool)**



### **isError(CommandResult self) &rarr; (bool)**



### **unwrap(CommandResult self) &rarr; (CommandOutput)**



### **expect(CommandResult self, string err) &rarr; (CommandOutput)**



### **toError(CommandResult self) &rarr; (Error)**



### **toValue(CommandResult self) &rarr; (CommandOutput)**



### **toPointer(CommandResult self) &rarr; (Pointer)**



