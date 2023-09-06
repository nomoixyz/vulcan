// SPDX-License-Identifier: MIT
pragma solidity >=0.8.13 <0.9.0;

import {Error} from "./Error.sol";

enum ResultType {
    Error,
    Ok
}

type Result is bytes32;

type BytesResult is bytes32;

type StringResult is bytes32;

library LibResult {
    function decode(Result self) internal pure returns (ResultType, bytes32) {
        bytes memory data;
        assembly {
            data := self
        }
        return abi.decode(data, (ResultType, bytes32));
    }

    function encode(ResultType _type, bytes32 _data) internal pure returns (Result result) {
        bytes memory data = abi.encode(_type, _data);
        assembly {
            result := data
        }
    }

    function isError(Result self) internal pure returns (bool) {
        (ResultType _type,) = decode(self);
        return _type == ResultType.Error;
    }

    function isOk(Result self) internal pure returns (bool) {
        (ResultType _type,) = decode(self);
        return _type == ResultType.Ok;
    }

    function toError(Result self) internal pure returns (Error) {
        (, bytes32 data) = decode(self);
        return Error.wrap(data);
    }

    function toValue(Result self) internal pure returns (bytes32) {
        (, bytes32 data) = decode(self);
        return data;
    }

    function unwrap(Result self) internal pure returns (bytes32) {
        if (self.isError()) {
            (, string memory message,) = self.toError().decode();
            revert(message);
        }

        return self.toValue();
    }

    function expect(Result self, string memory err) internal pure returns (bytes32) {
        if (self.isError()) {
            revert(err);
        }

        return self.toValue();
    }
}

library LibBytesResult {
    function isOk(BytesResult self) internal pure returns (bool) {
        return self.asResult().isOk();
    }

    function isError(BytesResult self) internal pure returns (bool) {
        return self.asResult().isError();
    }

    function unwrap(BytesResult self) internal pure returns (bytes memory val) {
        bytes32 _val = self.asResult().unwrap();
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
        return self.asResult().toError();
    }

    function toValue(BytesResult self) internal pure returns (bytes memory val) {
        bytes32 _val = self.asResult().toValue();
        assembly {
            val := _val
        }
    }

    function asResult(BytesResult self) internal pure returns (Result) {
        return Result.wrap(BytesResult.unwrap(self));
    }
}

library LibStringResult {
    function isOk(StringResult self) internal pure returns (bool) {
        return self.asResult().isOk();
    }

    function isError(StringResult self) internal pure returns (bool) {
        return self.asResult().isError();
    }

    function unwrap(StringResult self) internal pure returns (string memory val) {
        bytes32 _val = self.asResult().unwrap();
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
        return Result.wrap(StringResult.unwrap(self)).toError();
    }

    function toValue(StringResult self) internal pure returns (string memory val) {
        bytes32 _val = self.asResult().toValue();
        assembly {
            val := _val
        }
    }

    function asResult(StringResult self) internal pure returns (Result) {
        return Result.wrap(StringResult.unwrap(self));
    }
}

function Ok(bytes32 value) pure returns (Result) {
    return LibResult.encode(ResultType.Ok, value);
}

function Ok(bytes memory value) pure returns (BytesResult) {
    bytes32 _value;
    assembly {
        _value := value
    }
    return BytesResult.wrap(Result.unwrap(Ok(_value)));
}

function Ok(string memory value) pure returns (StringResult) {
    bytes32 _value;
    assembly {
        _value := value
    }
    return StringResult.wrap(Result.unwrap(Ok(_value)));
}

using LibStringResult for StringResult global;
using LibBytesResult for BytesResult global;
using LibResult for Result global;
