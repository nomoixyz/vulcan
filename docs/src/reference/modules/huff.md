# Huff

#### **`create() → (Huffc)`**

Creates a new `Huffc` struct with the following defaults.

```solidity
Huffc({
    compilerPath: "huffc",
    filePath: "",
    outputPath: "",
    mainName: "",
    constructorName: "",
    onlyRuntime: false,
    constantOverrides: new string[](0)
});
```

> Notice: The `filePath` is the only required field, if it is empty, `.compile` and `.toCommand`
> will revert.

#### **`compile(Huffc self) → (bytes)`**

Compiles the huff contract, returning either the runtime code or initcode.

#### **`toCommand(Huffc self) → (Command)`**

Converts the `Huffc` struct into a `Command` struct.

#### **`setCompilerPath(Huffc self, string compilerPath) → (Huffc)`**

Overwrites the compiler path.

#### **`setFilePath(Huffc self, string filePath) → (Huffc)`**

Overwrites the file path.

#### **`setOutputPath(Huffc self, string outputPath) → (Huffc)`**

Overwrites the default artifacts directory and enables JSON artifact generation.

#### **`setMainName(Huffc self, string mainName) → (Huffc)`**

Overwrites the default `MAIN` macro, or entry point. The `mainName` must be a macro name in the
source file.

#### **`setConstructorName(Huffc self, string constructorName) → (Huffc)`**

Overwrites the default `CONSTRUCTOR` macro, or initcode. The `constructorName` must be a macro name
in the source file.

#### **`setOnlyRuntime(Huffc self, bool onlyRuntime) → (Huffc)`**

Sets whether to return the initcode or runtime code at compile time. A `true` value will return only
the runtime code.

#### **`addConstantOverride(Huffc self, string const, bytes32 value) → (Huffc)`**

Adds a constant value override. The `const` string must be a constant name in the source file.
