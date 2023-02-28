# Accounts

Account operations (balances, impersonation, etc.)

```solidity
import { Test, accounts } from "vulcan/test.sol";

contract TestMyContract is Test {
    using accounts for *;

    function testMyContract() external {
        address alice = accounts.create("Alice").setBalance(123).impersonate();

        // ...

        address bob = accounts.create("Bob").setBalance(456).impersonate();
    }
}
```

### readStorage

*Reads the storage at the specified `slot` for the given `who` address and returns the content.*


```solidity
function readStorage(address who, bytes32 slot) internal view returns (bytes32);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`who`|`address`|The address whose storage will be read.|
|`slot`|`bytes32`|The position of the storage slot to read.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`bytes32`|The contents of the specified storage slot as a bytes32 value.|


### sign

*Signs the specified `digest` using the provided `privKey` and returns the signature in the form of `(v, r, s)`.*


```solidity
function sign(uint256 privKey, bytes32 digest) internal pure returns (uint8, bytes32, bytes32);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`privKey`|`uint256`|The private key to use for signing the digest.|
|`digest`|`bytes32`|The message digest to sign.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`uint8`|A tuple containing the signature parameters `(v, r, s)` as a `uint8`, `bytes32`, and `bytes32`, respectively.|
|`<none>`|`bytes32`||
|`<none>`|`bytes32`||


### derive

*Derives the Ethereum address corresponding to the provided `privKey`.*


```solidity
function derive(uint256 privKey) internal pure returns (address);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`privKey`|`uint256`|The private key to use for deriving the Ethereum address.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`address`|The Ethereum address derived from the provided private key.|


### deriveKey

*Derives the private key corresponding to the specified `mnemonicOrPath` and `index`.*


```solidity
function deriveKey(string memory mnemonicOrPath, uint32 index) internal pure returns (uint256);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`mnemonicOrPath`|`string`|The mnemonic or derivation path to use for deriving the private key.|
|`index`|`uint32`|The index of the derived private key to retrieve.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`uint256`|The private key derived from the specified mnemonic and index as a `uint256` value.|


### deriveKey

*Derives the private key corresponding to the specified `mnemonicOrPath`, `derivationPath`, and `index`.*


```solidity
function deriveKey(string memory mnemonicOrPath, string memory derivationPath, uint32 index)
    internal
    pure
    returns (uint256);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`mnemonicOrPath`|`string`|The mnemonic or derivation path to use for deriving the master key.|
|`derivationPath`|`string`|The specific derivation path to use for deriving the private key (optional).|
|`index`|`uint32`|The index of the derived private key to retrieve.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`uint256`|The private key derived from the specified mnemonic, derivation path, and index as a `uint256` value.|


### rememberKey

*Adds the specified `privKey` to the local forge wallet.*


```solidity
function rememberKey(uint256 privKey) internal returns (address);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`privKey`|`uint256`|The private key to add to the local forge wallet.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`address`|The Ethereum address corresponding to the added private key.|


### getNonce

*Returns the current `nonce` of the specified `who` address.*


```solidity
function getNonce(address who) internal view returns (uint64);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`who`|`address`|The address for which to obtain the current `nonce`.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`uint64`|The current `nonce` of the specified address as a `uint64` value.|


### recordStorage

*Starts recording all storage reads and writes for later analysis.*


```solidity
function recordStorage() internal;
```

### getStorageAccesses

*Obtains an array of slots that have been read and written for the specified address `who`.*


```solidity
function getStorageAccesses(address who) internal returns (bytes32[] memory reads, bytes32[] memory writes);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`who`|`address`|The address for which to obtain the storage accesses.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`reads`|`bytes32[]`|An array of storage slots that have been read.|
|`writes`|`bytes32[]`|An array of storage slots that have been written.|


### label

*Adds a label to the specified address `who` for identification purposes in debug traces.*


```solidity
function label(address who, string memory lbl) internal returns (address);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`who`|`address`|The address to label.|
|`lbl`|`string`|The label to apply to the address.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`address`|The same address that was passed as input.|


### create

*Creates an address using the hash of the specified `name` as the private key and adds a label to the address.*


```solidity
function create(string memory name) internal returns (address);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`name`|`string`|The name to use as the basis for the address.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`address`|The newly created address.|


### create

*Creates an address using the hash of the specified `name` as the private key and adds a label to the address.*


```solidity
function create(string memory name, string memory lbl) internal returns (address);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`name`|`string`|The name to use as the basis for the address.|
|`lbl`|`string`|The label to apply to the address.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`address`|The newly created address.|


### setStorage

*Sets the specified `slot` in the storage of the given `self` address to the provided `value`.*


```solidity
function setStorage(address self, bytes32 slot, bytes32 value) internal returns (address);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`self`|`address`|The address to modify the storage of.|
|`slot`|`bytes32`|The storage slot to set.|
|`value`|`bytes32`|The value to set the storage slot to.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`address`|The address that was modified.|


### setNonce

*Sets the nonce of the given `self` address to the provided value `n`.*


```solidity
function setNonce(address self, uint64 n) internal returns (address);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`self`|`address`|The address to set the nonce for.|
|`n`|`uint64`|The value to set the nonce to.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`address`|The updated address with the modified nonce.|


### impersonateOnce

*Sets the `msg.sender` of the next call to `self`.*


```solidity
function impersonateOnce(address self) internal returns (address);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`self`|`address`|The address to impersonate.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`address`|The address that was impersonated.|


### impersonate

Sets the `msg.sender` of all subsequent calls to `self` until `stopImpersonate` is called


```solidity
function impersonate(address self) internal returns (address);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`self`|`address`|The address to impersonate.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`address`|The address being impersonated.|


### impersonateOnce

*Sets the `msg.sender` of the next call to `self` and the `tx.origin`
to `origin`.*


```solidity
function impersonateOnce(address self, address origin) internal returns (address);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`self`|`address`|The address to impersonate.|
|`origin`|`address`|The new `tx.origin`.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`address`|The address that was impersonated.|


### impersonate

*Sets the `msg.sender` and `tx.origin` of all the subsequent calls to `self` and `origin`
respectively until `stopImpersonate` is called.*


```solidity
function impersonate(address self, address origin) internal returns (address);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`self`|`address`|The address to impersonate.|
|`origin`|`address`|The new value for `tx.origin`.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`address`|The address being impersonated.|


### stopImpersonate

Resets the values of `msg.sender` and `tx.origin` to the original values.


```solidity
function stopImpersonate() internal;
```

### setBalance

*Sets the balance of an address and returns the address that was modified.*


```solidity
function setBalance(address self, uint256 bal) internal returns (address);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`self`|`address`|The address to set the balance of.|
|`bal`|`uint256`|The new balance to set.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`address`|The address that was modified.|


### setCode

*Sets the code of an address.*


```solidity
function setCode(address self, bytes memory code) internal returns (address);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`self`|`address`|The address to set the code for.|
|`code`|`bytes`|The new code to set for the address.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`address`|The address that was modified.|
