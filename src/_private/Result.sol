// SPDX-License-Identifier: MIT
pragma solidity >=0.8.13 <0.9.0;

import {Pointer, LibPointer} from "./Pointer.sol";
import {Error} from "./Error.sol";

enum ResultType {
    Error,
    Ok
}

type Bytes32Result is bytes32;

type BytesResult is bytes32;

type StringResult is bytes32;

type BoolResult is bytes32;

type EmptyResult is bytes32;

library LibResultPointer {
    function decode(Pointer self) internal pure returns (ResultType, Pointer) {
        (ResultType resultType, bytes32 memoryAddr) = abi.decode(self.asBytes(), (ResultType, bytes32));

        return (resultType, Pointer.wrap(memoryAddr));
    }

    function isError(Pointer self) internal pure returns (bool) {
        (ResultType _type,) = decode(self);
        return _type == ResultType.Error;
    }

    function isOk(Pointer self) internal pure returns (bool) {
        (ResultType _type,) = decode(self);
        return _type == ResultType.Ok;
    }

    function toError(Pointer self) internal pure returns (Error) {
        (, Pointer ptr) = decode(self);

        return Error.wrap(ptr.asBytes32());
    }

    function unwrap(Pointer self) internal pure returns (Pointer ptr) {
        if (isError(self)) {
            (, string memory message,) = toError(self).decode();
            revert(message);
        }

        (, ptr) = decode(self);
    }

    function expect(Pointer self, string memory err) internal pure returns (Pointer ptr) {
        if (isError(self)) {
            revert(err);
        }

        (, ptr) = decode(self);
    }
}

library LibBytes32ResultPointer {
    function toBytes32Result(Pointer self) internal pure returns (Bytes32Result res) {
        assembly {
            res := self
        }
    }
}

library LibBytes32Result {
    function isError(Bytes32Result self) internal pure returns (bool) {
        return LibResultPointer.isError(Pointer.wrap(Bytes32Result.unwrap(self)));
    }

    function isOk(Bytes32Result self) internal pure returns (bool) {
        return LibResultPointer.isOk(Pointer.wrap(Bytes32Result.unwrap(self)));
    }

    function toError(Bytes32Result self) internal pure returns (Error) {
        return LibResultPointer.toError(Pointer.wrap(Bytes32Result.unwrap(self)));
    }

    function toValue(Bytes32Result self) internal pure returns (bytes32) {
        (, Pointer ptr) = LibResultPointer.decode(self.toPointer());

        return ptr.asBytes32();
    }

    function unwrap(Bytes32Result self) internal pure returns (bytes32) {
        return LibResultPointer.unwrap(Pointer.wrap(Bytes32Result.unwrap(self))).asBytes32();
    }

    function expect(Bytes32Result self, string memory err) internal pure returns (bytes32) {
        return LibResultPointer.expect(Pointer.wrap(Bytes32Result.unwrap(self)), err).asBytes32();
    }

    function toPointer(Bytes32Result self) internal pure returns (Pointer) {
        return Pointer.wrap(Bytes32Result.unwrap(self));
    }
}

library LibBytesResultPointer {
    function toBytesResult(Pointer self) internal pure returns (BytesResult res) {
        assembly {
            res := self
        }
    }
}

library LibBytesResult {
    function isOk(BytesResult self) internal pure returns (bool) {
        return LibResultPointer.isOk(self.toPointer());
    }

    function isError(BytesResult self) internal pure returns (bool) {
        return LibResultPointer.isError(self.toPointer());
    }

    function unwrap(BytesResult self) internal pure returns (bytes memory) {
        return LibResultPointer.unwrap(self.toPointer()).asBytes();
    }

    function expect(BytesResult self, string memory err) internal pure returns (bytes memory) {
        return LibResultPointer.expect(self.toPointer(), err).asBytes();
    }

    function toError(BytesResult self) internal pure returns (Error) {
        return LibResultPointer.toError(self.toPointer());
    }

    function toValue(BytesResult self) internal pure returns (bytes memory) {
        (, Pointer ptr) = LibResultPointer.decode(self.toPointer());

        return ptr.asBytes();
    }

    function toPointer(BytesResult self) internal pure returns (Pointer) {
        return Pointer.wrap(BytesResult.unwrap(self));
    }
}

library LibStringResultPointer {
    function toStringResult(Pointer self) internal pure returns (StringResult res) {
        assembly {
            res := self
        }
    }
}

