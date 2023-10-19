// SPDX-License-Identifier: MIT
pragma solidity >=0.8.13 <0.9.0;

import {Pointer} from "./Pointer.sol";
import {ResultType, LibResultPointer} from "./Result.sol";
import {LibError, Error} from "./Error.sol";
import {accountsUnsafe as accounts} from "./Accounts.sol";
import "./Vulcan.sol";

struct JsonObject {
    string id;
    string serialized;
}

type JsonResult is bytes32;

library JsonError {
    using LibError for *;

    function Invalid() internal pure returns (Error) {
        return Invalid.encodeError("Invalid json");
    }

    function toJsonResult(Error self) internal pure returns (JsonResult) {
        return JsonResult.wrap(Pointer.unwrap(self.toPointer()));
    }
}

library LibJsonObjectPointer {
    function toJsonObject(Pointer self) internal pure returns (JsonObject memory obj) {
        assembly {
            obj := self
        }
    }

    function toJsonResult(Pointer self) internal pure returns (JsonResult result) {
        assembly {
            result := self
        }
    }

    function toPointer(JsonObject memory obj) internal pure returns (Pointer ptr) {
        assembly {
            ptr := obj
        }
    }
}

library LibJsonResult {
    function isOk(JsonResult self) internal pure returns (bool) {
        return LibResultPointer.isOk(self.toPointer());
    }

    function isError(JsonResult self) internal pure returns (bool) {
        return LibResultPointer.isError(self.toPointer());
    }

    function unwrap(JsonResult self) internal pure returns (JsonObject memory val) {
        return LibResultPointer.unwrap(self.toPointer()).toJsonObject();
    }

    function expect(JsonResult self, string memory err) internal pure returns (JsonObject memory) {
        return LibResultPointer.expect(self.toPointer(), err).toJsonObject();
    }

    function toError(JsonResult self) internal pure returns (Error) {
        return LibResultPointer.toError(self.toPointer());
    }

    function toValue(JsonResult self) internal pure returns (JsonObject memory val) {
        (, Pointer ptr) = LibResultPointer.decode(self.toPointer());

        return ptr.toJsonObject();
    }

    function toPointer(JsonResult self) internal pure returns (Pointer) {
        return Pointer.wrap(JsonResult.unwrap(self));
    }
}

function Ok(JsonObject memory value) pure returns (JsonResult) {
    return ResultType.Ok.encode(value.toPointer()).toJsonResult();
}

