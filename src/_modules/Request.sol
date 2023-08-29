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
    RequestClient _client;
}

library RequestError {
    bytes32 constant NOT_FOUND = keccak256("NOT_FOUND");

    function notFound(Response memory res) public pure returns (Error memory) {
        return Error({message: string.concat("Not found: ", res.url), id: NOT_FOUND});
    }
}

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
            url: "",
            _cmd: commands.create("bash").arg("-c").arg(
                'response=$(curl -s -w "\\n%{http_code}" "$@");body=$(sed "$ d" <<< "$response"  | tr -d "\\n");code=$(tail -n 1 <<< "$response");cast abi-encode "response(uint256,string)" "$code" "$body";'
                ).arg("vulcan") // Add vulcan as parameter $0, so errors are reported as coming from vulcan
        });
    }

    function send(RequestClient memory self) internal returns (Response memory) {
        CommandResult memory result = self._cmd.run();

        (uint256 status, bytes memory body) = abi.decode(result.stdout, (uint256, bytes));

        return Response({url: self.url, status: status, body: body, _client: self});
    }

    function get(string memory url) internal returns (Response memory) {
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

    function data(RequestClient memory self, string memory _data) internal pure returns (RequestClient memory) {
        return RequestClient(self.url, self._cmd.args(["-d", _data]));
    }

    function header(RequestClient memory self, string memory _header) internal pure returns (RequestClient memory) {
        return RequestClient(self.url, self._cmd.args(["-H", _header]));
    }

    function json(RequestClient memory self, JsonObject memory obj) internal pure returns (RequestClient memory) {
        return self.json(obj.serialized);
    }

    function json(RequestClient memory self, string memory serialized) internal pure returns (RequestClient memory) {
        return self.header("Content-Type: application/json").data(serialized);
    }
}

library response {
    function json(Response memory self) internal pure returns (JsonResult memory) {
        // JsonObject memory obj = jsonModule.create().set(".", string(self.body));
        JsonObject memory obj;
        return JsonResult({value: obj, _error: Error({message: "", id: bytes32(0)})});
    }

    function text(Response memory self) internal pure returns (StringResult memory) {
        return StringResult({value: string(self.body), _error: Error({message: "", id: bytes32(0)})});
    }

    // function asBytes(Response memory self) internal pure returns (BytesResult memory) {
    //     return BytesResult({value: self.body, ok: true, error: ""});
    // }
}

using request for RequestClient global;
using request for Response global;
