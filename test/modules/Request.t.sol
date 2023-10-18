// SPDX-License-Identifier: MIT
pragma solidity >=0.8.13 <0.9.0;

import {Test} from "../../src/test.sol";
import {commands} from "src/test/Commands.sol";
import {expect} from "src/test/Expect.sol";
import {json, JsonObject} from "src/test/Json.sol";
import {
    request,
    RequestResult,
    RequestClient,
    Response,
    ResponseResult,
    RequestBuilder,
    Headers
} from "src/test/Request.sol";
import {vulcan} from "src/test/Vulcan.sol";
import {semver} from "src/_internal/Semver.sol";

contract RequestTest is Test {
    using vulcan for *;

    function testBasicAuth() external {
        RequestClient memory client = request.create();

        Response memory res =
            client.get("https://httpbin.org/basic-auth/user/passwd").basicAuth("user", "passwd").send().unwrap();

        expect(res.status).toEqual(200);

        JsonObject memory obj = res.json().unwrap();

        expect(obj.getString(".authenticated")).toEqual("true");
    }

    function testJsonBody() external {
        RequestClient memory client = request.create();

        Response memory res = client.post("https://httpbin.org/post").json('{ "foo": "bar" }').send().unwrap();

        expect(res.status).toEqual(200);

        JsonObject memory obj = res.json().unwrap();

        expect(obj.getString(".json.foo")).toEqual("bar");
    }

    function testJsonBodyFail() external {
        RequestClient memory client = request.create();

        ResponseResult res = client.post("https://httpbin.org/post").json('{ "foo": "bar" ').send();

        expect(res.isError()).toEqual(true);
    }

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

    function testRequestHeaders() external {
        RequestClient memory client = request.create();

        client.defaultHeader("foo", "bar");
        expect(client.headers.get("foo")).toEqual("bar");

        client.defaultHeader("foo", "baz");
        expect(client.headers.get("foo")).toEqual("baz");
    }

    function testResponseHeaders() external {
        RequestClient memory client = request.create();

        // Skip this test because this version of curl migth not support the `--write-out "%{header_json}"`
        // option
        vulcan.hevm.skip(client._curlVersion.lessThan(semver.create(7, 83)));

        Response memory res = client.post("https://httpbin.org/post").json('{ "foo": "bar" }').send().unwrap();

        expect(res.headers.get("content-type")).toEqual("application/json");
    }

    function testDefaultHeaders() external {
        RequestClient memory client = request.create().defaultHeader("foo", "bar");

        expect(client.headers.get("foo")).toEqual("bar");

        RequestBuilder memory builder = client.post("");

        expect(builder.request.unwrap().headers.get("foo")).toEqual("bar");
    }

    function testHeaders() external {
        Headers headers = request.createHeaders();

        headers.insert("test", "true");

        expect(headers.get("test")).toEqual("true");

        string[] memory headerValues = new string[](2);
        headerValues[0] = "foo";
        headerValues[1] = "bar";

        headers.insert("test", headerValues);

        expect(headers.getAll("test").length).toEqual(2);
        expect(headers.get("test", 0)).toEqual("foo");
        expect(headers.get("test", 1)).toEqual("bar");

        headers.append("test", "baz");

        expect(headers.getAll("test").length).toEqual(3);
        expect(headers.get("test", 0)).toEqual("foo");
        expect(headers.get("test", 1)).toEqual("bar");
        expect(headers.get("test", 2)).toEqual("baz");
    }
}