library json {
    using json for JsonObject;
    using JsonError for Error;

    /// @dev Parses a json object struct by key and returns an ABI encoded value.
    /// @param jsonObj The json object struct.
    /// @param key The key from the `jsonObject` to parse.
    /// @return abiEncodedData The ABI encoded tuple representing the value of the provided key.
    function getObject(JsonObject memory jsonObj, string memory key)
        internal
        pure
        returns (bytes memory abiEncodedData)
    {
        return vulcan.hevm.parseJson(jsonObj.serialized, key);
    }

    /// @dev Parses a json object struct and returns an ABI encoded tuple.
    /// @param jsonObj The json struct.
    /// @return abiEncodedData The ABI encoded tuple representing the json object.
    function parse(JsonObject memory jsonObj) internal pure returns (bytes memory abiEncodedData) {
        return vulcan.hevm.parseJson(jsonObj.serialized);
    }

    function isValid(string memory jsonObj) internal pure returns (bool) {
        try vulcan.hevm.parseJson(jsonObj) {
            return true;
        } catch {
            return false;
        }
    }

    function containsKey(JsonObject memory obj, string memory key) internal view returns (bool) {
        return vulcan.hevm.keyExists(obj.serialized, key);
    }

    /// @dev Parses the value of the `key` contained on `jsonStr` as uint256.
    /// @param obj The json object.
    /// @param key The key from the `jsonStr` to parse.
    /// @return The uint256 value.
    function getUint(JsonObject memory obj, string memory key) internal pure returns (uint256) {
        return vulcan.hevm.parseJsonUint(obj.serialized, key);
    }

    /// @dev Parses the value of the `key` contained on `jsonStr` as uint256[].
    /// @param obj The json object.
    /// @param key The key from the `jsonStr` to parse.
    /// @return The uint256[] value.
    function getUintArray(JsonObject memory obj, string memory key) internal pure returns (uint256[] memory) {
        return vulcan.hevm.parseJsonUintArray(obj.serialized, key);
    }

    /// @dev Parses the value of the `key` contained on `jsonStr` as int256.
    /// @param obj The json object.
    /// @param key The key from the `jsonStr` to parse.
    /// @return The int256 value.
    function getInt(JsonObject memory obj, string memory key) internal pure returns (int256) {
        return vulcan.hevm.parseJsonInt(obj.serialized, key);
    }

    /// @dev Parses the value of the `key` contained on `jsonStr` as int256[].
    /// @param obj The json object.
    /// @param key The key from the `jsonStr` to parse.
    /// @return The int256[] value.
    function getIntArray(JsonObject memory obj, string memory key) internal pure returns (int256[] memory) {
        return vulcan.hevm.parseJsonIntArray(obj.serialized, key);
    }

    /// @dev Parses the value of the `key` contained on `jsonStr` as bool.
    /// @param obj The json object.
    /// @param key The key from the `jsonStr` to parse.
    /// @return The bool value.
    function getBool(JsonObject memory obj, string memory key) internal pure returns (bool) {
        return vulcan.hevm.parseJsonBool(obj.serialized, key);
    }

    /// @dev Parses the value of the `key` contained on `jsonStr` as bool[].
    /// @param obj The json object.
    /// @param key The key from the `jsonStr` to parse.
    /// @return The bool[] value.
    function getBoolArray(JsonObject memory obj, string memory key) internal pure returns (bool[] memory) {
        return vulcan.hevm.parseJsonBoolArray(obj.serialized, key);
    }

    /// @dev Parses the value of the `key` contained on `jsonStr` as address.
    /// @param obj The json object.
    /// @param key The key from the `jsonStr` to parse.
    /// @return The address value.
    function getAddress(JsonObject memory obj, string memory key) internal pure returns (address) {
        return vulcan.hevm.parseJsonAddress(obj.serialized, key);
    }

    /// @dev Parses the value of the `key` contained on `jsonStr` as address.
    /// @param obj The json object.
    /// @param key The key from the `jsonStr` to parse.
    /// @return The address value.
    function getAddressArray(JsonObject memory obj, string memory key) internal pure returns (address[] memory) {
        return vulcan.hevm.parseJsonAddressArray(obj.serialized, key);
    }

    /// @dev Parses the value of the `key` contained on `jsonStr` as string.
    /// @param obj The json object.
    /// @param key The key from the `jsonStr` to parse.
    /// @return The string value.
    function getString(JsonObject memory obj, string memory key) internal pure returns (string memory) {
        return vulcan.hevm.parseJsonString(obj.serialized, key);
    }

    /// @dev Parses the value of the `key` contained on `jsonStr` as string[].
    /// @param obj The json object.
    /// @param key The key from the `jsonStr` to parse.
    /// @return The string[] value.
    function getStringArray(JsonObject memory obj, string memory key) internal pure returns (string[] memory) {
        return vulcan.hevm.parseJsonStringArray(obj.serialized, key);
    }

    /// @dev Parses the value of the `key` contained on `jsonStr` as bytes.
    /// @param obj The json object.
    /// @param key The key from the `jsonStr` to parse.
    /// @return The bytes value.
    function getBytes(JsonObject memory obj, string memory key) internal pure returns (bytes memory) {
        return vulcan.hevm.parseJsonBytes(obj.serialized, key);
    }

    /// @dev Parses the value of the `key` contained on `jsonStr` as bytes[].
    /// @param obj The json object.
    /// @param key The key from the `jsonStr` to parse.
    /// @return The bytes[] value.
    function getBytesArray(JsonObject memory obj, string memory key) internal pure returns (bytes[] memory) {
        return vulcan.hevm.parseJsonBytesArray(obj.serialized, key);
    }

    /// @dev Parses the value of the `key` contained on `jsonStr` as bytes32.
    /// @param obj The json object.
    /// @param key The key from the `jsonStr` to parse.
    /// @return The bytes32 value.
    function getBytes32(JsonObject memory obj, string memory key) internal pure returns (bytes32) {
        return vulcan.hevm.parseJsonBytes32(obj.serialized, key);
    }

    /// @dev Parses the value of the `key` contained on `jsonStr` as bytes32[].
    /// @param obj The json object.
    /// @param key The key from the `jsonStr` to parse.
    /// @return The bytes32[] value.
    function getBytes32Array(JsonObject memory obj, string memory key) internal pure returns (bytes32[] memory) {
        return vulcan.hevm.parseJsonBytes32Array(obj.serialized, key);
    }

    function getKeys(JsonObject memory obj, string memory key) internal pure returns (string[] memory) {
        return vulcan.hevm.parseJsonKeys(obj.serialized, key);
    }

    function getKeys(JsonObject memory obj) internal pure returns (string[] memory) {
        return getKeys(obj, "");
    }

    /// @dev Creates a new JsonObject struct.
    /// @return The JsonObject struct.
    function create() internal returns (JsonObject memory) {
        string memory id = string(abi.encodePacked(address(this), _incrementId()));
        return JsonObject({id: id, serialized: ""});
    }

    /// @dev Creates a new JsonObject struct.
    /// @return The JsonObject struct wrapped in a JsonResult.
    function create(string memory obj) internal returns (JsonResult) {
        if (!isValid(obj)) {
            return JsonError.Invalid().toJsonResult();
        }

        JsonObject memory jsonObj = create();
        jsonObj.serialized = vulcan.hevm.serializeJson(jsonObj.id, obj);

        return Ok(jsonObj);
    }

    /// @dev Serializes and sets the key and value for the provided json object.
    /// @param obj The json object to modify.
    /// @param key The key that will hold the `value`.
    /// @param value The value of `key`.
    /// @return res The modified JsonObject struct.
    function set(JsonObject memory obj, string memory key, bool value) internal returns (JsonObject memory res) {
        obj.serialized = vulcan.hevm.serializeBool(obj.id, key, value);
        return obj;
    }

    /// @dev Serializes and sets the key and value for the provided json object.
    /// @param obj The json object to modify.
    /// @param key The key that will hold the `value`.
    /// @param value The value of `key`.
    /// @return res The modified JsonObject struct.
    function set(JsonObject memory obj, string memory key, uint256 value) internal returns (JsonObject memory res) {
        obj.serialized = vulcan.hevm.serializeUint(obj.id, key, value);
        return obj;
    }

    /// @dev Serializes and sets the key and value for the provided json object.
    /// @param obj The json object to modify.
    /// @param key The key that will hold the `value`.
    /// @param value The value of `key`.
    /// @return res The modified JsonObject struct.
    function set(JsonObject memory obj, string memory key, int256 value) internal returns (JsonObject memory res) {
        obj.serialized = vulcan.hevm.serializeInt(obj.id, key, value);
        return obj;
    }

    /// @dev Serializes and sets the key and value for the provided json object.
    /// @param obj The json object to modify.
    /// @param key The key that will hold the `value`.
    /// @param value The value of `key`.
    /// @return res The modified JsonObject struct.
    function set(JsonObject memory obj, string memory key, address value) internal returns (JsonObject memory res) {
        obj.serialized = vulcan.hevm.serializeAddress(obj.id, key, value);
        return obj;
    }

    /// @dev Serializes and sets the key and value for the provided json object.
    /// @param obj The json object to modify.
    /// @param key The key that will hold the `value`.
    /// @param value The value of `key`.
    /// @return res The modified JsonObject struct.
    function set(JsonObject memory obj, string memory key, bytes32 value) internal returns (JsonObject memory res) {
        obj.serialized = vulcan.hevm.serializeBytes32(obj.id, key, value);
        return obj;
    }

    /// @dev Serializes and sets the key and value for the provided json object.
    /// @param obj The json object to modify.
    /// @param key The key that will hold the `value`.
    /// @param value The value of `key`.
    /// @return res The modified JsonObject struct.
    function set(JsonObject memory obj, string memory key, string memory value)
        internal
        returns (JsonObject memory res)
    {
        obj.serialized = vulcan.hevm.serializeString(obj.id, key, value);
        return obj;
    }

    /// @dev Serializes and sets the key and value for the provided json object.
    /// @param obj The json object to modify.
    /// @param key The key that will hold the `value`.
    /// @param value The value of `key`.
    /// @return res The modified JsonObject struct.
    function set(JsonObject memory obj, string memory key, bytes memory value)
        internal
        returns (JsonObject memory res)
    {
        obj.serialized = vulcan.hevm.serializeBytes(obj.id, key, value);
        return obj;
    }

    /// @dev Serializes and sets the key and value for the provided json object.
    /// @param obj The json object to modify.
    /// @param key The key that will hold the `value`.
    /// @param values The value of `key`.
    /// @return res The modified JsonObject struct.
    function set(JsonObject memory obj, string memory key, bool[] memory values)
        internal
        returns (JsonObject memory res)
    {
        obj.serialized = vulcan.hevm.serializeBool(obj.id, key, values);
        return obj;
    }

    /// @dev Serializes and sets the key and value for the provided json object.
    /// @param obj The json object to modify.
    /// @param key The key that will hold the `value`.
    /// @param values The value of `key`.
    /// @return res The modified JsonObject struct.
    function set(JsonObject memory obj, string memory key, uint256[] memory values)
        internal
        returns (JsonObject memory res)
    {
        obj.serialized = vulcan.hevm.serializeUint(obj.id, key, values);
        return obj;
    }

    /// @dev Serializes and sets the key and value for the provided json object.
    /// @param obj The json object to modify.
    /// @param key The key that will hold the `value`.
    /// @param values The value of `key`.
    /// @return res The modified JsonObject struct.
    function set(JsonObject memory obj, string memory key, int256[] memory values)
        internal
        returns (JsonObject memory res)
    {
        obj.serialized = vulcan.hevm.serializeInt(obj.id, key, values);
        return obj;
    }

    /// @dev Serializes and sets the key and value for the provided json object.
    /// @param obj The json object to modify.
    /// @param key The key that will hold the `value`.
    /// @param values The value of `key`.
    /// @return res The modified JsonObject struct.
    function set(JsonObject memory obj, string memory key, address[] memory values)
        internal
        returns (JsonObject memory res)
    {
        obj.serialized = vulcan.hevm.serializeAddress(obj.id, key, values);
        return obj;
    }

    /// @dev Serializes and sets the key and value for the provided json object.
    /// @param obj The json object to modify.
    /// @param key The key that will hold the `value`.
    /// @param values The value of `key`.
    /// @return res The modified JsonObject struct.
    function set(JsonObject memory obj, string memory key, bytes32[] memory values)
        internal
        returns (JsonObject memory res)
    {
        obj.serialized = vulcan.hevm.serializeBytes32(obj.id, key, values);
        return obj;
    }

    /// @dev Serializes and sets the key and value for the provided json object.
    /// @param obj The json object to modify.
    /// @param key The key that will hold the `value`.
    /// @param values The value of `key`.
    /// @return res The modified JsonObject struct.
    function set(JsonObject memory obj, string memory key, string[] memory values)
        internal
        returns (JsonObject memory res)
    {
        obj.serialized = vulcan.hevm.serializeString(obj.id, key, values);
        return obj;
    }

    /// @dev Serializes and sets the key and value for the provided json object.
    /// @param obj The json object to modify.
    /// @param key The key that will hold the `value`.
    /// @param values The value of `key`.
    /// @return res The modified JsonObject struct.
    function set(JsonObject memory obj, string memory key, bytes[] memory values)
        internal
        returns (JsonObject memory res)
    {
        obj.serialized = vulcan.hevm.serializeBytes(obj.id, key, values);
        return obj;
    }

    /// @dev Serializes and sets the key and value for the provided json object.
    /// @param obj The json object to modify.
    /// @param key The key that will hold the `value`.
    /// @param value The value of `key`.
    /// @return res The modified JsonObject struct.
    function set(JsonObject memory obj, string memory key, JsonObject memory value)
        internal
        returns (JsonObject memory res)
    {
        obj.serialized = vulcan.hevm.serializeString(obj.id, key, value.serialized);
        return obj;
    }

    /// @dev Writes a JsonObject struct to a file.
    /// @param obj The json object that will be stored as a file.
    /// @param path The path where the file will be saved.
    function write(JsonObject memory obj, string memory path) internal {
        vulcan.hevm.writeJson(obj.serialized, path);
    }

    /// @dev Writes a JsonObject struct to an existing json file modifying only a specific key.
    /// @param obj The json object that contains a value on `key`.
    /// @param key The key from `obj` that will be overwritten on the file.
    /// @param path The path where the file will be saved.
    function write(JsonObject memory obj, string memory path, string memory key) internal {
        vulcan.hevm.writeJson(obj.serialized, path, key);
    }

    function _incrementId() private returns (uint256 count) {
        bytes32 slot = keccak256("vulcan.json.id.counter");

        assembly {
            count := sload(slot)
            sstore(slot, add(count, 1))
        }
    }
}

// Local
using LibJsonObjectPointer for Pointer;
using LibJsonObjectPointer for JsonObject;

// Global
using json for JsonObject global;
using LibJsonResult for JsonResult global;
