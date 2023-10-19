# Fs

## Custom types

### FsMetadataResult

```solidity
type FsMetadataResult is bytes32;
```



## Structs

### FsMetadata

```solidity
struct FsMetadata {
	bool isDir
	bool isSymlink
	uint256 length
	bool readOnly
	uint256 modified
	uint256 accessed
	uint256 created
}
```



## Functions

### **Ok(FsMetadata value) &rarr; (FsMetadataResult)**



## fs



### **readFile(string path) &rarr; (StringResult)**

Reads the file on `path` and returns its content as a `StringResult`.

### **readFileBinary(string path) &rarr; (BytesResult)**

Reads the file on `path` and returns its content as a `BytesResult`.

### **projectRoot() &rarr; (StringResult)**

Obtains the current project's root.

### **metadata(string fileOrDir) &rarr; (FsMetadataResult)**

Obtains the metadata of the specified file or directory.

### **readLine(string path) &rarr; (StringResult)**

Reads the next line of the file on `path`.

### **writeFile(string path, string data) &rarr; (EmptyResult)**

Modifies the content of the file on `path` with `data`.

### **writeFileBinary(string path, bytes data) &rarr; (EmptyResult)**

Modifies the content of the file on `path` with `data`.

### **writeLine(string path, string data) &rarr; (EmptyResult)**

Adds a new line to the file on `path`.

### **closeFile(string path) &rarr; (EmptyResult)**

Resets the state of the file on `path`.

### **removeFile(string path) &rarr; (EmptyResult)**

Deletes the file on `path`.

### **copyFile(string origin, string target) &rarr; (EmptyResult)**

Copies a file from `origin` to `target`.

### **moveFile(string origin, string target) &rarr; (EmptyResult)**

Moves a file from `origin` to `target`.

### **fileExists(string path) &rarr; (BoolResult)**

Checks if a file or directory exists.

### **getCode(string path) &rarr; (BytesResult)**

Obtains the creation code from an artifact file located at `path`

### **getDeployedCode(string path) &rarr; (BytesResult)**

Obtains the deployed code from an artifact file located at `path`

## FsErrors



### **FailedToRead(string reason) &rarr; (Error)**



### **FailedToReadLine(string reason) &rarr; (Error)**



### **FailedToReadMetadata(string reason) &rarr; (Error)**



### **FailedToGetProjectRoot(string reason) &rarr; (Error)**



### **Forbidden(string reason) &rarr; (Error)**



### **FailedToWrite(string reason) &rarr; (Error)**



### **FailedToWriteLine(string reason) &rarr; (Error)**



### **FailedToCloseFile(string reason) &rarr; (Error)**



### **FailedToRemoveFile(string reason) &rarr; (Error)**



### **FailedToGetCode(string reason) &rarr; (Error)**



### **toFsMetadataResult(Error self) &rarr; (FsMetadataResult)**



### **toEmptyResult(Error self) &rarr; (EmptyResult)**



## LibFsMetadataPointer



### **toFsMetadata(Pointer self) &rarr; (FsMetadata metadata)**



### **toFsMetadataResult(Pointer self) &rarr; (FsMetadataResult ptr)**



### **toPointer(FsMetadata self) &rarr; (Pointer ptr)**



## LibFsMetadataResult



### **isOk(FsMetadataResult self) &rarr; (bool)**



### **isError(FsMetadataResult self) &rarr; (bool)**



### **unwrap(FsMetadataResult self) &rarr; (FsMetadata val)**



### **expect(FsMetadataResult self, string err) &rarr; (FsMetadata)**



### **toError(FsMetadataResult self) &rarr; (Error)**



### **toValue(FsMetadataResult self) &rarr; (FsMetadata val)**



### **toPointer(FsMetadataResult self) &rarr; (Pointer)**



