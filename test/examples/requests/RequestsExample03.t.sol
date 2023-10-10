// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, expect, request, Response, RequestClient} from "vulcan/test.sol";

/// @title Request authentication
/// @dev How to use different methods of authentication
contract RequestExample is Test {
    function test() external {
        RequestClient memory client = request.create();

        Response memory basicAuthRes =
            client.get("https://httpbin.org/basic-auth/user/pass").basicAuth("user", "pass").send().unwrap();

        expect(basicAuthRes.status).toEqual(200);

        Response memory bearerAuthRes = client.get("https://httpbin.org/bearer").bearerAuth("token").send().unwrap();

        expect(bearerAuthRes.status).toEqual(200);
    }
}
