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

    function testRequestFail() external {
        Response memory res = request.get("https://httpbin.org/404").unwrap();
        expect(res.status).toEqual(404);
    }

    function testRequestGet() external {
        RequestClient memory client = request.create();

        Response memory res = client.get("https://httpbin.org/get").send().unwrap();
        expect(res.status).toEqual(200);
    }

    function testRequestPost() external {
        RequestClient memory client = request.create();

        Response memory res = client.post("https://httpbin.org/post").json('{ "foo": "bar" }').send().unwrap();
        // { ... "json": { "foo": "bar" } ... }
        expect(res.json().unwrap().getString(".json.foo")).toEqual("bar");
        expect(res.status).toEqual(200);
    }

    function testRequestJsonDecode() external {
        JsonObject memory obj = request.get("https://httpbin.org/ip").unwrap().json().unwrap();

        expect(bytes(obj.getString(".origin")).length).toBeGreaterThan(0);
    }

    struct HttpBinIpResponse {
        string origin;
    }

    function testRequestJsonParse() external {
        JsonObject memory obj = request.get("https://httpbin.org/ip").unwrap().json().unwrap();

        HttpBinIpResponse memory res = abi.decode(obj.parse(), (HttpBinIpResponse));

        expect(bytes(res.origin).length).toBeGreaterThan(0);
    }
}
