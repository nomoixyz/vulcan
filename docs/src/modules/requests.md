# Requests

Provides utilities to interact with the filesystem. In order to use this module the
`fs_permissions` setting must be set correctly in `foundry.toml`.

```solidity
import { Test, request, RequestClient, ResponseResult, Response, JsonObject } from "vulcan/test.sol";

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

        // Check status code
        if (response.status == 401) {
            revert("Request to httpbin.org is Unauthorized");
        }

        // Get the response body as a JsonObject
        JsonObject memory jsonBody = response.json().unwrap();

        // Get the value of `foo` from the json body response from httpbin
        string memory foo = jsonBody.getString(".args.foo");

        return foo;
    }
}
```