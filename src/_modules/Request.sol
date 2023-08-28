// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Command, commands} from "./Commands.sol";
import {JsonObject, json as jsonModule} from "./Json.sol";

struct Client {
    Command _cmd;
}

struct RequestResult {
    bool success;
    bytes result;
    string error;
}

library request {
    using request for *;

    function create() internal pure returns (Client memory) {
        // Hide progress but return result or error
        return Client({_cmd: commands.create("curl").args(["-S", "-s", "--fail-with-body"])});
    }

    function send(Client memory self) internal returns (bytes memory) {
        return self._cmd.run();
    }

    function get(Client memory self, string memory url) internal pure returns (Client memory) {
        return Client(self._cmd.arg(url));
    }

    function get(string memory url) internal returns (bytes memory) {
        return create().get(url).send();
    }

    function del(Client memory self, string memory url) internal pure returns (Client memory) {
        return Client(self._cmd.args(["-X", "DELETE", url]));
    }

    function patch(Client memory self, string memory url) internal pure returns (Client memory) {
        return Client(self._cmd.args(["-X", "PATCH", url]));
    }

    function post(Client memory self, string memory url) internal pure returns (Client memory) {
        return Client(self._cmd.args(["-X", "POST", url]));
    }

    function put(Client memory self, string memory url) internal pure returns (Client memory) {
        return Client(self._cmd.args(["-X", "PUT", url]));
    }

    function data(Client memory self, string memory _data) internal pure returns (Client memory) {
        return Client(self._cmd.args(["-d", _data]));
    }

    function header(Client memory self, string memory _header) internal pure returns (Client memory) {
        return Client(self._cmd.args(["-H", _header]));
    }

    function json(Client memory self, JsonObject memory obj) internal pure returns (Client memory) {
        return self.json(obj.serialized);
    }

    function json(Client memory self, string memory serialized) internal pure returns (Client memory) {
        return self.header("Content-Type: application/json").data(serialized);
    }
}

using request for Client global;
