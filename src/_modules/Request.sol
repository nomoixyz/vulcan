// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Command, CommandResult, commands} from "./Commands.sol";
import {JsonObject, json as jsonModule} from "./Json.sol";

import {Error, JsonResult, StringResult, BytesResult} from "../_result/Result.sol";

struct Header {
    string key;
    string value;
}

struct RequestClient {
    // Default headers, not used yet
    Header[] headers;
}

struct RequestBuilder {
    RequestClient client;
    RequestResult request;
}

enum Method {
    GET,
    POST,
    PUT,
    PATCH,
    DELETE
}

struct Request {
    Method method;
    string url;
    Header[] headers;
    bytes body;
}

struct RequestResult {
    Request value;
    Error _error;
}

// TODO: headers, etc
struct Response {
    string url;
    uint256 status;
    bytes body;
}

struct ResponseResult {
    Response value;
    Error _error;
}

library RequestError {
    bytes32 constant COMMAND_FAILED = keccak256("COMMAND_FAILED");

    function commandFailed() public pure returns (ResponseResult memory res) {
        res._error = Error({message: "Command failed", id: COMMAND_FAILED});
    }
}

library RequestResultLib {
    function isOk(RequestResult memory self) internal pure returns (bool) {
        return self._error.id == bytes32(0);
    }

    function isError(RequestResult memory self) internal pure returns (bool) {
        return !self.isOk();
    }

    /// @dev Returns the output of a `RequestResult` or reverts if the result was an error.
    function unwrap(RequestResult memory self) internal pure returns (Request memory) {
        return expect(self, self._error.message);
    }

    /// @dev Returns the output of a `RequestResult` or reverts if the result was an error.
    /// @param error The error message that will be used when reverting.
    function expect(RequestResult memory self, string memory error) internal pure returns (Request memory) {
        if (self.isError()) {
            revert(error);
        }

        return self.value;
    }
}

library ResponseResultLib {
    /// @dev Checks if a `ResponseResult` is not an error.
    function isOk(ResponseResult memory self) internal pure returns (bool) {
        return self._error.id == bytes32(0);
    }

    /// @dev Checks if a `ResponseResult` struct is an error.
    function isError(ResponseResult memory self) internal pure returns (bool) {
        return !self.isOk();
    }

    /// @dev Returns the value of a `ResponseResult` or reverts if the result was an error.
    function unwrap(ResponseResult memory self) internal pure returns (Response memory) {
        return expect(self, self._error.message);
    }

    /// @dev Returns the value of a `ResponseResult` or reverts if the result was an error.
    /// @param error The error message that will be used when reverting.
    function expect(ResponseResult memory self, string memory error) internal pure returns (Response memory) {
        if (self.isError()) {
            revert(error);
        }

        return self.value;
    }
}

library request {
    using request for *;

    // Return an empty client
    function create() internal pure returns (RequestClient memory) {}

    function get(string memory url) internal returns (ResponseResult memory) {
        return create().get(url).send();
    }

    function get(RequestClient memory self, string memory url) internal pure returns (RequestBuilder memory) {
        return requestBuilder.create(self, Method.GET, url);
    }

    function del(RequestClient memory self, string memory url) internal pure returns (RequestBuilder memory) {
        return requestBuilder.create(self, Method.DELETE, url);
    }

    function patch(RequestClient memory self, string memory url) internal pure returns (RequestBuilder memory) {
        return requestBuilder.create(self, Method.PATCH, url);
    }

    function post(RequestClient memory self, string memory url) internal pure returns (RequestBuilder memory) {
        return requestBuilder.create(self, Method.POST, url);
    }

    function put(RequestClient memory self, string memory url) internal pure returns (RequestBuilder memory) {
        return requestBuilder.create(self, Method.PUT, url);
    }

    function toCommand(Request memory self) internal pure returns (Command memory) {
        // Adapted from https://github.com/memester-xyz/surl/blob/034c912ae9b5e707a5afd21f145b452ad8e800df/src/Surl.sol#L90
        string memory script =
            string.concat('response=$(curl -s -w "\\n%{http_code}" ', self.url, " -X ", toString(self.method));

        for (uint256 i = 0; i < self.headers.length; i++) {
            script = string.concat(script, " -H ", '"', self.headers[i].key, ": ", self.headers[i].value, '"');
        }

        if (self.body.length > 0) {
            script = string.concat(script, " -d ", "'", string(self.body), "'");
        }

        script = string.concat(
            script,
            ');body=$(sed "$ d" <<< "$response" | tr -d "\\n");code=$(tail -n 1 <<< "$response");cast abi-encode "response(uint256,string)" "$code" "$body";'
        );

        return commands.create("bash").arg("-c").arg(script);
    }

    function toString(Method method) internal pure returns (string memory) {
        if (method == Method.GET) {
            return "GET";
        } else if (method == Method.POST) {
            return "POST";
        } else if (method == Method.PUT) {
            return "PUT";
        } else if (method == Method.PATCH) {
            return "PATCH";
        } else if (method == Method.DELETE) {
            return "DELETE";
        }

        // Should never happen
        revert("Invalid method");
    }
}

