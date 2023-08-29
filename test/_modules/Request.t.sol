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
    Response,
    commands
} from "../../src/test.sol";

contract RequestTest is Test {
    using vulcan for *;

    function testRequestGet() external {
        RequestClient memory client = request.create().get("https://httpbin.org/get");

        Response memory res = client.send();
        // println(string(result.body));
        expect(res.status).toEqual(200);
    }

    function testRequestJsonDecode() external {
        // bytes memory data = request.get("https://httpbin.org/ip").unwrap();

        // println(json.getString(string(data), ".origin"));
    }
}
