# Fe

#### **`create() → (Fe)`**

Creates a new `Fe` struct with the following defaults.

```solidity
Fe({
    compilerPath: "fe",
    filePath: "",
    outputDir: "",
    overwrite: false
});
```

> Notice: The `filePath` is the only required field, if it is empty, `.build` and `.toCommand`
> will revert.

#### **`build(Fe self) → (bytes)`**

Builds a binary file from a `.fe` file.

#### **`toCommand(Fe self) → (Command)`**

Converts the `Fe` struct into a `Command` struct.

#### **`setCompilerPath(Fe self, string compilerPath) → (Fe)`**

Overwrites the compiler path.

#### **`setFilePath(Fe self, string filePath) → (Fe)`**

Overwrites the file path.

#### **`setOutputDir(Fe self, string outputDir) → (Fe)`**

Overwrites the default artifacts directory.

#### **`setOverwrite(Fe memory self, bool overwrite) → (Fe)`**

Sets the build command overwrite flag. If `true` the contents of `outputDir` will be overwritten.

#### **`getBytecode(Fe memory self, string contractName) → (bytes)`**

Returns the bytecode from a compiled `Fe` contract.
