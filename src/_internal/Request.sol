// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Command, CommandResult, CommandOutput, commands} from "./Commands.sol";
import {JsonObject, json as jsonModule, JsonResult, Ok} from "./Json.sol";
import {semver, Semver} from "./Semver.sol";

import {Pointer} from "./Pointer.sol";
import {BytesResult, StringResult, Ok, ResultType, LibResultPointer} from "./Result.sol";
import {LibError, Error} from "./Error.sol";

enum Method {
    GET,
    POST,
    PUT,
    PATCH,
    DELETE
}

type Headers is bytes32;

struct RequestClient {
    Headers headers;
    Semver _curlVersion;
}

struct RequestBuilder {
    RequestClient client;
    RequestResult request;
}

struct Request {
    Method method;
    string url;
    Headers headers;
    bytes body;
}

type RequestResult is bytes32;

struct Response {
    string url;
    uint256 status;
    Headers headers;
    bytes body;
}

type ResponseResult is bytes32;

library request {
    using request for *;
    using LibHeaders for *;

    // Return an empty client
    function create() internal returns (RequestClient memory client) {
        bytes memory rawCurlVersion = commands.run(
            ["bash", "-c", "curl --version | awk '/curl [0-9]+\\.[0-9]+\\.[0-9]+/ {print $2}'"]
        ).expect("Failed to get curl version").stdout;

        client._curlVersion = semver.parse(string(rawCurlVersion));

        client.headers = createHeaders();

        return client;
    }

    function createHeaders() internal returns (Headers) {
        return LibHeaders.create();
    }

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
    using RequestError for *;
    using LibHeaders for *;

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

    function defaultHeader(RequestClient memory self, string memory key, string memory value)
        internal
        returns (RequestClient memory)
    {
        self.headers.insert(key, value);
        return self;
    }

    function defaultHeader(RequestClient memory self, string memory key, string[] memory values)
        internal
        returns (RequestClient memory)
    {
        self.headers.insert(key, values);
        return self;
    }

    function defaultHeaders(RequestClient memory self, Headers headers) internal pure returns (RequestClient memory) {
        self.headers = headers;

        return self;
    }

    function execute(RequestClient memory self, Request memory req) internal returns (ResponseResult) {
        CommandResult result = toCommand(self, req).run();

        if (result.isError()) {
            return result.toError().toResponseResult();
        }

        CommandOutput memory cmdOutput = result.toValue();

        (uint256 status, bytes memory _body, bytes memory _headers) =
            abi.decode(cmdOutput.stdout, (uint256, bytes, bytes));

        return Ok(
            Response({
                url: req.url,
                status: status,
                body: _body,
                headers: LibHeaders.encode(jsonModule.create(string(_headers)).unwrap(), true)
            })
        );
    }

    function toCommand(RequestClient memory self, Request memory req) internal pure returns (Command memory) {
        string memory curlWriteOutTemplate = "\"\\n%{header_json}\\n\\n%{http_code}\" ";

        if (self._curlVersion.lessThan(semver.create(7, 83))) {
            curlWriteOutTemplate = "\"\\n{}\\n\\n%{http_code}\" ";
        }

        string memory script = string.concat(
            "response=$(curl -s -w ", curlWriteOutTemplate, req.url, " -X ", LibRequest.toString(req.method)
        );

        string[] memory headersKeys = req.headers.getKeys();

        for (uint256 i; i < headersKeys.length; i++) {
            string memory key = headersKeys[i];
            string[] memory headersValues = req.headers.getAll(key);

            for (uint256 j; j < headersValues.length; j++) {
                script = string.concat(script, " -H ", '"', key, ": ", headersValues[j], '"');
            }
        }

        if (req.body.length > 0) {
            script = string.concat(script, " -d ", "'", string(req.body), "'");
        }

        script = string.concat(
            script,
            ");",
            'reverse_response=$(echo "$response" | awk "{a[i++]=\\$0} END {for (j=i-1; j>=0;) print a[j--]}");',
            'headers=$(echo "$reverse_response" | awk -v RS="\\n\\n" "NR==2" | awk "{a[i++]=\\$0} END {for (j=i-1; j>=0;) print a[j--]}");',
            'code=$(echo "$reverse_response" | awk -v RS="\\n\\n" "NR==1" | awk "{a[i++]=\\$0} END {for (j=i-1; j>=0;) print a[j--]}");',
            'body=$(echo "$reverse_response" | awk -v RS="\\n\\n" "NR>2" | awk "{a[i++]=\\$0} END {for (j=i-1; j>=0;) print a[j--]}");',
            'cast abi-encode "response(uint256,string,string)" "$code" \\\'"$body"\\\' \\\'"$headers"\\\';'
        );

        // The script to obtain the response body, status code and headers looks like this:
        // bash -c response=$(curl -s -w "\n%{header_json}\n\n%{http_code}" https://example.com - GET);
        // reverse_response=$(echo "$response" | awk "{a[i++]=\$0} END {for (j=i-1; j>=0;) print a[j--]}");
        // headers=$(echo "$reverse_response" | awk -v RS="\n\n" "NR==2" | awk "{a[i++]=\$0} END {for (j=i-1; j>=0;) print a[j--]}");
        // code=$(echo "$reverse_response" | awk -v RS="\n\n" "NR==1" | awk "{a[i++]=\$0} END {for (j=i-1; j>=0;) print a[j--]}");
        // body=$(echo "$reverse_response" | awk -v RS="\n\n" "NR>2" | awk "{a[i++]=\$0} END {for (j=i-1; j>=0;) print a[j--]}");
        // cast abi-encode "response(uint256,string,string)" "$code" "$body" "$headers"

        return commands.create("bash").arg("-c").arg(script);
    }
}

