// SPDX-License-Identifier: MIT
pragma solidity >=0.8.13 <0.9.0;

import {
    Test,
    expect,
    println,
    json,
    JsonObject,
    vulcan,
    request,
    RequestClient,
    RequestResult,
    commands
} from "../../src/test.sol";

contract RequestTest is Test {
    using vulcan for *;

    function testRequestGet() external {
        RequestClient memory client = request.create().get("https://httpbin.org/get");

        RequestResult memory result = client.send();
        println(string(result.body));
        expect(result.statusCode).toEqual(200);
    }
}
