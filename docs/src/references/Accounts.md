# Accounts

## accountsSafe

Accounts module for scripts

### **readStorage(address who, bytes32 slot) &rarr; (bytes32)**

Reads the storage at the specified `slot` for the given `who` address and returns the content.

### **sign(uint256 privKey, bytes32 digest) &rarr; (uint8, bytes32, bytes32)**

Signs the specified `digest` using the provided `privKey` and returns the signature in the form of `(v, r, s)`.

### **derive(uint256 privKey) &rarr; (address)**

Derives the Ethereum address corresponding to the provided `privKey`.

### **deriveKey(string mnemonicOrPath, uint32 index) &rarr; (uint256)**

Derives the private key corresponding to the specified `mnemonicOrPath` and `index`.

### **deriveKey(string mnemonicOrPath, string derivationPath, uint32 index) &rarr; (uint256)**

Derives the private key corresponding to the specified `mnemonicOrPath`, `derivationPath`, and `index`.

### **rememberKey(uint256 privKey) &rarr; (address)**

Adds the specified `privKey` to the local forge wallet.

### **getNonce(address who) &rarr; (uint64)**

Returns the current `nonce` of the specified `who` address.

### **recordStorage()**

Starts recording all storage reads and writes for later analysis.

### **getStorageAccesses(address who) &rarr; (bytes32[] reads, bytes32[] writes)**

Obtains an array of slots that have been read and written for the specified address `who`.

### **label(address who, string lbl) &rarr; (address)**

Adds a label to the specified address `who` for identification purposes in debug traces.

### **create() &rarr; (address)**

Creates an address without label.

### **create(string name) &rarr; (address)**

Creates an address using the hash of the specified `name` as the private key and adds a label to the address.

### **create(string name, string lbl) &rarr; (address)**

Creates an address using the hash of the specified `name` as the private key and adds a label to the address.

### **getDeploymentAddress(address who, uint64 nonce) &rarr; (address)**

Calculates the deployment address of `who` with nonce `nonce`.

### **getDeploymentAddress(address who) &rarr; (address)**

Calculates the deployment address of `who` with the current nonce.

### **createMany(uint256 length) &rarr; (address[])**

Generates an array of addresses with a specific length.

### **createMany(uint256 length, string prefix) &rarr; (address[])**

Generates an array of addresses with a specific length and a prefix as label.
The label for each address will be `{prefix}_{i}`.

## accountsUnsafe

Accounts module for tests

### **stdStore() &rarr; (StdStorage s)**



### **readStorage(address who, bytes32 slot) &rarr; (bytes32)**



### **sign(uint256 privKey, bytes32 digest) &rarr; (uint8, bytes32, bytes32)**



### **derive(uint256 privKey) &rarr; (address)**



### **deriveKey(string mnemonicOrPath, uint32 index) &rarr; (uint256)**



### **deriveKey(string mnemonicOrPath, string derivationPath, uint32 index) &rarr; (uint256)**



### **rememberKey(uint256 privKey) &rarr; (address)**



### **getNonce(address who) &rarr; (uint64)**



### **recordStorage()**



### **getStorageAccesses(address who) &rarr; (bytes32[] reads, bytes32[] writes)**



### **label(address who, string lbl) &rarr; (address)**



### **create() &rarr; (address)**



### **create(string name) &rarr; (address)**



### **create(string name, string lbl) &rarr; (address)**



### **getDeploymentAddress(address who, uint64 nonce) &rarr; (address)**

Calculates the deployment address of `who` with nonce `nonce`.

### **getDeploymentAddress(address who) &rarr; (address)**

Calculates the deployment address of `who` with the current nonce.

### **setStorage(address self, bytes32 slot, bytes32 value) &rarr; (address)**

Sets the specified `slot` in the storage of the given `self` address to the provided `value`.

### **setNonce(address self, uint64 n) &rarr; (address)**

Sets the nonce of the given `self` address to the provided value `n`. It will revert if

### **setNonceUnsafe(address self, uint64 n) &rarr; (address)**

Sets the nonce of the given `self` address to the arbitrary provided value `n`.

### **impersonateOnce(address self) &rarr; (address)**

Sets the `msg.sender` of the next call to `self`.

### **impersonate(address self) &rarr; (address)**



### **impersonateOnce(address self, address origin) &rarr; (address)**

Sets the `msg.sender` of the next call to `self` and the `tx.origin`
to `origin`.

### **impersonate(address self, address origin) &rarr; (address)**

Sets the `msg.sender` and `tx.origin` of all the subsequent calls to `self` and `origin`
respectively until `stopImpersonate` is called.

### **stopImpersonate()**



### **setBalance(address self, uint256 bal) &rarr; (address)**

Sets the balance of an address and returns the address that was modified.

### **mintToken(address self, address token, uint256 amount) &rarr; (address)**

Mints an amount of tokens to an address. This operation modifies the total supply of the token.
self The address that will own the tokens.
token The token to mint.
amount The amount of tokens to mint.

### **burnToken(address self, address token, uint256 amount) &rarr; (address)**

Burns an amount of tokens from an address. This operation modifies the total supply of the token.
self The address that owns the tokens.
token The token to burn.
amount The amount of tokens to burn.

### **setTokenBalance(address self, address token, uint256 bal) &rarr; (address)**

Sets the token balance of an address.

### **setCode(address self, bytes code) &rarr; (address)**

Sets the code of an address.

### **createMany(uint256 length) &rarr; (address[])**

Generates an array of addresses with a specific length.

### **createMany(uint256 length, string prefix) &rarr; (address[])**

Generates an array of addresses with a specific length and a prefix as label.
The label for each address will be `{prefix}_{i}`.

