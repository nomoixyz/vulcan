# Json

## Custom types

### JsonResult

```solidity
type JsonResult is bytes32;
```



## Structs

### JsonObject

```solidity
struct JsonObject {
	string id
	string serialized
}
```



## Functions

### **Ok(JsonObject value) &rarr; (JsonResult)**



## JsonError



### **Invalid() &rarr; (Error)**



### **toJsonResult(Error self) &rarr; (JsonResult)**



## LibJsonObjectPointer



### **toJsonObject(Pointer self) &rarr; (JsonObject obj)**



### **toJsonResult(Pointer self) &rarr; (JsonResult result)**



### **toPointer(JsonObject obj) &rarr; (Pointer ptr)**



## LibJsonResult



### **isOk(JsonResult self) &rarr; (bool)**



### **isError(JsonResult self) &rarr; (bool)**



### **unwrap(JsonResult self) &rarr; (JsonObject val)**



### **expect(JsonResult self, string err) &rarr; (JsonObject)**



### **toError(JsonResult self) &rarr; (Error)**



### **toValue(JsonResult self) &rarr; (JsonObject val)**



### **toPointer(JsonResult self) &rarr; (Pointer)**



## json



### **getObject(JsonObject jsonObj, string key) &rarr; (bytes abiEncodedData)**

Parses a json object struct by key and returns an ABI encoded value.

### **parse(JsonObject jsonObj) &rarr; (bytes abiEncodedData)**

Parses a json object struct and returns an ABI encoded tuple.

### **isValid(string jsonObj) &rarr; (bool)**



### **containsKey(JsonObject obj, string key) &rarr; (bool)**



### **getUint(JsonObject obj, string key) &rarr; (uint256)**

Parses the value of the `key` contained on `jsonStr` as uint256.

### **getUintArray(JsonObject obj, string key) &rarr; (uint256[])**

Parses the value of the `key` contained on `jsonStr` as uint256[].

### **getInt(JsonObject obj, string key) &rarr; (int256)**

Parses the value of the `key` contained on `jsonStr` as int256.

### **getIntArray(JsonObject obj, string key) &rarr; (int256[])**

Parses the value of the `key` contained on `jsonStr` as int256[].

### **getBool(JsonObject obj, string key) &rarr; (bool)**

Parses the value of the `key` contained on `jsonStr` as bool.

### **getBoolArray(JsonObject obj, string key) &rarr; (bool[])**

Parses the value of the `key` contained on `jsonStr` as bool[].

### **getAddress(JsonObject obj, string key) &rarr; (address)**

Parses the value of the `key` contained on `jsonStr` as address.

### **getAddressArray(JsonObject obj, string key) &rarr; (address[])**

Parses the value of the `key` contained on `jsonStr` as address.

### **getString(JsonObject obj, string key) &rarr; (string)**

Parses the value of the `key` contained on `jsonStr` as string.

### **getStringArray(JsonObject obj, string key) &rarr; (string[])**

Parses the value of the `key` contained on `jsonStr` as string[].

### **getBytes(JsonObject obj, string key) &rarr; (bytes)**

Parses the value of the `key` contained on `jsonStr` as bytes.

### **getBytesArray(JsonObject obj, string key) &rarr; (bytes[])**

Parses the value of the `key` contained on `jsonStr` as bytes[].

### **getBytes32(JsonObject obj, string key) &rarr; (bytes32)**

Parses the value of the `key` contained on `jsonStr` as bytes32.

### **getBytes32Array(JsonObject obj, string key) &rarr; (bytes32[])**

Parses the value of the `key` contained on `jsonStr` as bytes32[].

### **getKeys(JsonObject obj, string key) &rarr; (string[])**



### **getKeys(JsonObject obj) &rarr; (string[])**



### **create() &rarr; (JsonObject)**

Creates a new JsonObject struct.

### **create(string obj) &rarr; (JsonResult)**

Creates a new JsonObject struct.

### **set(JsonObject obj, string key, bool value) &rarr; (JsonObject res)**

Serializes and sets the key and value for the provided json object.

### **set(JsonObject obj, string key, uint256 value) &rarr; (JsonObject res)**

Serializes and sets the key and value for the provided json object.

### **set(JsonObject obj, string key, int256 value) &rarr; (JsonObject res)**

Serializes and sets the key and value for the provided json object.

### **set(JsonObject obj, string key, address value) &rarr; (JsonObject res)**

Serializes and sets the key and value for the provided json object.

### **set(JsonObject obj, string key, bytes32 value) &rarr; (JsonObject res)**

Serializes and sets the key and value for the provided json object.

### **set(JsonObject obj, string key, string value) &rarr; (JsonObject res)**

Serializes and sets the key and value for the provided json object.

### **set(JsonObject obj, string key, bytes value) &rarr; (JsonObject res)**

Serializes and sets the key and value for the provided json object.

### **set(JsonObject obj, string key, bool[] values) &rarr; (JsonObject res)**

Serializes and sets the key and value for the provided json object.

### **set(JsonObject obj, string key, uint256[] values) &rarr; (JsonObject res)**

Serializes and sets the key and value for the provided json object.

### **set(JsonObject obj, string key, int256[] values) &rarr; (JsonObject res)**

Serializes and sets the key and value for the provided json object.

### **set(JsonObject obj, string key, address[] values) &rarr; (JsonObject res)**

Serializes and sets the key and value for the provided json object.

### **set(JsonObject obj, string key, bytes32[] values) &rarr; (JsonObject res)**

Serializes and sets the key and value for the provided json object.

### **set(JsonObject obj, string key, string[] values) &rarr; (JsonObject res)**

Serializes and sets the key and value for the provided json object.

### **set(JsonObject obj, string key, bytes[] values) &rarr; (JsonObject res)**

Serializes and sets the key and value for the provided json object.

### **set(JsonObject obj, string key, JsonObject value) &rarr; (JsonObject res)**

Serializes and sets the key and value for the provided json object.

### **write(JsonObject obj, string path)**

Writes a JsonObject struct to a file.

### **write(JsonObject obj, string path, string key)**

Writes a JsonObject struct to an existing json file modifying only a specific key.

