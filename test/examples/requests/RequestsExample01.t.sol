// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, expect, request, Response} from "vulcan/test.sol";

/// @title Sending requests
/// @dev How to send requests to an http server
contract RequestExample is Test {
    function test() external {
        Response memory getResponse = request.create().get("https://httpbin.org/get").send().unwrap();
        Response memory postResponse = request.create().post("https://httpbin.org/post").send().unwrap();
        Response memory patchResponse = request.create().patch("https://httpbin.org/patch").send().unwrap();
        Response memory putResponse = request.create().put("https://httpbin.org/put").send().unwrap();
        Response memory deleteResponse = request.create().del("https://httpbin.org/delete").send().unwrap();

        expect(getResponse.status).toEqual(200);
        expect(postResponse.status).toEqual(200);
        expect(patchResponse.status).toEqual(200);
        expect(putResponse.status).toEqual(200);
        expect(deleteResponse.status).toEqual(200);
    }
}
