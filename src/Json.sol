// SPDX-License-Identifier: MIT
pragma solidity >=0.8.13 <0.9.0;

import "./Accounts.sol";
import "./Vulcan.sol";

struct JsonObject {
    string id;
    string serialized;
}

library json {
    /// @dev Parses a json object string by key and returns an ABI encoded value.
    /// @param jsonStr The json string.
    /// @param key The key from the `jsonStr` to parse.
    /// @return abiEncodedData The value of key ABI encoded.
    function parseObject(string memory jsonStr, string memory key)
        internal
        pure
        returns (bytes memory abiEncodedData)
    {
        return vulcan.hevm.parseJson(jsonStr, key);
    }

    /// @dev Parses a json object string and returns an ABI encoded tuple.
    /// @param jsonStr The json string.
    /// @return abiEncodedData The ABI encoded tuple representing the json object.
    function parseObject(string memory jsonStr) internal pure returns (bytes memory abiEncodedData) {
        return vulcan.hevm.parseJson(jsonStr);
    }

    /// @dev Parses a json object struct by key and returns an ABI encoded value.
    /// @param jsonObj The json object struct.
    /// @param key The key from the `jsonObject` to parse.
    /// @return abiEncodedData The value of key ABI encoded.
    function parseObject(JsonObject memory jsonObj, string memory key)
        internal
        pure
        returns (bytes memory abiEncodedData)
    {
        return vulcan.hevm.parseJson(jsonObj.serialized, key);
    }

    /// @dev Parses a json object struct and returns an ABI encoded tuple.
    /// @param jsonObj The json struct.
    /// @return abiEncodedData The ABI encoded tuple representing the json object.
    function parseObject(JsonObject memory jsonObj) internal pure returns (bytes memory abiEncodedData) {
        return vulcan.hevm.parseJson(jsonObj.serialized);
    }

    /// @dev Parses the value of the `key` contained on `jsonStr` as uint256.
    /// @param jsonStr The json string.
    /// @param key The key from the `jsonStr` to parse.
    /// @return The uint256 value.
    function parseUint(string memory jsonStr, string memory key) internal returns (uint256) {
        return vulcan.hevm.parseJsonUint(jsonStr, key);
    }

    /// @dev Parses the value of the `key` contained on `jsonStr` as uint256[].
    /// @param jsonStr The json string.
    /// @param key The key from the `jsonStr` to parse.
    /// @return The uint256[] value.
    function parseUintArray(string memory jsonStr, string memory key) internal returns (uint256[] memory) {
        return vulcan.hevm.parseJsonUintArray(jsonStr, key);
    }

    /// @dev Parses the value of the `key` contained on `jsonStr` as int256.
    /// @param jsonStr The json string.
    /// @param key The key from the `jsonStr` to parse.
    /// @return The int256 value.
    function parseInt(string memory jsonStr, string memory key) internal returns (int256) {
        return vulcan.hevm.parseJsonInt(jsonStr, key);
    }

    /// @dev Parses the value of the `key` contained on `jsonStr` as int256[].
    /// @param jsonStr The json string.
    /// @param key The key from the `jsonStr` to parse.
    /// @return The int256[] value.
    function parseIntArray(string memory jsonStr, string memory key) internal returns (int256[] memory) {
        return vulcan.hevm.parseJsonIntArray(jsonStr, key);
    }

    /// @dev Parses the value of the `key` contained on `jsonStr` as bool.
    /// @param jsonStr The json string.
    /// @param key The key from the `jsonStr` to parse.
    /// @return The bool value.
    function parseBool(string memory jsonStr, string memory key) internal returns (bool) {
        return vulcan.hevm.parseJsonBool(jsonStr, key);
    }

    /// @dev Parses the value of the `key` contained on `jsonStr` as bool[].
    /// @param jsonStr The json string.
    /// @param key The key from the `jsonStr` to parse.
    /// @return The bool[] value.
    function parseBoolArray(string memory jsonStr, string memory key) internal returns (bool[] memory) {
        return vulcan.hevm.parseJsonBoolArray(jsonStr, key);
    }

    /// @dev Parses the value of the `key` contained on `jsonStr` as address.
    /// @param jsonStr The json string.
    /// @param key The key from the `jsonStr` to parse.
    /// @return The address value.
    function parseAddress(string memory jsonStr, string memory key) internal returns (address) {
        return vulcan.hevm.parseJsonAddress(jsonStr, key);
    }

    /// @dev Parses the value of the `key` contained on `jsonStr` as address.
    /// @param jsonStr The json string.
    /// @param key The key from the `jsonStr` to parse.
    /// @return The address value.
    function parseAddressArray(string memory jsonStr, string memory key) internal returns (address[] memory) {
        return vulcan.hevm.parseJsonAddressArray(jsonStr, key);
    }

    /// @dev Parses the value of the `key` contained on `jsonStr` as string.
    /// @param jsonStr The json string.
    /// @param key The key from the `jsonStr` to parse.
    /// @return The string value.
    function parseString(string memory jsonStr, string memory key) internal returns (string memory) {
        return vulcan.hevm.parseJsonString(jsonStr, key);
    }

    /// @dev Parses the value of the `key` contained on `jsonStr` as string[].
    /// @param jsonStr The json string.
    /// @param key The key from the `jsonStr` to parse.
    /// @return The string[] value.
    function parseStringArray(string memory jsonStr, string memory key) internal returns (string[] memory) {
        return vulcan.hevm.parseJsonStringArray(jsonStr, key);
    }

    /// @dev Parses the value of the `key` contained on `jsonStr` as bytes.
    /// @param jsonStr The json string.
    /// @param key The key from the `jsonStr` to parse.
    /// @return The bytes value.
    function parseBytes(string memory jsonStr, string memory key) internal returns (bytes memory) {
        return vulcan.hevm.parseJsonBytes(jsonStr, key);
    }

    /// @dev Parses the value of the `key` contained on `jsonStr` as bytes[].
    /// @param jsonStr The json string.
    /// @param key The key from the `jsonStr` to parse.
    /// @return The bytes[] value.
    function parseBytesArray(string memory jsonStr, string memory key) internal returns (bytes[] memory) {
        return vulcan.hevm.parseJsonBytesArray(jsonStr, key);
    }

    /// @dev Parses the value of the `key` contained on `jsonStr` as bytes32.
    /// @param jsonStr The json string.
    /// @param key The key from the `jsonStr` to parse.
    /// @return The bytes32 value.
    function parseBytes32(string memory jsonStr, string memory key) internal returns (bytes32) {
        return vulcan.hevm.parseJsonBytes32(jsonStr, key);
    }

    /// @dev Parses the value of the `key` contained on `jsonStr` as bytes32[].
    /// @param jsonStr The json string.
    /// @param key The key from the `jsonStr` to parse.
    /// @return The bytes32[] value.
    function parseBytes32Array(string memory jsonStr, string memory key) internal returns (bytes32[] memory) {
        return vulcan.hevm.parseJsonBytes32Array(jsonStr, key);
    }

    /// @dev Creates a JsonObject struct with an identifier.
    /// @return The JsonObject struct.
    function create() internal returns (JsonObject memory) {
        bytes32 slot = keccak256("vulcan.json.id.counter");
        uint256 next = uint256(accounts.readStorage(address(this), slot)) + 1;
        accounts.setStorage(address(this), slot, bytes32(next));

        string memory id = string(abi.encodePacked(address(this), next));

        return JsonObject({id: id, serialized: ""});
    }

    /// @dev Serializes a key from a JsonObject struct with a boolean value.
    /// @param obj The json object to modify.
    /// @param valueKey The key that will hold the `value`.
    /// @param value The value of `valueKey`.
    /// @return The modified JsonObject struct.
    function serialize(JsonObject memory obj, string memory valueKey, bool value)
        internal
        returns (JsonObject memory)
    {
        obj.serialized = vulcan.hevm.serializeBool(obj.id, valueKey, value);
        return obj;
    }

    /// @dev Serializes a key from a JsonObject struct with a uint256 value.
    /// @param obj The json object to modify.
    /// @param valueKey The key that will hold the `value`.
    /// @param value The value of `valueKey`.
    /// @return The modified JsonObject struct.
    function serialize(JsonObject memory obj, string memory valueKey, uint256 value)
        internal
        returns (JsonObject memory)
    {
        obj.serialized = vulcan.hevm.serializeUint(obj.id, valueKey, value);
        return obj;
    }

    /// @dev Serializes a key from a JsonObject struct with a int256 value.
    /// @param obj The json object to modify.
    /// @param valueKey The key that will hold the `value`.
    /// @param value The value of `valueKey`.
    /// @return The modified JsonObject struct.
    function serialize(JsonObject memory obj, string memory valueKey, int256 value)
        internal
        returns (JsonObject memory)
    {
        obj.serialized = vulcan.hevm.serializeInt(obj.id, valueKey, value);
        return obj;
    }

    /// @dev Serializes a key from a JsonObject struct with a address value.
    /// @param obj The json object to modify.
    /// @param valueKey The key that will hold the `value`.
    /// @param value The value of `valueKey`.
    /// @return The modified JsonObject struct.
    function serialize(JsonObject memory obj, string memory valueKey, address value)
        internal
        returns (JsonObject memory)
    {
        obj.serialized = vulcan.hevm.serializeAddress(obj.id, valueKey, value);
        return obj;
    }

    /// @dev Serializes a key from a JsonObject struct with a bytes32 value.
    /// @param obj The json object to modify.
    /// @param valueKey The key that will hold the `value`.
    /// @param value The value of `valueKey`.
    /// @return The modified JsonObject struct.
    function serialize(JsonObject memory obj, string memory valueKey, bytes32 value)
        internal
        returns (JsonObject memory)
    {
        obj.serialized = vulcan.hevm.serializeBytes32(obj.id, valueKey, value);
        return obj;
    }

    /// @dev Serializes a key from a JsonObject struct with a string value.
    /// @param obj The json object to modify.
    /// @param valueKey The key that will hold the `value`.
    /// @param value The value of `valueKey`.
    /// @return The modified JsonObject struct.
    function serialize(JsonObject memory obj, string memory valueKey, string memory value)
        internal
        returns (JsonObject memory)
    {
        obj.serialized = vulcan.hevm.serializeString(obj.id, valueKey, value);
        return obj;
    }

    /// @dev Serializes a key from a JsonObject struct with a bytes value.
    /// @param obj The json object to modify.
    /// @param valueKey The key that will hold the `value`.
    /// @param value The value of `valueKey`.
    /// @return The modified JsonObject struct.
    function serialize(JsonObject memory obj, string memory valueKey, bytes memory value)
        internal
        returns (JsonObject memory)
    {
        obj.serialized = vulcan.hevm.serializeBytes(obj.id, valueKey, value);
        return obj;
    }

    /// @dev Serializes a key from a JsonObject struct with a bool[] value.
    /// @param obj The json object to modify.
    /// @param valueKey The key that will hold the `value`.
    /// @param values The value of `valueKey`.
    /// @return The modified JsonObject struct.
    function serialize(JsonObject memory obj, string memory valueKey, bool[] memory values)
        internal
        returns (JsonObject memory)
    {
        obj.serialized = vulcan.hevm.serializeBool(obj.id, valueKey, values);
        return obj;
    }

    /// @dev Serializes a key from a JsonObject struct with a uint256[] value.
    /// @param obj The json object to modify.
    /// @param valueKey The key that will hold the `value`.
    /// @param values The value of `valueKey`.
    /// @return The modified JsonObject struct.
    function serialize(JsonObject memory obj, string memory valueKey, uint256[] memory values)
        internal
        returns (JsonObject memory)
    {
        obj.serialized = vulcan.hevm.serializeUint(obj.id, valueKey, values);
        return obj;
    }

    /// @dev Serializes a key from a JsonObject struct with a int256[] value.
    /// @param obj The json object to modify.
    /// @param valueKey The key that will hold the `value`.
    /// @param values The value of `valueKey`.
    /// @return The modified JsonObject struct.
    function serialize(JsonObject memory obj, string memory valueKey, int256[] memory values)
        internal
        returns (JsonObject memory)
    {
        obj.serialized = vulcan.hevm.serializeInt(obj.id, valueKey, values);
        return obj;
    }

    /// @dev Serializes a key from a JsonObject struct with a address[] value.
    /// @param obj The json object to modify.
    /// @param valueKey The key that will hold the `value`.
    /// @param values The value of `valueKey`.
    /// @return The modified JsonObject struct.
    function serialize(JsonObject memory obj, string memory valueKey, address[] memory values)
        internal
        returns (JsonObject memory)
    {
        obj.serialized = vulcan.hevm.serializeAddress(obj.id, valueKey, values);
        return obj;
    }

    /// @dev Serializes a key from a JsonObject struct with a bytes32[] value.
    /// @param obj The json object to modify.
    /// @param valueKey The key that will hold the `value`.
    /// @param values The value of `valueKey`.
    /// @return The modified JsonObject struct.
    function serialize(JsonObject memory obj, string memory valueKey, bytes32[] memory values)
        internal
        returns (JsonObject memory)
    {
        obj.serialized = vulcan.hevm.serializeBytes32(obj.id, valueKey, values);
        return obj;
    }

    /// @dev Serializes a key from a JsonObject struct with a string[] value.
    /// @param obj The json object to modify.
    /// @param valueKey The key that will hold the `value`.
    /// @param values The value of `valueKey`.
    /// @return The modified JsonObject struct.
    function serialize(JsonObject memory obj, string memory valueKey, string[] memory values)
        internal
        returns (JsonObject memory)
    {
        obj.serialized = vulcan.hevm.serializeString(obj.id, valueKey, values);
        return obj;
    }

    /// @dev Serializes a key from a JsonObject struct with a string[] value.
    /// @param obj The json object to modify.
    /// @param valueKey The key that will hold the `value`.
    /// @param values The value of `valueKey`.
    /// @return The modified JsonObject struct.
    function serialize(JsonObject memory obj, string memory valueKey, bytes[] memory values)
        internal
        returns (JsonObject memory)
    {
        obj.serialized = vulcan.hevm.serializeBytes(obj.id, valueKey, values);
        return obj;
    }

    /// @dev Serializes a key from a JsonObject struct with a JsonObject value.
    /// @param obj The json object to modify.
    /// @param valueKey The key that will hold the `value`.
    /// @param value The value of `valueKey`.
    /// @return The modified JsonObject struct.
    function serialize(JsonObject memory obj, string memory valueKey, JsonObject memory value)
        internal
        returns (JsonObject memory)
    {
        obj.serialized = vulcan.hevm.serializeString(obj.id, valueKey, value.serialized);
        return obj;
    }

    /// @dev Writes a JsonObject struct to a file.
    /// @param obj The json object that will be stored as a file.
    /// @param path The path where the file will be saved.
    function write(JsonObject memory obj, string memory path) internal {
        vulcan.hevm.writeJson(obj.serialized, path);
    }

    /// @dev Writes a JsonObject struct to an existing json file modifiyng only a specific key.
    /// @param obj The json object that contains a value on `valueKey`.
    /// @param valueKey The key from `obj` that will be overwritten on the file.
    /// @param path The path where the file will be saved.
    function write(JsonObject memory obj, string memory path, string memory valueKey) internal {
        vulcan.hevm.writeJson(obj.serialized, path, valueKey);
    }
}

using json for JsonObject global;
