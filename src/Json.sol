// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.13 <0.9.0;

import "./Accounts.sol";
import "./Vulcan.sol";

struct JsonObject {
    string id;
    string serialized;
}

library json {
    //
    // parseJson
    //
    // ----
    // In case the returned value is a JSON object, it's encoded as a ABI-encoded tuple. As JSON objects
    // don't have the notion of ordered, but tuples do, they JSON object is encoded with it's fields ordered in
    // ALPHABETICAL order. That means that in order to successfully decode the tuple, we need to define a tuple that
    // encodes the fields in the same order, which is alphabetical. In the case of Solidity structs, they are encoded
    // as tuples, with the attributes in the order in which they are defined.
    // For example: json = { 'a': 1, 'b': 0xa4tb......3xs}
    // a: uint256
    // b: address
    // To decode that json, we need to define a struct or a tuple as follows:
    // struct json = { uint256 a; address b; }
    // If we defined a json struct with the opposite order, meaning placing the address b first, it would try to
    // decode the tuple in that order, and thus fail.
    // ----
    // Given a string of JSON, return it as ABI-encoded
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

    // The following parseJson cheatcodes will do type coercion, for the type that they indicate.
    // For example, parseJsonUint will coerce all values to a uint256. That includes stringified numbers '12'
    // and hex numbers '0xEF'.
    // Type coercion works ONLY for discrete values or arrays. That means that the key must return a value or array, not
    // a JSON object.
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

    function create(string memory serialized) internal returns (JsonObject memory) {
        bytes32 slot = keccak256("vulcan.json.id.counter");
        uint256 next = uint256(accounts.readStorage(address(this), slot)) + 1;
        accounts.setStorage(address(this), slot, bytes32(next));

        string memory id = string(abi.encodePacked(address(this), next));

        return JsonObject({id: id, serialized: serialized});
    }

    function create() internal returns(JsonObject memory) {
        // TODO: maybe it should be "{}"?
        return create("");
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
    //
    // writeJson
    //
    // ----
    // Write a serialized JSON object to a file. If the file exists, it will be overwritten.
    // Let's assume we want to write the following JSON to a file:
    //
    // { "boolean": true, "number": 342, "object": { "title": "finally json serialization" } }
    //
    // ```
    //  string memory json1 = "some key";
    //  vm.serializeBool(json1, "boolean", true);
    //  vm.serializeBool(json1, "number", uint256(342));
    //  json2 = "some other key";
    //  string memory output = vm.serializeString(json2, "title", "finally json serialization");
    //  string memory finalJson = vm.serialize(json1, "object", output);
    //  vm.writeJson(finalJson, "./output/example.json");
    // ```
    // The critical insight is that every invocation of serialization will return the stringified version of the JSON
    // up to that point. That means we can construct arbitrary JSON objects and then use the return stringified version
    // to serialize them as values to another JSON object.
    //
    // json1 and json2 are simply keys used by the backend to keep track of the objects. So vm.serializeJson(json1,..)
    // will find the object in-memory that is keyed by "some key".

    function write(JsonObject memory obj, string memory path) internal {
        vulcan.hevm.writeJson(obj.serialized, path);
    }
    // Write a serialized JSON object to an **existing** JSON file, replacing a value with key = <value_key>
    // This is useful to replace a specific value of a JSON file, without having to parse the entire thing

    function write(JsonObject memory obj, string memory path, string memory valueKey) internal {
        vulcan.hevm.writeJson(obj.serialized, path, valueKey);
    }
}

using json for JsonObject global;
