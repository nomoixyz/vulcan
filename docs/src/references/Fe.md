# Fe

## Structs

### Fe

```solidity
struct Fe {
	string compilerPath
	string filePath
	string outputDir
	bool overwrite
}
```



## fe



### **create() &rarr; (Fe)**

Creates a new `Fe` struct with default values.

### **build(Fe self) &rarr; (CommandResult)**

Builds a binary file from a `.fe` file.

### **toCommand(Fe self) &rarr; (Command)**

Transforms a `Fe` struct to a `Command` struct.

### **setCompilerPath(Fe self, string compilerPath) &rarr; (Fe)**

Sets the `fe` compiler path.

### **setFilePath(Fe self, string filePath) &rarr; (Fe)**

Sets the `fe` file path to build.

### **setOutputDir(Fe self, string outputDir) &rarr; (Fe)**

Sets the `fe` build command output directory.

### **setOverwrite(Fe self, bool overwrite) &rarr; (Fe)**

Sets the `fe` build command overwrite flag.

### **getBytecode(Fe self, string contractName) &rarr; (BytesResult)**

Obtains the bytecode of a compiled contract with `contractName`.

