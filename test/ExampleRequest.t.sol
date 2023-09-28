import { Test, request, RequestClient, ResponseResult } from "../src/test.sol";

contract HttpRequests is Test {
    function getFoo() external returns (string memory) {
        // Create a request client
        RequestClient memory client = request.create().defaultHeader("Content-Type", "application/json");

        // Send a GET request
        ResponseResult responseResult = client.get("https://httpbin.org/get?foo=bar").send();

        // Check if it's an error
        if (responseResult.isError()) {
            revert("Request to httpbin.org failed");
        }

        // Get the response from the response result
        Response memory response = responseResult.toValue();

        if (response.status == 401) {
            revert("Request to httpbin.org is Unauthorized");
        }

        // Get the response body as a JsonObject
        JsonObject memory jsonBody = response.json().unwrap();

        string memory foo = jsonBody.get(".args.foo");

        return foo;
    }
}
