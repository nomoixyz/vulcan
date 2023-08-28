// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {println} from "../_utils/println.sol";
import {Command, CommandResult, commands} from "./Commands.sol";
import {JsonObject, json as jsonModule} from "./Json.sol";

struct RequestClient {
    Command _cmd;
}

struct RequestResult {
    uint256 statusCode;
    bytes body;
    RequestClient _client;
}
// bytes error;

library request {
    using request for *;

    function create() internal pure returns (RequestClient memory) {
        return RequestClient({
            /*
             * Adapted from https://github.com/memester-xyz/surl/blob/034c912ae9b5e707a5afd21f145b452ad8e800df/src/Surl.sol#L90
             *
             * response=$(curl -s -w "\\n%{http_code}" "$@");
             * body=$(sed "$ d" <<< "$response"  | tr -d "\\n");
             * code=$(tail -n 1 <<< "$response");
             * cast abi-encode "response(uint256,string)" "$code" "$body";
             */
            _cmd: commands.create("bash").arg("-c").arg(
                'response=$(curl -s -w "\\n%{http_code}" "$@");body=$(sed "$ d" <<< "$response"  | tr -d "\\n");code=$(tail -n 1 <<< "$response");cast abi-encode "response(uint256,string)" "$code" "$body";'
                ).arg("vulcan") // Add vulcan as parameter $0, so errors are reported as coming from vulcan
        });
    }

    function send(RequestClient memory self) internal returns (RequestResult memory) {
        CommandResult memory result = self._cmd.run();

        (uint256 statusCode, bytes memory body) = abi.decode(result.stdout, (uint256, bytes));

        return RequestResult({statusCode: statusCode, body: body, _client: self});
    }

    function get(string memory url) internal returns (RequestResult memory) {
        return create().get(url).send();
    }

    function get(RequestClient memory self, string memory url) internal pure returns (RequestClient memory) {
        return RequestClient(self._cmd.arg(url));
    }

    function del(RequestClient memory self, string memory url) internal pure returns (RequestClient memory) {
        return RequestClient(self._cmd.args(["-X", "DELETE", url]));
    }

    function patch(RequestClient memory self, string memory url) internal pure returns (RequestClient memory) {
        return RequestClient(self._cmd.args(["-X", "PATCH", url]));
    }

    function post(RequestClient memory self, string memory url) internal pure returns (RequestClient memory) {
        return RequestClient(self._cmd.args(["-X", "POST", url]));
    }

    function put(RequestClient memory self, string memory url) internal pure returns (RequestClient memory) {
        return RequestClient(self._cmd.args(["-X", "PUT", url]));
    }

    function data(RequestClient memory self, string memory _data) internal pure returns (RequestClient memory) {
        return RequestClient(self._cmd.args(["-d", _data]));
    }

    function header(RequestClient memory self, string memory _header) internal pure returns (RequestClient memory) {
        return RequestClient(self._cmd.args(["-H", _header]));
    }

    function json(RequestClient memory self, JsonObject memory obj) internal pure returns (RequestClient memory) {
        return self.json(obj.serialized);
    }

    function json(RequestClient memory self, string memory serialized) internal pure returns (RequestClient memory) {
        return self.header("Content-Type: application/json").data(serialized);
    }

    /// @dev Checks if a `RequestResult` returned an `ok` status code.
    function isOk(RequestResult memory self) internal pure returns (bool) {
        // TODO: what about 3xx ?
        return self.statusCode >= 200 && self.statusCode < 300;
    }

    /// @dev Checks if a `CommandResult` struct is an error.
    function isError(RequestResult memory self) internal pure returns (bool) {
        return !self.isOk();
    }

    /// @dev Returns the output of a `CommandResult` or reverts if the result was an error.
    function unwrap(RequestResult memory self) internal pure returns (bytes memory) {
        string memory error;

        if (self.isError()) {
            // error = string.concat("Request failed ", self._client.toString());

            if (self.body.length > 0) {
                error = string.concat(error, ": ", string(self.body));
            }
        }

        return expect(self, error);
    }

    /// @dev Returns the output of a `CommandResult` or reverts if the result was an error.
    /// @param customError The error message that will be used when reverting.
    function expect(RequestResult memory self, string memory customError) internal pure returns (bytes memory) {
        if (self.isError()) {
            revert(customError);
        }

        return self.body;
    }
}

using request for RequestClient global;
using request for RequestResult global;
