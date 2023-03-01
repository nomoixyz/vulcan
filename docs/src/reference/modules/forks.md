# Forks

Forking functionality.

```solidity
import { Test, forks, Fork } from "vulcan/test.sol";

contract TestMyContract is Test {
    function testMyContract() external {
        Fork fork = forks.create("mainnet"); // Alternatively an endpoint can be passed directly.
    }
}
```

### create

*Create a new fork using the provided endpoint.*


```solidity
function create(string memory endpoint) internal returns (Fork);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`endpoint`|`string`|The endpoint to use for the fork.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`Fork`|The new fork pointer.|


### createAtBlock

*Create a new fork using the provided endpoint at a given block number.*


```solidity
function createAtBlock(string memory endpoint, uint256 blockNumber) internal returns (Fork);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`endpoint`|`string`|The endpoint to use for the fork.|
|`blockNumber`|`uint256`|The block number to fork from.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`Fork`|The new fork pointer.|


### createBeforeTx

*Create a new fork using the provided endpoint at a state right before the provided transaction hash.*


```solidity
function createBeforeTx(string memory endpoint, bytes32 txHash) internal returns (Fork);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`endpoint`|`string`|The endpoint to use for the fork.|
|`txHash`|`bytes32`|The transaction hash to fork from.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`Fork`|The new fork pointer.|


### select

*Set the provided fork as the current active fork.*


```solidity
function select(Fork self) internal returns (Fork);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`self`|`Fork`|The fork to set as active.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`Fork`|The fork that was set as active.|


### active

*Get the current active fork.*


```solidity
function active() internal view returns (Fork);
```
**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`Fork`|The current active fork.|


### setBlockNumber

*Set the block number of the provided fork.*


```solidity
function setBlockNumber(Fork self, uint256 blockNumber) internal returns (Fork);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`self`|`Fork`|The fork to set the block number of.|
|`blockNumber`|`uint256`|The block number to set.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`Fork`|The provided fork.|


### beforeTx

*Set the provided fork to the state right before the provided transaction hash.*


```solidity
function beforeTx(Fork self, bytes32 txHash) internal returns (Fork);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`self`|`Fork`|The fork to set the state of.|
|`txHash`|`bytes32`|The transaction hash to fork from.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`Fork`|The provided fork.|


### persistBetweenForks

*Make the state of the provided address persist between forks.*


```solidity
function persistBetweenForks(address self) internal returns (address);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`self`|`address`|The address to make persistent.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`address`|The provided address.|


### persistBetweenForks

*Make the state of the provided addresses persist between forks.*


```solidity
function persistBetweenForks(address who1, address who2) internal;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`who1`|`address`|The first address to make persistent.|
|`who2`|`address`|The second address to make persistent.|


### persistBetweenForks

*Make the state of the provided addresses persist between forks.*


```solidity
function persistBetweenForks(address who1, address who2, address who3) internal;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`who1`|`address`|The first address to make persistent.|
|`who2`|`address`|The second address to make persistent.|
|`who3`|`address`|The third address to make persistent.|


### persistBetweenForks

*Make the state of the provided addresses persist between forks.*


```solidity
function persistBetweenForks(address[] memory whos) internal;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`whos`|`address[]`|Array of addresses to make persistent.|


### stopPersist

*Revoke the persistent state of the provided address.*


```solidity
function stopPersist(address who) internal returns (address);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`who`|`address`|The address to revoke the persistent state of.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`address`|The provided address.|


### stopPersist

*Revoke the persistent state of the provided addresses.*


```solidity
function stopPersist(address[] memory whos) internal;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`whos`|`address[]`|array of addresses to revoke the persistent state of.|


### isPersistent

*Check if the provided address is being persisted between forks.*


```solidity
function isPersistent(address who) internal view returns (bool);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`who`|`address`|The address to check.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`bool`|True if the address is being persisted between forks, false otherwise.|


### allowCheatcodes

*Allow cheatcodes to be used by the provided address in forking mode.*


```solidity
function allowCheatcodes(address who) internal returns (address);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`who`|`address`|The address to allow cheatcodes for.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`address`|The provided address.|


### executeTx

*Executes an existing transaction in the current active fork.*


```solidity
function executeTx(bytes32 txHash) internal;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`txHash`|`bytes32`|The hash of the transaction to execute.|


### executeTx

*Executes an existing transaction in the provided fork.*


```solidity
function executeTx(Fork self, bytes32 txHash) internal returns (Fork);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`self`|`Fork`|The fork to execute the transaction in.|
|`txHash`|`bytes32`|The hash of the transaction to execute.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`Fork`|The provided fork.|


