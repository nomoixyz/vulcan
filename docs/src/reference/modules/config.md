# Config

### rpcUrl

*Obtains a specific RPC from the configuration by name.*


```solidity
function rpcUrl(string memory name) internal view returns (string memory);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`name`|`string`|The name of the RPC to query.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`string`|The url of the RPC.|


### rpcUrls

*Obtains all the RPCs from the configuration.*


```solidity
function rpcUrls() internal view returns (string[2][] memory);
```
**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`string[2][]`|All the RPCs as `[name, url][]`.|


### rpcUrlStructs

*Obtains all the RPCs from the configuration.*


```solidity
struct Rpc {
    string name;
    string url;
}

function rpcUrlStructs() internal view returns (Rpc[] memory rpcs);
```
**Returns**

|Name|Type|Description|
|----|----|-----------|
|`rpcs`|`Rpc[]`|All the RPCs as `Rpc[]`.|

