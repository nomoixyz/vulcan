# Fs

```solidity
struct FsMetadata {
    bool isDir;
    bool isSymlink;
    uint256 length;
    bool readOnly;
    uint256 modified;
    uint256 accessed;
    uint256 created;
}
```

#### **`readFile(string path) → (string )`**

Reads the file on `path` and returns its content as a `string`.

#### **`readFileBinary(string path) → (bytes )`**

Reads the file on `path` and returns its content as a `bytes`.

#### **`projectRoot() → (string )`**

Obtains the current project's root.

#### **`metadata(string fileOrDir) → (FsMetadata data)`**

Obtains the metadata of the specified file or directory.

#### **`readLine(string path) → (string )`**

Reads the next line of the file on `path`.

#### **`writeFile(string path, string data)`**

Modifies the content of the file on `path` with `data`.

#### **`writeFileBinary(string path, bytes data)`**

Modifies the content of the file on `path` with `data`.

#### **`writeLine(string path, string data)`**

Adds a new line to the file on `path`.

#### **`closeFile(string path)`**

Resets the state of the file on `path`.

#### **`removeFile(string path)`**

Deletes the file on `path`.

#### **`copyFile(string origin, string target)`**

Copies a file from `origin` to `target`.

#### **`moveFile(string origin, string target)`**

Moves a file from `origin` to `target`.

#### **`fileExists(string path) → (bool)`**

Checks if a file or directory exists.

#### **`getCode(string path) → (bytes )`**

Obtains the creation code from an artifact file located at `path`

#### **`getDeployedCode(string path) → (bytes )`**

Obtains the deployed code from an artifact file located at `path`


