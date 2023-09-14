// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Command, CommandResult, CommandOutput, commands} from "../Commands.sol";
import {JsonObject, json as jsonModule, JsonResult, Ok} from "../Json.sol";

import {Pointer} from "../Pointer.sol";
import {BytesResult, StringResult, Ok, ResultType, LibResultPointer} from "../Result.sol";
import {LibError, Error} from "../Error.sol";

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

type RequestResult is bytes32;

// TODO: headers, etc
struct Response {
    string url;
    uint256 status;
    bytes body;
}

type ResponseResult is bytes32;

library request {
    using request for *;

    // Return an empty client
    function create() internal pure returns (RequestClient memory) {}

    function get(string memory url) internal returns (ResponseResult) {
        return create().get(url).send();
    }
}

library RequestError {
    using LibError for *;

    function CommandFailed() internal pure returns (Error) {
        return CommandFailed.encodeError("Command failed");
    }

    function toRequestResult(Error self) internal pure returns (RequestResult) {
        return RequestResult.wrap(Pointer.unwrap(self.toPointer()));
    }

    function toResponseResult(Error self) internal pure returns (ResponseResult) {
        return ResponseResult.wrap(Pointer.unwrap(self.toPointer()));
    }
}

library LibRequestPointer {
    function toRequest(Pointer self) internal pure returns (Request memory req) {
        assembly {
            req := self
        }
    }

    function toRequestResult(Pointer self) internal pure returns (RequestResult result) {
        assembly {
            result := self
        }
    }

    function toPointer(Request memory self) internal pure returns (Pointer ptr) {
        assembly {
            ptr := self
        }
    }
}

library LibRequestResult {
    using LibRequestPointer for Pointer;

    function isOk(RequestResult self) internal pure returns (bool) {
        return LibResultPointer.isOk(self.toPointer());
    }

    function isError(RequestResult self) internal pure returns (bool) {
        return LibResultPointer.isError(self.toPointer());
    }

    function unwrap(RequestResult self) internal pure returns (Request memory val) {
        return LibResultPointer.unwrap(self.toPointer()).toRequest();
    }

    function expect(RequestResult self, string memory err) internal pure returns (Request memory) {
        return LibResultPointer.expect(self.toPointer(), err).toRequest();
    }

    function toError(RequestResult self) internal pure returns (Error) {
        return LibResultPointer.toError(self.toPointer());
    }

    function toValue(RequestResult self) internal pure returns (Request memory val) {
        (, Pointer ptr) = LibResultPointer.decode(self.toPointer());

        return ptr.toRequest();
    }

    function toPointer(RequestResult self) internal pure returns (Pointer) {
        return Pointer.wrap(RequestResult.unwrap(self));
    }
}

library LibResponsePointer {
    function toResponse(Pointer self) internal pure returns (Response memory res) {
        assembly {
            res := self
        }
    }

    function toResponseResult(Pointer self) internal pure returns (ResponseResult result) {
        assembly {
            result := self
        }
    }

    function toPointer(Response memory self) internal pure returns (Pointer ptr) {
        assembly {
            ptr := self
        }
    }
}

library LibResponseResult {
    using LibResponsePointer for Pointer;

    function isOk(ResponseResult self) internal pure returns (bool) {
        return LibResultPointer.isOk(self.toPointer());
    }

    function isError(ResponseResult self) internal pure returns (bool) {
        return LibResultPointer.isError(self.toPointer());
    }

    function unwrap(ResponseResult self) internal pure returns (Response memory val) {
        return LibResultPointer.unwrap(self.toPointer()).toResponse();
    }

    function expect(ResponseResult self, string memory err) internal pure returns (Response memory) {
        return LibResultPointer.expect(self.toPointer(), err).toResponse();
    }

    function toError(ResponseResult self) internal pure returns (Error) {
        return LibResultPointer.toError(self.toPointer());
    }

    function toValue(ResponseResult self) internal pure returns (Response memory val) {
        (, Pointer ptr) = LibResultPointer.decode(self.toPointer());

        return ptr.toResponse();
    }

    function toPointer(ResponseResult self) internal pure returns (Pointer) {
        return Pointer.wrap(ResponseResult.unwrap(self));
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
    using RequestError for *;

    function create(RequestClient memory client, Method method, string memory url)
        internal
        pure
        returns (RequestBuilder memory builder)
    {
        builder.client = client;
        builder.request = Ok(Request({method: method, url: url, headers: new Header[](0), body: new bytes(0)}));
    }

    function send(RequestBuilder memory self) internal returns (ResponseResult) {
        RequestResult reqResult = self.build();

        if (reqResult.isError()) {
            return reqResult.toError().toResponseResult();
        }

        Request memory req = reqResult.toValue();

        (string(req.toCommand().toString()));

        CommandResult result = req.toCommand().run();

        if (result.isError()) {
            return result.toError().toResponseResult();
        }

        CommandOutput memory cmdOutput = result.toValue();

        (uint256 status, bytes memory _body) = abi.decode(cmdOutput.stdout, (uint256, bytes));

        return Ok(Response({url: req.url, status: status, body: _body}));
    }

    function build(RequestBuilder memory self) internal pure returns (RequestResult) {
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

    function json(RequestBuilder memory self, string memory serialized) internal returns (RequestBuilder memory) {
        if (self.request.isError()) {
            return self;
        }

        JsonResult res = jsonModule.create(serialized);
        if (res.isError()) {
            self.request = res.toError().toRequestResult();
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
    function json(Response memory self) internal returns (JsonResult) {
        // create() will validate the json
        return jsonModule.create(string(self.body));
    }

    function text(Response memory self) internal pure returns (StringResult) {
        // TODO: maybe do some encoding validation? or check not empty?
        return Ok(string(self.body));
    }

    // function asBytes(Response memory self) internal pure returns (BytesResult memory) {
    //     return BytesResult({value: self.body, ok: true, error: ""});
    // }
}

function Ok(Request memory value) pure returns (RequestResult) {
    bytes32 _value;
    assembly {
        _value := value
    }
    return ResultType.Ok.encode(_value).toRequestResult();
}

function Ok(Response memory value) pure returns (ResponseResult) {
    bytes32 _value;
    assembly {
        _value := value
    }
    return ResultType.Ok.encode(_value).toResponseResult();
}

// Local
using LibRequestPointer for Pointer;
using LibRequestPointer for Request;

// Local
using LibResponsePointer for Pointer;
using LibResponsePointer for Response;

// Global
using LibRequestClient for RequestClient global;
using LibRequest for Request global;
using LibResponse for Response global;
using LibRequestBuilder for RequestBuilder global;
using LibRequestResult for RequestResult global;
using LibResponseResult for ResponseResult global;
