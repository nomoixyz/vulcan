// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {LibResult, Result, ResultType} from "./Result.sol";

type Error is bytes32;

library LibError {
    using LibError for *;

    function toResult(Error err) internal pure returns (Result) {
        return LibResult.encode(ResultType.Error, Error.unwrap(err));
    }

    // Used internally by error functions

    function decode(Error err) internal pure returns (bytes32 id, string memory message, bytes memory data) {
        bytes memory errorData;
        assembly {
            errorData := err
        }
        return abi.decode(errorData, (bytes32, string, bytes));
    }

    /* Function definitions for multiple permutations of function types */

    // ()
    function encodeError(function() returns(Error) fn, string memory message) internal pure returns (Error err) {
        bytes memory data = abi.encode(fn.toErrorId(), message, "");
        assembly {
            err := data
        }
    }

    function toErrorId(function() returns(Error) fn) internal pure returns (bytes32 id) {
        assembly {
            id := fn
        }
    }

    function matches(Error err, function() returns(Error) fn) internal pure returns (bool) {
        (bytes32 id,,) = decode(err);
        return id == toErrorId(fn);
    }

    function decodeAs(Error, function() returns(Error)) internal pure {
        revert("No data to decode!");
    }

    // (uint256)

    function encodeError(function(uint256) returns(Error) fn, string memory message, uint256 p0)
        internal
        pure
        returns (Error err)
    {
        bytes memory data = abi.encode(fn.toErrorId(), message, abi.encode(p0));
        assembly {
            err := data
        }
    }

    function toErrorId(function(uint256) returns(Error) fn) internal pure returns (bytes32 id) {
        assembly {
            id := fn
        }
    }

    function matches(Error err, function(uint256) returns(Error) fn) internal pure returns (bool) {
        (bytes32 id,,) = decode(err);
        return id == toErrorId(fn);
    }

    function decodeAs(Error err, function(uint256) returns(Error)) internal pure returns (uint256) {
        (,, bytes memory data) = decode(err);
        return abi.decode(data, (uint256));
    }

    // (string)

    function encodeError(function(string memory) returns(Error) fn, string memory message, string memory p0)
        internal
        pure
        returns (Error err)
    {
        bytes memory data = abi.encode(fn.toErrorId(), message, abi.encode(p0));
        assembly {
            err := data
        }
    }

    function toErrorId(function(string memory) returns(Error) fn) internal pure returns (bytes32 id) {
        assembly {
            id := fn
        }
    }

    function matches(Error err, function(string memory) returns(Error) fn) internal pure returns (bool) {
        (bytes32 id,,) = decode(err);
        return id == toErrorId(fn);
    }

    function decodeAs(Error err, function(string memory) returns(Error)) internal pure returns (string memory) {
        (,, bytes memory data) = decode(err);
        return abi.decode(data, (string));
    }
}

using LibError for Error global;
