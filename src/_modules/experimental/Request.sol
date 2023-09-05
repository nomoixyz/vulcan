// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Command, CommandResult, CommandOutput, commands} from "../Commands.sol";
import {JsonObject, json as jsonModule, JsonResult, Ok} from "../Json.sol";

import {Result, Error, StringResult, Ok} from "../Result.sol";

enum Method {
    GET,
    POST,
    PUT,
    PATCH,
    DELETE
}

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

struct Request {
    Method method;
    string url;
    Header[] headers;
    bytes body;
}

struct RequestResult {
    Result _inner;
}

// TODO: headers, etc
struct Response {
    string url;
    uint256 status;
    bytes body;
}

struct ResponseResult {
    Result _inner;
}

library request {
    using request for *;

    // Return an empty client
    function create() internal pure returns (RequestClient memory) {}

    function get(string memory url) internal returns (ResponseResult memory) {
        return create().get(url).send();
    }
}

library RequestError {
    bytes32 constant COMMAND_FAILED = keccak256("COMMAND_FAILED");

    function commandFailed() public pure returns (ResponseResult memory) {
        return ResponseResult(Error(COMMAND_FAILED, "Command failed").toResult());
    }
}

library LibRequestResult {
    function isOk(RequestResult memory self) internal pure returns (bool) {
        return self._inner.isOk();
    }

    function isError(RequestResult memory self) internal pure returns (bool) {
        return self._inner.isError();
    }

    function unwrap(RequestResult memory self) internal pure returns (Request memory) {
        return abi.decode(self._inner.unwrap(), (Request));
    }

    function expect(RequestResult memory self, string memory err) internal pure returns (Request memory) {
        return abi.decode(self._inner.expect(err), (Request));
    }

    function toError(RequestResult memory self) internal pure returns (Error memory) {
        return self._inner.toError();
    }

    function toValue(RequestResult memory self) internal pure returns (Request memory) {
        return abi.decode(self._inner.toValue(), (Request));
    }
}

library LibResponseResult {
    function isOk(ResponseResult memory self) internal pure returns (bool) {
        return self._inner.isOk();
    }

    function isError(ResponseResult memory self) internal pure returns (bool) {
        return self._inner.isError();
    }

    function unwrap(ResponseResult memory self) internal pure returns (Response memory) {
        return abi.decode(self._inner.unwrap(), (Response));
    }

    function expect(ResponseResult memory self, string memory err) internal pure returns (Response memory) {
        return abi.decode(self._inner.expect(err), (Response));
    }

    function toError(ResponseResult memory self) internal pure returns (Error memory) {
        return self._inner.toError();
    }

    function toValue(ResponseResult memory self) internal pure returns (Response memory) {
        return abi.decode(self._inner.toValue(), (Response));
    }
}

library LibRequestClient {
    function get(RequestClient memory self, string memory url) internal pure returns (RequestBuilder memory) {
        return LibRequestBuilder.create(self, Method.GET, url);
    }

    function del(RequestClient memory self, string memory url) internal pure returns (RequestBuilder memory) {
        return LibRequestBuilder.create(self, Method.DELETE, url);
    }

    function patch(RequestClient memory self, string memory url) internal pure returns (RequestBuilder memory) {
        return LibRequestBuilder.create(self, Method.PATCH, url);
    }

    function post(RequestClient memory self, string memory url) internal pure returns (RequestBuilder memory) {
        return LibRequestBuilder.create(self, Method.POST, url);
    }

    function put(RequestClient memory self, string memory url) internal pure returns (RequestBuilder memory) {
        return LibRequestBuilder.create(self, Method.PUT, url);
    }
}

library LibRequestBuilder {
    using request for *;

    function create(RequestClient memory client, Method method, string memory url)
        internal
        pure
        returns (RequestBuilder memory builder)
    {
        builder.client = client;
        builder.request = Ok(Request({method: method, url: url, headers: new Header[](0), body: new bytes(0)}));
    }

    function send(RequestBuilder memory self) internal returns (ResponseResult memory) {
        RequestResult memory reqResult = self.build();

        if (reqResult.isError()) {
            return ResponseResult(reqResult.toError().toResult());
        }

        Request memory req = reqResult.toValue();

        (string(req.toCommand().toString()));

        CommandResult memory result = req.toCommand().run();

        if (result.isError()) {
            return ResponseResult(result.toError().toResult());
        }

        CommandOutput memory cmdOutput = result.toValue();

        (uint256 status, bytes memory _body) = abi.decode(cmdOutput.stdout, (uint256, bytes));

        return Ok(Response({url: req.url, status: status, body: _body}));
    }

    function build(RequestBuilder memory self) internal pure returns (RequestResult memory) {
        return self.request;
    }

    function body(RequestBuilder memory self, string memory _body) internal pure returns (RequestBuilder memory) {
        if (self.request.isError()) {
            return self;
        }

        Request memory req = self.request.toValue();
        req.body = bytes(_body);
        self.request = Ok(req);
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
        if (self.request.isError()) {
            return self;
        }

        Request memory req = self.request.toValue();
        uint256 len = req.headers.length;
        req.headers = new Header[](len + 1);
        for (uint256 i; i < len; i++) {
            req.headers[i] = req.headers[i];
        }
        req.headers[len] = Header({key: key, value: value});
        self.request = Ok(req);
        return self;
    }

    function json(RequestBuilder memory self, JsonObject memory obj) internal pure returns (RequestBuilder memory) {
        // We assume the json has already been validated
        return self.header("Content-Type", "application/json").body(obj.serialized);
    }

    function json(RequestBuilder memory self, string memory serialized) internal pure returns (RequestBuilder memory) {
        if (self.request.isError()) {
            return self;
        }

        JsonResult memory res = jsonModule.create(serialized);
        if (res.isError()) {
            self.request = RequestResult(res._inner);
            return self;
        }

        return self.json(res.toValue());
    }
}

library LibRequest {
    function toCommand(Request memory self) internal pure returns (Command memory) {
        // Adapted from https://github.com/memester-xyz/surl/blob/034c912ae9b5e707a5afd21f145b452ad8e800df/src/Surl.sol#L90
        string memory script =
            string.concat('response=$(curl -s -w "\\n%{http_code}" ', self.url, " -X ", toString(self.method));

        for (uint256 i; i < self.headers.length; i++) {
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

library LibResponse {
    function json(Response memory self) internal pure returns (JsonResult memory) {
        // create() will validate the json
        return jsonModule.create(string(self.body));
    }

    function text(Response memory self) internal pure returns (StringResult memory) {
        // TODO: maybe do some encoding validation? or check not empty?
        return Ok(string(self.body));
    }

    // function asBytes(Response memory self) internal pure returns (BytesResult memory) {
    //     return BytesResult({value: self.body, ok: true, error: ""});
    // }
}

function Ok(Request memory value) pure returns (RequestResult memory) {
    return RequestResult(Ok(abi.encode(value)));
}

function Ok(Response memory value) pure returns (ResponseResult memory) {
    return ResponseResult(Ok(abi.encode(value)));
}

using LibRequestClient for RequestClient global;
using LibRequest for Request global;
using LibResponse for Response global;
using LibRequestBuilder for RequestBuilder global;
using LibRequestResult for RequestResult global;
using LibResponseResult for ResponseResult global;
