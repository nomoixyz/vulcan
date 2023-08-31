// SPDX-License-Identifier: MIT
pragma solidity >=0.8.13 <0.9.0;

struct Error {
    bytes32 id;
    string message;
}

enum ResultType {
    Error,
    Ok
}

struct Result {
    ResultType _type;
    bytes _data;
}

struct StringResult {
    Result _inner;
}

library LibResult {
    function isError(Result memory self) internal pure returns (bool) {
        return self._type == ResultType.Error;
    }

    function isOk(Result memory self) internal pure returns (bool) {
        return self._type == ResultType.Ok;
    }

    function toError(Result memory self) internal pure returns (Error memory) {
        return abi.decode(self._data, (Error));
    }

    function toValue(Result memory self) internal pure returns (bytes memory) {
        return self._data;
    }

    function unwrap(Result memory self) internal pure returns (bytes memory) {
        if (self.isError()) {
            revert(self.toError().message);
        }

        return self._data;
    }

    function expect(Result memory self, string memory err) internal pure returns (bytes memory) {
        if (self.isError()) {
            revert(err);
        }

        return self._data;
    }

    function toResult(Error memory error) internal pure returns (Result memory) {
        return Result({_type: ResultType.Error, _data: abi.encode(error)});
    }
}

library LibStringResult {
    function isOk(StringResult memory self) internal pure returns (bool) {
        return self._inner.isOk();
    }

    function isError(StringResult memory self) internal pure returns (bool) {
        return self._inner.isError();
    }

    function unwrap(StringResult memory self) internal pure returns (string memory) {
        return string(self._inner.unwrap());
    }

    function expect(StringResult memory self, string memory err) internal pure returns (string memory) {
        return string(self._inner.expect(err));
    }

    function toError(StringResult memory self) internal pure returns (Error memory) {
        return self._inner.toError();
    }

    function toValue(StringResult memory self) internal pure returns (string memory) {
        return string(self._inner.toValue());
    }
}

function Ok(bytes memory value) pure returns (Result memory) {
    return Result({_type: ResultType.Ok, _data: value});
}

function Ok(string memory value) pure returns (StringResult memory) {
    return StringResult(Ok(bytes(value)));
}

using LibStringResult for StringResult global;
using LibResult for Result global;
using LibResult for Error global;
