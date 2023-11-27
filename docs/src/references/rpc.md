# Rpc

## rpc



### **call(string urlOrName, string method, string params) &rarr; (bytes data)**

Calls an JSON-RPC method on a specific RPC endpoint. If there was a previous active fork it will return back to that one once the method is called.

### **call(string method, string params) &rarr; (bytes data)**

Calls an JSON-RPC method on the current active fork

