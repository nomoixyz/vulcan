// SPDX-License-Identifier: MIT
pragma solidity >=0.8.13 <0.9.0;

import {Test} from "src/test.sol";
import {env} from "src/test/Env.sol";
import {Error} from "src/test/Error.sol";
import {expect} from "src/test/Expect.sol";
import {json} from "src/test/Json.sol";
import {vulcan} from "src/test/Vulcan.sol";
import {println} from "src/utils.sol";

import {LibError, Error} from "../../src/_internal/Error.sol";

function FooError(uint256 value) pure returns (Error) {
    return LibError.encodeError(FooError, "Foo error message", value);
}

function BarError(uint256 value) pure returns (Error) {
    return LibError.encodeError(BarError, "Bar error message", value);
}

function BazError(string memory value) pure returns (Error) {
    return LibError.encodeError(BazError, "Baz error message", value);
}

contract ErrorTest is Test {
    using LibError for *;

    function testErrorUint() external {
        Error err = FooError(123);

        expect(err.decodeAs(FooError)).toEqual(123);
        expect(err.matches(FooError)).toEqual(true);
        expect(err.matches(BarError)).toEqual(false);

        (bytes32 id, string memory message, bytes memory data) = err.decode();

        expect(id).toEqual(FooError.toErrorId());
        expect(message).toEqual("Foo error message");
        expect(data).toEqual(abi.encode(123));
    }

    function testErrorString() external {
        Error err = BazError("Hello, World!");

        expect(err.decodeAs(BazError)).toEqual("Hello, World!");
        expect(err.matches(BazError)).toEqual(true);
        expect(err.matches(FooError)).toEqual(false);

        (bytes32 id, string memory message, bytes memory data) = err.decode();

        expect(id).toEqual(BazError.toErrorId());
        expect(message).toEqual("Baz error message");
        expect(data).toEqual(abi.encode("Hello, World!"));
    }
}
