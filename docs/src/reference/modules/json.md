# Json

```solidity
struct JsonObject {
    string id;
    string serialized;
}
```

#### **`getObject(string jsonStr, string key) → (bytes abiEncodedData)`**

Parses a json object string by key and returns an ABI encoded value.

#### **`parse(string jsonStr) → (bytes abiEncodedData)`**

Parses a json object string and returns an ABI encoded tuple.

#### **`getObject(JsonObject jsonObj, string key) → (bytes abiEncodedData)`**

Parses a json object struct by key and returns an ABI encoded value.

#### **`parse(JsonObject jsonObj) → (bytes abiEncodedData)`**

Parses a json object struct and returns an ABI encoded tuple.

#### **`getUint(string jsonStr, string key) → (uint256)`**

Parses the value of the `key` contained on `jsonStr` as uint256.

#### **`getUintArray(string jsonStr, string key) → (uint256[] )`**

Parses the value of the `key` contained on `jsonStr` as uint256[].

#### **`getInt(string jsonStr, string key) → (int256)`**

Parses the value of the `key` contained on `jsonStr` as int256.

#### **`getIntArray(string jsonStr, string key) → (int256[] )`**

Parses the value of the `key` contained on `jsonStr` as int256[].

#### **`getBool(string jsonStr, string key) → (bool)`**

Parses the value of the `key` contained on `jsonStr` as bool.

#### **`getBoolArray(string jsonStr, string key) → (bool[] )`**

Parses the value of the `key` contained on `jsonStr` as bool[].

#### **`getAddress(string jsonStr, string key) → (address)`**

Parses the value of the `key` contained on `jsonStr` as address.

#### **`getAddressArray(string jsonStr, string key) → (address[] )`**

Parses the value of the `key` contained on `jsonStr` as address.

#### **`getString(string jsonStr, string key) → (string )`**

Parses the value of the `key` contained on `jsonStr` as string.

#### **`getStringArray(string jsonStr, string key) → (string[] )`**

Parses the value of the `key` contained on `jsonStr` as string[].

#### **`getBytes(string jsonStr, string key) → (bytes )`**

Parses the value of the `key` contained on `jsonStr` as bytes.

#### **`getBytesArray(string jsonStr, string key) → (bytes[] )`**

Parses the value of the `key` contained on `jsonStr` as bytes[].

#### **`getBytes32(string jsonStr, string key) → (bytes32)`**

Parses the value of the `key` contained on `jsonStr` as bytes32.

#### **`getBytes32Array(string jsonStr, string key) → (bytes32[] )`**

Parses the value of the `key` contained on `jsonStr` as bytes32[].

#### **`create() → (JsonObject )`**

Creates a JsonObject struct with an identifier.

#### **`set(JsonObject obj, string key, bool value) → (JsonObject )`**

Serializes and sets the key and value for the provided json object.

#### **`set(JsonObject obj, string key, uint256 value) → (JsonObject )`**

Serializes and sets the key and value for the provided json object.

#### **`set(JsonObject obj, string key, int256 value) → (JsonObject )`**

Serializes and sets the key and value for the provided json object.

#### **`set(JsonObject obj, string key, address value) → (JsonObject )`**

Serializes and sets the key and value for the provided json object.

#### **`set(JsonObject obj, string key, bytes32 value) → (JsonObject )`**

Serializes and sets the key and value for the provided json object.

#### **`set(JsonObject obj, string key, string value) → (JsonObject )`**

Serializes and sets the key and value for the provided json object.

#### **`set(JsonObject obj, string key, bytes value) → (JsonObject )`**

Serializes and sets the key and value for the provided json object.

#### **`set(JsonObject obj, string key, bool[] values) → (JsonObject )`**

Serializes and sets the key and value for the provided json object.

#### **`set(JsonObject obj, string key, uint256[] values) → (JsonObject )`**

Serializes and sets the key and value for the provided json object.

#### **`set(JsonObject obj, string key, int256[] values) → (JsonObject )`**

Serializes and sets the key and value for the provided json object.

#### **`set(JsonObject obj, string key, address[] values) → (JsonObject )`**

Serializes and sets the key and value for the provided json object.

#### **`set(JsonObject obj, string key, bytes32[] values) → (JsonObject )`**

Serializes and sets the key and value for the provided json object.

#### **`set(JsonObject obj, string key, string[] values) → (JsonObject )`**

Serializes and sets the key and value for the provided json object.

#### **`set(JsonObject obj, string key, bytes[] values) → (JsonObject )`**

Serializes and sets the key and value for the provided json object.

#### **`set(JsonObject obj, string key, JsonObject value) → (JsonObject )`**

Serializes and sets the key and value for the provided json object.

#### **`write(JsonObject obj, string path)`**

Writes a JsonObject struct to a file.

#### **`write(JsonObject obj, string path, string key)`**

Writes a JsonObject struct to an existing json file modifying only a specific key.

