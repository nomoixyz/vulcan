pragma solidity >=0.8.13 <0.9.0;

import {
    Test, expect, println, json, JsonObject, vulcan, request, RequestClient, RequestResult
} from "../../src/test.sol";

contract RequestTest is Test {
    using vulcan for *;

    function testRequestGet() external {
        RequestResult memory result = request.get("https://httpbin.org/get");
        println(string(result.result));
        expect(result.error).toEqual("");
        expect(result.statusCode).toEqual(200);
    }
}
