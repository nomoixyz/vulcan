# Huff

## Structs

### Huffc

```solidity
struct Huffc {
	string compilerPath
	string filePath
	string outputPath
	string mainName
	string constructorName
	bool onlyRuntime
	string[] constantOverrides
}
```



## huff



### **create() &rarr; (Huffc)**



### **compile(Huffc self) &rarr; (CommandResult)**



### **toCommand(Huffc self) &rarr; (Command)**



### **setCompilerPath(Huffc self, string compilerPath) &rarr; (Huffc)**



### **setFilePath(Huffc self, string filePath) &rarr; (Huffc)**



### **setOutputPath(Huffc self, string outputPath) &rarr; (Huffc)**



### **setMainName(Huffc self, string mainName) &rarr; (Huffc)**



### **setConstructorName(Huffc self, string constructorName) &rarr; (Huffc)**



### **setOnlyRuntime(Huffc self, bool onlyRuntime) &rarr; (Huffc)**



### **addConstantOverride(Huffc self, string const, bytes32 value) &rarr; (Huffc)**



