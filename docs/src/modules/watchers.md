# Watchers

Monitor contract calls.

Watchers work by replacing an address code with a proxy contract that records all calls and events.

```solidity
import { Test, watchers, expect, any } from "vulcan/test.sol";

contract TestMyContract is Test {
    using watchers for *;
    function testMyContract() external {
        MyContract mc = new MyContract();

        address(mc).watch().captureReverts();

        mc.doSomething();
        mc.doSomethingElse();

        expect(address(mc).calls.length).toEqual(2);
        expect(address(mc).calls[0]).toHaveRevertedWith("Something went wrong");
        expect(address(mc).calls[1]).toHaveEmitted(
            "SomeEvent(address,bytes32,uint256)",
            [address(1).topic(), any()], // Event topics (indexed arguments)
            abi.encode(123) // Event data
        );
    }
}
```

### watcherAddress

*Obtains the address of the watcher for `target`.*


```solidity
function watcherAddress(address target) internal pure returns (address);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`target`|`address`|The address for which we need to get the watcher address.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`address`|The address of the watcher.|


### targetAddress

*Obtains the address of the target for `_target`.*


```solidity
function targetAddress(address _watcher) internal pure returns (address);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`_watcher`|`address`|The address for which we need to get the target address.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`address`|The address of the target.|


### watcher

*Obtains the Watcher implementation for the `target` address.*


```solidity
function watcher(address target) internal view returns (Watcher);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`target`|`address`|The address used to obtain the watcher implementation address.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`Watcher`|The Watcher implementation.|


### watch

*Starts watching a `target` address.*


```solidity
function watch(address target) internal returns (Watcher);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`target`|`address`|The address to watch.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`Watcher`|The Watcher implementation.|


### stop

*Stops watching the `target` address.*


```solidity
function stop(address target) internal;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`target`|`address`|The address to stop watching.|


### stopWatcher

*Stops watching the `target` address.*


```solidity
function stopWatcher(address target) internal;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`target`|`address`|The address to stop watching.|


### calls

*Obtains all the calls made to the `target` address.*


```solidity
function calls(address target) internal view returns (Call[] memory);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`target`|`address`|The address of the target contract to query.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`Call[]`|An array of `Call` structs, each containing information about a call.|


### getCall

*Obtains an specific call made to the `target` address at an specific index.*


```solidity
function getCall(address target, uint256 index) internal view returns (Call memory);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`target`|`address`|The address of the target contract to query.|
|`index`|`uint256`|The index of the call to query.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`Call`|A `Call` struct that contains the information about the call.|


### firstCall

*Obtains the first call made to the `target` address.*


```solidity
function firstCall(address target) internal view returns (Call memory);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`target`|`address`|The address of the target contract to query.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`Call`|A `Call` struct that contains the information about the call.|


### lastCall

*Obtains the last call made to the `target` address.*


```solidity
function lastCall(address target) internal view returns (Call memory);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`target`|`address`|The address of the target contract to query.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`Call`|A `Call` struct that contains the information about the call.|


### captureReverts

*Starts capturing reverts for the `target` address. This will prevent the `target` contract to
revert until `disableCaptureReverts` is called. This is meant to be used in conjunction with the `toHaveReverted` and
`toHaveRevertedWith` functions from the expect library.*


```solidity
function captureReverts(address target) internal returns (Watcher);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`target`|`address`|The address for which the reverts are going to be captured.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`Watcher`|The Watcher implementation.|


### disableCaptureReverts

*Stops capturing reverts for the `target` address.*


```solidity
function disableCaptureReverts(address target) internal returns (Watcher);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`target`|`address`|The target address.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`Watcher`|The Watcher implementation.|