library LibRequestBuilder {
    using request for *;
    using RequestError for *;
    using LibHeaders for *;

    function create(RequestClient memory client, Method method, string memory url)
        internal
        pure
        returns (RequestBuilder memory builder)
    {
        builder.client = client;
        builder.request = Ok(Request({method: method, url: url, headers: client.headers, body: new bytes(0)}));
    }

    function send(RequestBuilder memory self) internal returns (ResponseResult) {
        RequestResult reqResult = self.build();

        if (reqResult.isError()) {
            return reqResult.toError().toResponseResult();
        }

        return self.client.execute(reqResult.toValue());
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
        returns (RequestBuilder memory)
    {
        bytes memory passwdValue = commands.run(
            ["bash", "-c", string.concat("echo -n \"", username, ":", password, "\" | base64")]
        ).expect("Failed to build basic auth header").stdout;
        return self.header("Authorization", string.concat("Basic ", string(passwdValue)));
    }

    function bearerAuth(RequestBuilder memory self, string memory token) internal returns (RequestBuilder memory) {
        return self.header("Authorization", string.concat("Bearer ", token));
    }

    function header(RequestBuilder memory self, string memory key, string[] memory values)
        internal
        returns (RequestBuilder memory)
    {
        if (self.request.isError()) {
            return self;
        }

        Request memory req = self.request.toValue();
        req.headers.insert(key, values);
        self.request = Ok(req);
        return self;
    }

    function header(RequestBuilder memory self, string memory key, string memory value)
        internal
        returns (RequestBuilder memory)
    {
        string[] memory values = new string[](1);
        values[0] = value;

        return header(self, key, values);
    }

    function headers(RequestBuilder memory self, Headers newHeaders) internal pure returns (RequestBuilder memory) {
        if (self.request.isError()) {
            return self;
        }

        Request memory req = self.request.toValue();
        req.headers = newHeaders;
        self.request = Ok(req);
        return self;
    }

    function json(RequestBuilder memory self, JsonObject memory obj) internal returns (RequestBuilder memory) {
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

library LibHeaders {
    function create() internal returns (Headers header) {
        return encode(jsonModule.create("{}").unwrap(), false);
    }

    function toImmutable(Headers self) internal pure returns (Headers header) {
        (JsonObject memory values,) = decode(self);

        return encode(values, true);
    }

    function isImmutable(Headers self) internal pure returns (bool headerIsImmutable) {
        (, headerIsImmutable) = decode(self);
    }

    function encode(JsonObject memory values, bool headerIsImmutable) internal pure returns (Headers header) {
        bytes32 valuesMemoryAddr;

        assembly {
            valuesMemoryAddr := values
        }

        bytes memory data = abi.encode(valuesMemoryAddr, headerIsImmutable);

        assembly {
            header := data
        }
    }

    function decode(Headers self) internal pure returns (JsonObject memory values, bool) {
        bytes memory data;

        assembly {
            data := self
        }

        (bytes32 valuesMemoryAddr, bool headerIsImmutable) = abi.decode(data, (bytes32, bool));

        assembly {
            values := valuesMemoryAddr
        }

        return (values, headerIsImmutable);
    }

    function insert(Headers self, string memory key, string memory value) internal returns (Headers) {
        string[] memory values = new string[](1);
        values[0] = value;

        return insert(self, key, values);
    }

    function insert(Headers self, string memory key, string[] memory values) internal returns (Headers) {
        (JsonObject memory newValues, bool headerIsImmutable) = decode(self);

        require(!headerIsImmutable, "Cannot insert into immutable header");

        newValues.set(key, values);

        return self;
    }

    function append(Headers self, string memory key, string memory value) internal returns (Headers) {
        string[] memory values = new string[](1);
        values[0] = value;

        return append(self, key, values);
    }

    function append(Headers self, string memory key, string[] memory values) internal returns (Headers) {
        (JsonObject memory jsonObj, bool headerIsImmutable) = decode(self);

        require(!headerIsImmutable, "Cannot append into immutable header");

        if (!jsonObj.containsKey(string.concat(".", key))) {
            jsonObj.set(key, values);

            return self;
        }

        string[] memory currentValues = jsonObj.getStringArray(string.concat(".", key));

        string[] memory newValues = new string[](currentValues.length + values.length);

        for (uint256 i; i < currentValues.length; i++) {
            newValues[i] = currentValues[i];
        }

        for (uint256 i; i < values.length; i++) {
            newValues[i + currentValues.length] = values[i];
        }

        jsonObj.set(key, newValues);

        return self;
    }

    function get(Headers self, string memory key, uint256 index) internal pure returns (string memory) {
        return getAll(self, key)[index];
    }

    function get(Headers self, string memory key) internal pure returns (string memory) {
        return get(self, key, 0);
    }

    function getAll(Headers self, string memory key) internal pure returns (string[] memory) {
        (JsonObject memory values,) = decode(self);

        return values.getStringArray(string.concat(".", key));
    }

    function getKeys(Headers self) internal pure returns (string[] memory) {
        (JsonObject memory values,) = decode(self);
        return values.getKeys();
    }
}

function Ok(Request memory value) pure returns (RequestResult) {
    return ResultType.Ok.encode(value.toPointer()).toRequestResult();
}

function Ok(Response memory value) pure returns (ResponseResult) {
    return ResultType.Ok.encode(value.toPointer()).toResponseResult();
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
using LibHeaders for Headers global;
