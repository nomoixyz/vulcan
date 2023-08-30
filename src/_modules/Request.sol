// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {println} from "../_utils/println.sol";
import {Command, CommandResult, commands} from "./Commands.sol";
import {JsonObject, json as jsonModule} from "./Json.sol";

import {Error, JsonResult, StringResult, BytesResult} from "../_result/Result.sol";

struct RequestClient {
    string url;
    Command _cmd;
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

library ResponseResultLib {
    /// @dev Checks if a `StringResult` is not an error.
    function isOk(ResponseResult memory self) internal pure returns (bool) {
        return self._error.id == bytes32(0);
    }

    /// @dev Checks if a `StringResult` struct is an error.
    function isError(ResponseResult memory self) internal pure returns (bool) {
        return !self.isOk();
    }

    /// @dev Returns the output of a `StringResult` or reverts if the result was an error.
    function unwrap(ResponseResult memory self) internal pure returns (Response memory) {
        return expect(self, self._error.message);
    }

    /// @dev Returns the output of a `StringResult` or reverts if the result was an error.
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

    function create() internal pure returns (RequestClient memory) {
        return RequestClient({
            url: "",
            // Adapted from https://github.com/memester-xyz/surl/blob/034c912ae9b5e707a5afd21f145b452ad8e800df/src/Surl.sol#L90
            _cmd: commands.create("bash").arg("-c").arg(
                string.concat(
                    'response=$(curl -s -w "\\n%{http_code}" "$@");',
                    'body=$(sed "$ d" <<< "$response"  | tr -d "\\n");',
                    'code=$(tail -n 1 <<< "$response");',
                    'cast abi-encode "response(uint256,string)" "$code" "$body";'
                )
                ).arg("vulcan") // Add vulcan as parameter $0, so errors are reported as coming from vulcan
        });
    }

    function send(RequestClient memory self) internal returns (ResponseResult memory res) {
        CommandResult memory result = self._cmd.run();

        if (result.isError()) {
            return RequestError.commandFailed();
        }

        (uint256 status, bytes memory body) = abi.decode(result.stdout, (uint256, bytes));

        res.value = Response({url: self.url, status: status, body: body});
    }

    function get(string memory url) internal returns (ResponseResult memory) {
        return create().get(url).send();
    }

    function get(RequestClient memory self, string memory url) internal pure returns (RequestClient memory) {
        return RequestClient(url, self._cmd.arg(url));
    }

    function del(RequestClient memory self, string memory url) internal pure returns (RequestClient memory) {
        return RequestClient(url, self._cmd.args(["-X", "DELETE", url]));
    }

    function patch(RequestClient memory self, string memory url) internal pure returns (RequestClient memory) {
        return RequestClient(url, self._cmd.args(["-X", "PATCH", url]));
    }

    function post(RequestClient memory self, string memory url) internal pure returns (RequestClient memory) {
        return RequestClient(url, self._cmd.args(["-X", "POST", url]));
    }

    function put(RequestClient memory self, string memory url) internal pure returns (RequestClient memory) {
        return RequestClient(url, self._cmd.args(["-X", "PUT", url]));
    }

    function body(RequestClient memory self, string memory _body) internal pure returns (RequestClient memory) {
        return RequestClient(self.url, self._cmd.args(["-d", _body]));
    }

    function basicAuth(RequestClient memory self, string memory username, string memory password)
        internal
        pure
        returns (RequestClient memory)
    {
        return RequestClient(self.url, self._cmd.args(["-u", string.concat(username, ":", password)]));
    }

    function bearerAuth(RequestClient memory self, string memory token) internal pure returns (RequestClient memory) {
        return RequestClient(self.url, self._cmd.args(["-H", string.concat("Authorization: Bearer ", token)]));
    }

    function header(RequestClient memory self, string memory _header) internal pure returns (RequestClient memory) {
        return RequestClient(self.url, self._cmd.args(["-H", _header]));
    }

    function json(RequestClient memory self, JsonObject memory obj) internal pure returns (RequestClient memory) {
        return self.json(obj.serialized);
    }

    function json(RequestClient memory self, string memory serialized) internal pure returns (RequestClient memory) {
        return self.header("Content-Type: application/json").body(serialized);
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
using request for RequestClient global;

using ResponseResultLib for ResponseResult global;
