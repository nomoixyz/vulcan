// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, expect, request, Headers, Response, Request, RequestClient} from "vulcan/test.sol";

/// @title Working with headers
/// @dev Using the request module to work with request headers
contract RequestExample is Test {
    function test() external {
        // Setting a default header as key value
        RequestClient memory client = request.create().defaultHeader("X-Foo", "true");

        expect(client.headers.get("X-Foo")).toEqual("true");

        // The default header gets passed to the request
        Request memory req = client.post("https://some-http-server.com").request.unwrap();

        expect(req.headers.get("X-Foo")).toEqual("true");

        // Setting multiple headers with a Header variable
        Headers headers = request.createHeaders().insert("X-Bar", "true").insert("X-Baz", "true");
        client = request.create().defaultHeaders(headers);

        expect(client.headers.get("X-Bar")).toEqual("true");
        expect(client.headers.get("X-Baz")).toEqual("true");
    }
}
