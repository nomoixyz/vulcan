// SPDX-License-Identifier: MIT
pragma solidity >=0.8.13 <0.9.0;

import "./Accounts.sol";
import "./Vulcan.sol";

struct JsonObject {
    string id;
    string serialized;
}

library json {
    function parseObject(string memory jsonStr, string memory key)
        internal
        pure
        returns (bytes memory abiEncodedData)
    {
        return vulcan.hevm.parseJson(jsonStr, key);
    }

    function parseObject(string memory jsonStr) internal pure returns (bytes memory abiEncodedData) {
        return vulcan.hevm.parseJson(jsonStr);
    }

    function parseObject(JsonObject memory jsonObj, string memory key)
        internal
        pure
        returns (bytes memory abiEncodedData)
    {
        return vulcan.hevm.parseJson(jsonObj.serialized, key);
    }

    function parseObject(JsonObject memory jsonObj) internal pure returns (bytes memory abiEncodedData) {
        return vulcan.hevm.parseJson(jsonObj.serialized);
    }

    function parseUint(string memory jsonStr, string memory key) internal returns (uint256) {
        return vulcan.hevm.parseJsonUint(jsonStr, key);
    }

    function parseUintArray(string memory jsonStr, string memory key) internal returns (uint256[] memory) {
        return vulcan.hevm.parseJsonUintArray(jsonStr, key);
    }

    function parseInt(string memory jsonStr, string memory key) internal returns (int256) {
        return vulcan.hevm.parseJsonInt(jsonStr, key);
    }

    function parseIntArray(string memory jsonStr, string memory key) internal returns (int256[] memory) {
        return vulcan.hevm.parseJsonIntArray(jsonStr, key);
    }

    function parseBool(string memory jsonStr, string memory key) internal returns (bool) {
        return vulcan.hevm.parseJsonBool(jsonStr, key);
    }

    function parseBoolArray(string memory jsonStr, string memory key) internal returns (bool[] memory) {
        return vulcan.hevm.parseJsonBoolArray(jsonStr, key);
    }

    function parseAddress(string memory jsonStr, string memory key) internal returns (address) {
        return vulcan.hevm.parseJsonAddress(jsonStr, key);
    }

    function parseAddressArray(string memory jsonStr, string memory key) internal returns (address[] memory) {
        return vulcan.hevm.parseJsonAddressArray(jsonStr, key);
    }

    function parseString(string memory jsonStr, string memory key) internal returns (string memory) {
        return vulcan.hevm.parseJsonString(jsonStr, key);
    }

    function parseStringArray(string memory jsonStr, string memory key) internal returns (string[] memory) {
        return vulcan.hevm.parseJsonStringArray(jsonStr, key);
    }

    function parseBytes(string memory jsonStr, string memory key) internal returns (bytes memory) {
        return vulcan.hevm.parseJsonBytes(jsonStr, key);
    }

    function parseBytesArray(string memory jsonStr, string memory key) internal returns (bytes[] memory) {
        return vulcan.hevm.parseJsonBytesArray(jsonStr, key);
    }

    function parseBytes32(string memory jsonStr, string memory key) internal returns (bytes32) {
        return vulcan.hevm.parseJsonBytes32(jsonStr, key);
    }

    function parseBytes32Array(string memory jsonStr, string memory key) internal returns (bytes32[] memory) {
        return vulcan.hevm.parseJsonBytes32Array(jsonStr, key);
    }

    function create() internal returns (JsonObject memory) {
        bytes32 slot = keccak256("vulcan.json.id.counter");
        uint256 next = uint256(accounts.readStorage(address(this), slot)) + 1;
        accounts.setStorage(address(this), slot, bytes32(next));

        string memory id = string(abi.encodePacked(address(this), next));

        return JsonObject({id: id, serialized: ""});
    }

    // Serialize a key and value to a JSON object stored in-memory that can be later written to a file
    // It returns the stringified version of the specific JSON file up to that moment.
    function serialize(JsonObject memory obj, string memory valueKey, bool value)
        internal
        returns (JsonObject memory)
    {
        obj.serialized = vulcan.hevm.serializeBool(obj.id, valueKey, value);
        return obj;
    }

    function serialize(JsonObject memory obj, string memory valueKey, uint256 value)
        internal
        returns (JsonObject memory)
    {
        obj.serialized = vulcan.hevm.serializeUint(obj.id, valueKey, value);
        return obj;
    }

    function serialize(JsonObject memory obj, string memory valueKey, int256 value)
        internal
        returns (JsonObject memory)
    {
        obj.serialized = vulcan.hevm.serializeInt(obj.id, valueKey, value);
        return obj;
    }

    function serialize(JsonObject memory obj, string memory valueKey, address value)
        internal
        returns (JsonObject memory)
    {
        obj.serialized = vulcan.hevm.serializeAddress(obj.id, valueKey, value);
        return obj;
    }

    function serialize(JsonObject memory obj, string memory valueKey, bytes32 value)
        internal
        returns (JsonObject memory)
    {
        obj.serialized = vulcan.hevm.serializeBytes32(obj.id, valueKey, value);
        return obj;
    }

    function serialize(JsonObject memory obj, string memory valueKey, string memory value)
        internal
        returns (JsonObject memory)
    {
        obj.serialized = vulcan.hevm.serializeString(obj.id, valueKey, value);
        return obj;
    }

    function serialize(JsonObject memory obj, string memory valueKey, bytes memory value)
        internal
        returns (JsonObject memory)
    {
        obj.serialized = vulcan.hevm.serializeBytes(obj.id, valueKey, value);
        return obj;
    }

    function serialize(JsonObject memory obj, string memory valueKey, bool[] memory values)
        internal
        returns (JsonObject memory)
    {
        obj.serialized = vulcan.hevm.serializeBool(obj.id, valueKey, values);
        return obj;
    }

    function serialize(JsonObject memory obj, string memory valueKey, uint256[] memory values)
        internal
        returns (JsonObject memory)
    {
        obj.serialized = vulcan.hevm.serializeUint(obj.id, valueKey, values);
        return obj;
    }

    function serialize(JsonObject memory obj, string memory valueKey, int256[] memory values)
        internal
        returns (JsonObject memory)
    {
        obj.serialized = vulcan.hevm.serializeInt(obj.id, valueKey, values);
        return obj;
    }

    function serialize(JsonObject memory obj, string memory valueKey, address[] memory values)
        internal
        returns (JsonObject memory)
    {
        obj.serialized = vulcan.hevm.serializeAddress(obj.id, valueKey, values);
        return obj;
    }

    function serialize(JsonObject memory obj, string memory valueKey, bytes32[] memory values)
        internal
        returns (JsonObject memory)
    {
        obj.serialized = vulcan.hevm.serializeBytes32(obj.id, valueKey, values);
        return obj;
    }

    function serialize(JsonObject memory obj, string memory valueKey, string[] memory values)
        internal
        returns (JsonObject memory)
    {
        obj.serialized = vulcan.hevm.serializeString(obj.id, valueKey, values);
        return obj;
    }

    function serialize(JsonObject memory obj, string memory valueKey, bytes[] memory values)
        internal
        returns (JsonObject memory)
    {
        obj.serialized = vulcan.hevm.serializeBytes(obj.id, valueKey, values);
        return obj;
    }

    function serialize(JsonObject memory obj, string memory valueKey, JsonObject memory value)
        internal
        returns (JsonObject memory)
    {
        obj.serialized = vulcan.hevm.serializeString(obj.id, valueKey, value.serialized);
        return obj;
    }

    function write(JsonObject memory obj, string memory path) internal {
        vulcan.hevm.writeJson(obj.serialized, path);
    }

    function write(JsonObject memory obj, string memory path, string memory valueKey) internal {
        vulcan.hevm.writeJson(obj.serialized, path, valueKey);
    }
}

using json for JsonObject global;
