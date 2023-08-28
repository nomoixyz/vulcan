// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Command, commands} from "./Commands.sol";
import {JsonObject, json as jsonModule} from "./Json.sol";

struct RequestClient {
    Command _cmd;
}

struct RequestResult {
    bool success;
    bytes result;
    string error;
}

library request {
    using request for *;

    function create() internal pure returns (RequestClient memory) {
        // Hide progress but return result or error
        return RequestClient({_cmd: commands.create("curl").args(["-S", "-s", "--fail-with-body"])});
    }

    function send(RequestClient memory self) internal returns (bytes memory) {
        return self._cmd.run();
    }

    function get(RequestClient memory self, string memory url) internal pure returns (RequestClient memory) {
        return RequestClient(self._cmd.arg(url));
    }

    function get(string memory url) internal returns (bytes memory) {
        return create().get(url).send();
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
}

using request for RequestClient global;
