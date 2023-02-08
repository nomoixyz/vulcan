// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.13 <0.9.0;

import "./Vulcan.sol";

type Json is bytes32;

struct JsonObject {
    string id;
    string serialized;
}

library JsonLib {
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
    function parseObject(Json, string memory json, string memory key) external pure returns (bytes memory abiEncodedData) {
        return vulcan.hevm.parseJson(json, key);
    }
    function parseObject(Json, string memory json) external pure returns (bytes memory abiEncodedData) {
        return vulcan.hevm.parseJson(json);
    }

    function parseObject(Json, JsonObject memory json, string memory key) external pure returns (bytes memory abiEncodedData) {
        return vulcan.hevm.parseJson(json.serialized, key);
    }

    function parseObject(Json, JsonObject memory json) external pure returns (bytes memory abiEncodedData) {
        return vulcan.hevm.parseJson(json.serialized);
    }

    // The following parseJson cheatcodes will do type coercion, for the type that they indicate.
    // For example, parseJsonUint will coerce all values to a uint256. That includes stringified numbers '12'
    // and hex numbers '0xEF'.
    // Type coercion works ONLY for discrete values or arrays. That means that the key must return a value or array, not
    // a JSON object.
    function parseUint(Json, string memory json, string memory key) external returns (uint256) {
        return vulcan.hevm.parseJsonUint(json, key);
    }
    function parseUintArray(Json, string memory json, string memory key) external returns (uint256[] memory) {
        return vulcan.hevm.parseJsonUintArray(json, key);
    }
    function parseInt(Json, string memory json, string memory key) external returns (int256) {
        return vulcan.hevm.parseJsonInt(json, key);
    }
    function parseIntArray(Json, string memory json, string memory key) external returns (int256[] memory) {
        return vulcan.hevm.parseJsonIntArray(json, key);
    }
    function parseBool(Json, string memory json, string memory key) external returns (bool) {
        return vulcan.hevm.parseJsonBool(json, key);
    }
    function parseJsonBoolArray(Json, string memory json, string memory key) external returns (bool[] memory) {
        return vulcan.hevm.parseJsonBoolArray(json, key);
    }
    function parseAddress(Json, string memory json, string memory key) external returns (address) {
        return vulcan.hevm.parseJsonAddress(json, key);

    }
    function parseAddressArray(Json, string memory json, string memory key) external returns (address[] memory) {
        return vulcan.hevm.parseJsonAddressArray(json, key);
    }
    function parseString(Json, string memory json, string memory key) external returns (string memory) {
        return vulcan.hevm.parseJsonString(json, key);
    }
    function parseStringArray(Json, string memory json, string memory key) external returns (string[] memory) {
        return vulcan.hevm.parseJsonStringArray(json, key);
    }
    function parseBytes(Json, string memory json, string memory key) external returns (bytes memory) {
        return vulcan.hevm.parseJsonBytes(json, key);
    }
    function parseBytesArray(Json, string memory json, string memory key) external returns (bytes[] memory) {
        return vulcan.hevm.parseJsonBytesArray(json, key);
    }
    function parseBytes32(Json, string memory json, string memory key) external returns (bytes32) {
        return vulcan.hevm.parseJsonBytes32(json, key);
    }
    function parseBytes32Array(Json, string memory json, string memory key) external returns (bytes32[] memory) {
        return vulcan.hevm.parseJsonBytes32Array(json, key);
    }


    function create(Json, string memory id) external pure returns (JsonObject memory) {
        return JsonObject({id: id, serialized: ""});
    }

    // Serialize a key and value to a JSON object stored in-memory that can be later written to a file
    // It returns the stringified version of the specific JSON file up to that moment.
    function serialize(JsonObject memory obj, string memory valueKey, bool value)
        external
        returns (JsonObject memory)
    {
        obj.serialized = vulcan.hevm.serializeBool(obj.id, valueKey, value);
        return obj;
    }

    function serialize(JsonObject memory obj, string memory valueKey, uint256 value)
        external
        returns (JsonObject memory)
    {
        obj.serialized = vulcan.hevm.serializeUint(obj.id, valueKey, value);
        return obj;
    }
    function serialize(JsonObject memory obj, string memory valueKey, int256 value)
        external
        returns (JsonObject memory)
        {
        obj.serialized = vulcan.hevm.serializeInt(obj.id, valueKey, value);
        return obj;
        }
    function serialize(JsonObject memory obj, string memory valueKey, address value)
        external
        returns (JsonObject memory) {
        obj.serialized = vulcan.hevm.serializeAddress(obj.id, valueKey, value);
        return obj;
        }
    function serialize(JsonObject memory obj, string memory valueKey, bytes32 value)
        external
        returns (JsonObject memory) {
        obj.serialized = vulcan.hevm.serializeBytes32(obj.id, valueKey, value);
        return obj;
        }
    function serialize(JsonObject memory obj, string memory valueKey, string memory value)
        external
        returns (JsonObject memory) {
        obj.serialized = vulcan.hevm.serializeString(obj.id, valueKey, value);
        return obj;
    }
    function serialize(JsonObject memory obj, string memory valueKey, bytes memory value)
        external
        returns (JsonObject memory) {
        obj.serialized = vulcan.hevm.serializeBytes(obj.id, valueKey, value);
        return obj;
        }

    function serialize(JsonObject memory obj, string memory valueKey, bool[] memory values)
        external
        returns (JsonObject memory) {
        obj.serialized = vulcan.hevm.serializeBool(obj.id, valueKey, values);
        return obj;
        }
    function serialize(JsonObject memory obj, string memory valueKey, uint256[] memory values)
        external
        returns (JsonObject memory) {
        obj.serialized = vulcan.hevm.serializeUint(obj.id, valueKey, values);
        return obj;
        }
    function serialize(JsonObject memory obj, string memory valueKey, int256[] memory values)
        external
        returns (JsonObject memory) {
        obj.serialized = vulcan.hevm.serializeInt(obj.id, valueKey, values);
        return obj;
        }
    function serialize(JsonObject memory obj, string memory valueKey, address[] memory values)
        external
        returns (JsonObject memory) {
        obj.serialized = vulcan.hevm.serializeAddress(obj.id, valueKey, values);
        return obj;
        }
    function serialize(JsonObject memory obj, string memory valueKey, bytes32[] memory values)
        external
        returns (JsonObject memory) {
        obj.serialized = vulcan.hevm.serializeBytes32(obj.id, valueKey, values);
        return obj;
        }
    function serialize(JsonObject memory obj, string memory valueKey, string[] memory values)
        external
        returns (JsonObject memory) {
        obj.serialized = vulcan.hevm.serializeString(obj.id, valueKey, values);
        return obj;
        }
    function serialize(JsonObject memory obj, string memory valueKey, bytes[] memory values)
        external
        returns (JsonObject memory) {
        obj.serialized = vulcan.hevm.serializeBytes(obj.id, valueKey, values);
        return obj;
        }

    function serialize(JsonObject memory obj, string memory valueKey, JsonObject memory value)
        external
        returns (JsonObject memory) {
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
    function write(JsonObject memory obj, string memory path) external {
        vulcan.hevm.writeJson(obj.serialized, path);
    }
    // Write a serialized JSON object to an **existing** JSON file, replacing a value with key = <value_key>
    // This is useful to replace a specific value of a JSON file, without having to parse the entire thing
    function write(JsonObject memory obj, string memory path, string memory valueKey) external {
        vulcan.hevm.writeJson(obj.serialized, path, valueKey);
    }
}

Json constant json = Json.wrap(0);

using JsonLib for Json global;
using JsonLib for JsonObject global;