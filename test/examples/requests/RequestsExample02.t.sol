// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, expect, request, Response, RequestClient, JsonObject} from "vulcan/test.sol";

/// @title Sending a JSON payload
/// @dev This example shows how to send a request with a JSON body
contract RequestExample02 is Test {
    function test() external {
        RequestClient memory client = request.create();

        Response memory jsonRes = client.post("https://httpbin.org/post").json("{ \"foo\": \"bar\" }").send().unwrap();

        expect(jsonRes.status).toEqual(200);

        JsonObject memory responseBody = jsonRes.json().unwrap();

        expect(responseBody.getString(".json.foo")).toEqual("bar");
    }
}
