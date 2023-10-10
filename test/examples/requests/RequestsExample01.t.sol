// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, expect, request, Response} from "vulcan/test.sol";

/// @title Sending requests
/// @dev How to send requests to an http server
contract RequestExample is Test {
    function test() external {
        // Alias to `request.create().get(url).send()`
        Response memory getResponse = request.get("https://httpbin.org/get").unwrap();

        // Alias to `request.create().post(url).send()`
        Response memory postResponse = request.post("https://httpbin.org/post").unwrap();

        // Alias to `request.create().patch(url).send()`
        Response memory patchResponse = request.patch("https://httpbin.org/patch").unwrap();

        // Alias to `request.create().put(url).send()`
        Response memory putResponse = request.put("https://httpbin.org/put").unwrap();

        // Alias to `request.create().del(url).send()`
        Response memory deleteResponse = request.del("https://httpbin.org/delete").unwrap();

        expect(getResponse.status).toEqual(200);
        expect(postResponse.status).toEqual(200);
        expect(patchResponse.status).toEqual(200);
        expect(putResponse.status).toEqual(200);
        expect(deleteResponse.status).toEqual(200);
    }
}