library requestBuilder {
    using request for *;

    function create(RequestClient memory client, Method method, string memory url)
        internal
        pure
        returns (RequestBuilder memory builder)
    {
        builder.client = client;
        builder.request.value = Request({method: method, url: url, headers: new Header[](0), body: new bytes(0)});
    }

    function send(RequestBuilder memory self) internal returns (ResponseResult memory res) {
        RequestResult memory reqResult = self.build();

        if (reqResult.isError()) {
            res._error = reqResult._error;
            return res;
        }

        Request memory req = reqResult.value;

        (string(req.toCommand().toString()));

        CommandResult memory result = req.toCommand().run();

        if (result.isError()) {
            return RequestError.commandFailed();
        }

        (uint256 status, bytes memory _body) = abi.decode(result.stdout, (uint256, bytes));

        res.value = Response({url: req.url, status: status, body: _body});
    }

    function build(RequestBuilder memory self) internal pure returns (RequestResult memory) {
        return self.request;
    }

    function body(RequestBuilder memory self, string memory _body) internal pure returns (RequestBuilder memory) {
        if (self.request.isOk()) {
            self.request.value.body = bytes(_body);
        }
        return self;
    }

    function basicAuth(RequestBuilder memory self, string memory username, string memory password)
        internal
        pure
        returns (RequestBuilder memory)
    {
        // "Authorization: Basic $(base64 <<<"joeuser:secretpass")"
        return self.header("Authorization", string.concat('Basic $(echo -n "', username, ":", password, '" | base64)'));
    }

    function bearerAuth(RequestBuilder memory self, string memory token)
        internal
        pure
        returns (RequestBuilder memory)
    {
        return self.header("Authorization", string.concat("Bearer ", token));
    }

    function header(RequestBuilder memory self, string memory key, string memory value)
        internal
        pure
        returns (RequestBuilder memory)
    {
        if (self.request.isOk()) {
            uint256 len = self.request.value.headers.length;
            self.request.value.headers = new Header[](len + 1);
            for (uint256 i = 0; i < len; i++) {
                self.request.value.headers[i] = self.request.value.headers[i];
            }
            self.request.value.headers[len] = Header({key: key, value: value});
        }
        return self;
    }

    function json(RequestBuilder memory self, JsonObject memory obj) internal pure returns (RequestBuilder memory) {
        return self.json(obj.serialized);
    }

    function json(RequestBuilder memory self, string memory serialized) internal pure returns (RequestBuilder memory) {
        // TODO: parse json and set error if it fails
        return self.header("Content-Type", "application/json").body(serialized);
    }
}

library response {
    // TODO: validate response and return error if there are issues
    function json(Response memory self) internal pure returns (JsonResult memory res) {
        res.value = jsonModule.create(string(self.body));
    }

    function text(Response memory self) internal pure returns (StringResult memory res) {
        res.value = string(self.body);
    }

    // function asBytes(Response memory self) internal pure returns (BytesResult memory) {
    //     return BytesResult({value: self.body, ok: true, error: ""});
    // }
}

using response for Response global;
using response for Request global;
using request for RequestClient global;
using request for Request global;
using requestBuilder for RequestBuilder global;

using RequestResultLib for RequestResult global;
using ResponseResultLib for ResponseResult global;
