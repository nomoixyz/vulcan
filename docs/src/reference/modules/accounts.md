# Accounts

#### **`readStorage(address who, bytes32 slot) → (bytes32)`**

Reads the storage at the specified `slot` for the given `who` address and returns the content.

#### **`sign(uint256 privKey, bytes32 digest) → (uint8, bytes32, bytes32)`**

Signs the specified `digest` using the provided `privKey` and returns the signature in the form of `(v, r, s)`.

#### **`derive(uint256 privKey) → (address)`**

Derives the Ethereum address corresponding to the provided `privKey`.

#### **`deriveKey(string mnemonicOrPath, uint32 index) → (uint256)`**

Derives the private key corresponding to the specified `mnemonicOrPath` and `index`.

#### **`deriveKey(string mnemonicOrPath, string derivationPath, uint32 index) → (uint256)`**

Derives the private key corresponding to the specified `mnemonicOrPath`, `derivationPath`, and `index`.

#### **`rememberKey(uint256 privKey) → (address)`**

Adds the specified `privKey` to the local forge wallet.

#### **`getNonce(address who) → (uint64)`**

Returns the current `nonce` of the specified `who` address.

#### **`recordStorage()`**

Starts recording all storage reads and writes for later analysis.

#### **`getStorageAccesses(address who) → (bytes32[] reads, bytes32[] writes)`**

Obtains an array of slots that have been read and written for the specified address `who`.

#### **`label(address who, string lbl) → (address)`**

Adds a label to the specified address `who` for identification purposes in debug traces.

#### **`create(string name) → (address)`**

Creates an address using the hash of the specified `name` as the private key and adds a label to the address.

#### **`create(string name, string lbl) → (address)`**

Creates an address using the hash of the specified `name` as the private key and adds a label to the address.

#### **`setStorage(address self, bytes32 slot, bytes32 value) → (address)`**

Sets the specified `slot` in the storage of the given `self` address to the provided `value`.

#### **`setNonce(address self, uint64 n) → (address)`**

Sets the nonce of the given `self` address to the provided value `n`.

#### **`impersonateOnce(address self) → (address)`**

Sets the `msg.sender` of the next call to `self`.

#### **`impersonate(address self) → (address)`**

Sets the `msg.sender` of all subsequent calls to `self` until `stopImpersonate` is called


#### **`impersonateOnce(address self, address origin) → (address)`**

Sets the `msg.sender` of the next call to `self` and the `tx.origin`
to `origin`.

#### **`impersonate(address self, address origin) → (address)`**

Sets the `msg.sender` and `tx.origin` of all the subsequent calls to `self` and `origin`
respectively until `stopImpersonate` is called.

#### **`stopImpersonate()`**

Resets the values of `msg.sender` and `tx.origin` to the original values.


#### **`setBalance(address self, uint256 bal) → (address)`**

Sets the balance of an address and returns the address that was modified.

#### **`mintToken(address self, address token, uint256 amount) → (address)`**

Mints an amount of tokens to an address. This operation modifies the total supply of the token.
self The address that will own the tokens.
token The token to mint.
amount The amount of tokens to mint.

#### **`burnToken(address self, address token, uint256 amount) → (address)`**

Burns an amount of tokens from an address.This operation modifies the total supply of the token.
self The address that owns the tokens.
token The token to burn.
amount The amount of tokens to burn.

#### **`setTokenBalance(address self, address token, uint256 bal) → (address)`**

Sets the token balance of an address.

#### **`setTotalSupply(address token, uint256 totalSupply) private → (address)`**

Sets the token total supply of a token.

#### **`setCode(address self, bytes code) → (address)`**

Sets the code of an address.

