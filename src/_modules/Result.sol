// SPDX-License-Identifier: MIT
pragma solidity >=0.8.13 <0.9.0;

import {Pointer} from "./Pointer.sol";
import {Error} from "./Error.sol";

enum ResultType {
    Error,
    Ok
}

type Bytes32Result is bytes32;

type BytesResult is bytes32;

type StringResult is bytes32;

library LibResultPointer {
    using LibResultPointer for Pointer;

    function encode(ResultType _type, bytes32 _data) internal pure returns (Pointer pointer) {
        bytes memory data = abi.encode(_type, _data);

        assembly {
            pointer := data
        }
    }

    function decode(Pointer self) internal pure returns (ResultType, bytes32) {
        bytes memory data;
        assembly {
            data := self
        }
        return abi.decode(data, (ResultType, bytes32));
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
        (, bytes32 data) = decode(self);
        return Error.wrap(data);
    }

    function toValue(Pointer self) internal pure returns (bytes32) {
        (, bytes32 data) = decode(self);
        return data;
    }

    function unwrap(Pointer self) internal pure returns (bytes32) {
        if (self.isError()) {
            (, string memory message,) = self.toError().decode();
            revert(message);
        }

        return self.toValue();
    }

    function expect(Pointer self, string memory err) internal pure returns (bytes32) {
        if (self.isError()) {
            revert(err);
        }

        return self.toValue();
    }
}

library LibBytes32Result {
    using LibResultPointer for Pointer;

    function isError(Bytes32Result self) internal pure returns (bool) {
        return Pointer.wrap(Bytes32Result.unwrap(self)).isError();
    }

    function isOk(Bytes32Result self) internal pure returns (bool) {
        return Pointer.wrap(Bytes32Result.unwrap(self)).isOk();
    }

    function toError(Bytes32Result self) internal pure returns (Error) {
        return Pointer.wrap(Bytes32Result.unwrap(self)).toError();
    }

    function toValue(Bytes32Result self) internal pure returns (bytes32) {
        return Pointer.wrap(Bytes32Result.unwrap(self)).toValue();
    }

    function unwrap(Bytes32Result self) internal pure returns (bytes32) {
        return Pointer.wrap(Bytes32Result.unwrap(self)).unwrap();
    }

    function expect(Bytes32Result self, string memory err) internal pure returns (bytes32) {
        return Pointer.wrap(Bytes32Result.unwrap(self)).expect(err);
    }

    function asPointer(Bytes32Result self) internal pure returns (Pointer) {
        return Pointer.wrap(Bytes32Result.unwrap(self));
    }
}

library LibBytesResult {
    using LibResultPointer for Pointer;

    function isOk(BytesResult self) internal pure returns (bool) {
        return self.asPointer().isOk();
    }

    function isError(BytesResult self) internal pure returns (bool) {
        return self.asPointer().isError();
    }

    function unwrap(BytesResult self) internal pure returns (bytes memory val) {
        bytes32 _val = self.asPointer().unwrap();
        assembly {
            val := _val
        }
    }

    function expect(BytesResult self, string memory err) internal pure returns (bytes memory) {
        if (self.isError()) {
            revert(err);
        }

        return self.toValue();
    }

    function toError(BytesResult self) internal pure returns (Error) {
        return self.asPointer().toError();
    }

    function toValue(BytesResult self) internal pure returns (bytes memory val) {
        bytes32 _val = self.asPointer().toValue();
        assembly {
            val := _val
        }
    }

    function asPointer(BytesResult self) internal pure returns (Pointer) {
        return Pointer.wrap(BytesResult.unwrap(self));
    }
}

library LibStringResult {
    using LibResultPointer for Pointer;

    function isOk(StringResult self) internal pure returns (bool) {
        return self.asPointer().isOk();
    }

    function isError(StringResult self) internal pure returns (bool) {
        return self.asPointer().isError();
    }

    function unwrap(StringResult self) internal pure returns (string memory val) {
        bytes32 _val = self.asPointer().unwrap();
        assembly {
            val := _val
        }
    }

    function expect(StringResult self, string memory err) internal pure returns (string memory) {
        if (self.isError()) {
            revert(err);
        }

        return self.toValue();
    }

    function toError(StringResult self) internal pure returns (Error) {
        return Bytes32Result.wrap(StringResult.unwrap(self)).toError();
    }

    function toValue(StringResult self) internal pure returns (string memory val) {
        bytes32 _val = self.asPointer().toValue();
        assembly {
            val := _val
        }
    }

    function asPointer(StringResult self) internal pure returns (Pointer) {
        return Pointer.wrap(StringResult.unwrap(self));
    }
}

library LibResultType {
    function encode(ResultType _type, bytes32 _data) internal pure returns (Pointer result) {
        bytes memory data = abi.encode(_type, _data);
        assembly {
            result := data
        }
    }
}

function Ok(bytes32 value) pure returns (Bytes32Result) {
    return Bytes32Result.wrap(Pointer.unwrap(ResultType.Ok.encode(value)));
}

function Ok(bytes memory value) pure returns (BytesResult) {
    bytes32 _value;
    assembly {
        _value := value
    }
    return BytesResult.wrap(Pointer.unwrap(ResultType.Ok.encode(_value)));
}

function Ok(string memory value) pure returns (StringResult) {
    bytes32 _value;
    assembly {
        _value := value
    }
    return StringResult.wrap(Pointer.unwrap(ResultType.Ok.encode(_value)));
}

using LibStringResult for StringResult global;
using LibBytesResult for BytesResult global;
using LibBytes32Result for Bytes32Result global;
using LibResultType for ResultType global;
