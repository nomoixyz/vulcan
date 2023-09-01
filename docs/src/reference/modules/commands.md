# Commands

#### **`create() → (Command)`**

Creates a new empty `Command` struct.

#### **`create(string input) → (Command)`**

Creates a new `Command` struct using the provided `input` as the executable.

#### **`arg(Command self, string _arg) → (Command)`**


#### **`args(Command self, string[] _args) → (Command)`**


#### **`args(Command self, string[1] _args) → (Command)`**


#### **`args(Command self, string[2] _args) → (Command)`**


#### **`args(Command self, string[3] _args) → (Command)`**


#### **`args(Command self, string[4] _args) → (Command)`**


#### **`args(Command self, string[5] _args) → (Command)`**


#### **`args(Command self, string[6] _args) → (Command)`**


#### **`args(Command self, string[7] _args) → (Command)`**


#### **`args(Command self, string[8] _args) → (Command)`**


#### **`args(Command self, string[9] _args) → (Command)`**


#### **`args(Command self, string[10] _args) → (Command)`**


#### **`args(Command self, string[11] _args) → (Command)`**


#### **`args(Command self, string[12] _args) → (Command)`**


#### **`args(Command self, string[13] _args) → (Command)`**


#### **`args(Command self, string[14] _args) → (Command)`**


#### **`args(Command self, string[15] _args) → (Command)`**


#### **`args(Command self, string[16] _args) → (Command)`**


#### **`args(Command self, string[17] _args) → (Command)`**


#### **`args(Command self, string[18] _args) → (Command)`**


#### **`args(Command self, string[19] _args) → (Command)`**


#### **`args(Command self, string[20] _args) → (Command)`**


#### **`run(Command self) → (CommandResult)`**

Runs a command using the specified `Command` struct as parameters and returns a `CommandResult`
struct.

#### **`run(string[] inputs) → (CommandResult)`**

Runs a command with the specified `inputs` as parameters and returns a `CommandResult` struct.

#### **`isOk(CommandResult self) → (bool)`**

Returns `true` if the command ran successfully and `false` otherwise.

#### **`isError(CommandResult self) → (bool)`**

Returns `true` if the command failed and `false` otherwise.

#### **`unwrap(CommandResult self) → (bytes)`**

Returns the output from `stdout` or reverts if the command failed to run.

#### **`expect(CommandResult self, string customError) → (bytes)`**

Returns the output from `stdout` or reverts with `customError` if the command failed to run.

#### **`run(string[1] inputs) → (CommandResult)`**


#### **`run(string[2] inputs) → (CommandResult)`**


#### **`run(string[3] inputs) → (CommandResult)`**


#### **`run(string[4] inputs) → (CommandResult)`**


#### **`run(string[5] inputs) → (CommandResult)`**


#### **`run(string[6] inputs) → (CommandResult)`**


#### **`run(string[7] inputs) → (CommandResult)`**


#### **`run(string[8] inputs) → (CommandResult)`**


#### **`run(string[9] inputs) → (CommandResult)`**


#### **`run(string[10] inputs) → (CommandResult)`**


#### **`run(string[11] inputs) → (CommandResult)`**


#### **`run(string[12] inputs) → (CommandResult)`**


#### **`run(string[13] inputs) → (CommandResult)`**


#### **`run(string[14] inputs) → (CommandResult)`**


#### **`run(string[15] inputs) → (CommandResult)`**


#### **`run(string[16] inputs) → (CommandResult)`**


#### **`run(string[17] inputs) → (CommandResult)`**


#### **`run(string[18] inputs) → (CommandResult)`**


#### **`run(string[19] inputs) → (CommandResult)`**


#### **`run(string[20] inputs) → (CommandResult)`**