library LibStringResult {
    function isOk(StringResult self) internal pure returns (bool) {
        return LibResultPointer.isOk(self.toPointer());
    }

    function isError(StringResult self) internal pure returns (bool) {
        return LibResultPointer.isError(self.toPointer());
    }

    function unwrap(StringResult self) internal pure returns (string memory val) {
        return LibResultPointer.unwrap(self.toPointer()).asString();
    }

    function expect(StringResult self, string memory err) internal pure returns (string memory) {
        return LibResultPointer.expect(self.toPointer(), err).asString();
    }

    function toError(StringResult self) internal pure returns (Error) {
        return LibResultPointer.toError(Pointer.wrap(StringResult.unwrap(self)));
    }

    function toValue(StringResult self) internal pure returns (string memory val) {
        (, Pointer ptr) = LibResultPointer.decode(self.toPointer());

        return ptr.asString();
    }

    function toPointer(StringResult self) internal pure returns (Pointer) {
        return Pointer.wrap(StringResult.unwrap(self));
    }
}

library LibBoolResultPointer {
    function toBoolResult(Pointer self) internal pure returns (BoolResult res) {
        assembly {
            res := self
        }
    }
}

library LibBoolResult {
    function isOk(BoolResult self) internal pure returns (bool) {
        return LibResultPointer.isOk(self.toPointer());
    }

    function isError(BoolResult self) internal pure returns (bool) {
        return LibResultPointer.isError(self.toPointer());
    }

    function unwrap(BoolResult self) internal pure returns (bool val) {
        return LibResultPointer.unwrap(self.toPointer()).asBool();
    }

    function expect(BoolResult self, string memory err) internal pure returns (bool) {
        return LibResultPointer.expect(self.toPointer(), err).asBool();
    }

    function toError(BoolResult self) internal pure returns (Error) {
        return LibResultPointer.toError(Pointer.wrap(BoolResult.unwrap(self)));
    }

    function toValue(BoolResult self) internal pure returns (bool val) {
        (, Pointer ptr) = LibResultPointer.decode(self.toPointer());

        return ptr.asBool();
    }

    function toPointer(BoolResult self) internal pure returns (Pointer) {
        return Pointer.wrap(BoolResult.unwrap(self));
    }
}

library LibEmptyResultPointer {
    function toEmptyResult(Pointer self) internal pure returns (EmptyResult res) {
        assembly {
            res := self
        }
    }
}

library LibEmptyResult {
    function isOk(EmptyResult self) internal pure returns (bool) {
        return LibResultPointer.isOk(self.toPointer());
    }

    function isError(EmptyResult self) internal pure returns (bool) {
        return LibResultPointer.isError(self.toPointer());
    }

    function unwrap(EmptyResult self) internal pure {
        LibResultPointer.unwrap(self.toPointer());
    }

    function expect(EmptyResult self, string memory err) internal pure {
        LibResultPointer.expect(self.toPointer(), err);
    }

    function toError(EmptyResult self) internal pure returns (Error) {
        return LibResultPointer.toError(self.toPointer());
    }

    function toPointer(EmptyResult self) internal pure returns (Pointer) {
        return Pointer.wrap(EmptyResult.unwrap(self));
    }
}

library LibResultType {
    function encode(ResultType _type, Pointer _dataPtr) internal pure returns (Pointer result) {
        bytes memory data = abi.encode(_type, _dataPtr);
        assembly {
            result := data
        }
    }
}

function Ok() pure returns (EmptyResult) {
    Pointer ptr;
    return ResultType.Ok.encode(ptr).toEmptyResult();
}

function Ok(bytes32 value) pure returns (Bytes32Result) {
    return ResultType.Ok.encode(value.toPointer()).toBytes32Result();
}

function Ok(bytes memory value) pure returns (BytesResult) {
    return ResultType.Ok.encode(value.toPointer()).toBytesResult();
}

function Ok(string memory value) pure returns (StringResult) {
    return ResultType.Ok.encode(value.toPointer()).toStringResult();
}

function Ok(bool value) pure returns (BoolResult) {
    return ResultType.Ok.encode(value.toPointer()).toBoolResult();
}

// Local
using LibPointer for bytes32;
using LibPointer for bytes;
using LibPointer for string;
using LibPointer for address;
using LibPointer for bool;
using LibPointer for uint256;
using LibPointer for int256;
using LibEmptyResultPointer for Pointer;
using LibBytes32ResultPointer for Pointer;
using LibBytesResultPointer for Pointer;
using LibStringResultPointer for Pointer;
using LibBoolResultPointer for Pointer;

// Global
using LibStringResult for StringResult global;
using LibBytesResult for BytesResult global;
using LibBoolResult for BoolResult global;
using LibEmptyResult for EmptyResult global;
using LibBytes32Result for Bytes32Result global;
using LibResultType for ResultType global;
