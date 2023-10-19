# Config

## Structs

### Rpc

```solidity
struct Rpc {
	string name
	string url
}
```

Struct that represents an RPC endpoint

## config



### **rpcUrl(string name) &rarr; (string)**

Obtains a specific RPC from the configuration by name.

### **rpcUrls() &rarr; (string[2][])**

Obtains all the RPCs from the configuration.

### **rpcUrlStructs() &rarr; (Rpc[] rpcs)**

Obtains all the RPCs from the configuration.

