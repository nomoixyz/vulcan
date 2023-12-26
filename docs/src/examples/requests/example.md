## Examples
### Sending requests

How to send requests to an http server

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, expect, request, Response} from "vulcan/test.sol";

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

```

### Request authentication

How to use different methods of authentication

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, expect, request, Response, RequestClient} from "vulcan/test.sol";

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

```

### Working with headers

Using the request module to work with request headers

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, expect, request, Headers, Response, Request, RequestClient} from "vulcan/test.sol";

contract RequestExample is Test {
    function test() external {
        // Setting a default header as key value
        RequestClient memory client = request.create().defaultHeader("X-Foo", "true");

        expect(client.headers.get("X-Foo")).toEqual("true");

        // The default header gets passed to the request
        Request memory req = client.post("https://some-http-server.com").request.unwrap();

        expect(req.headers.get("X-Foo")).toEqual("true");

        // Setting multiple headers with a Header variable
        Headers headers = request.createHeaders().insert("X-Bar", "true").insert("X-Baz", "true");
        client = request.create().defaultHeaders(headers);

        expect(client.headers.get("X-Bar")).toEqual("true");
        expect(client.headers.get("X-Baz")).toEqual("true");
    }
}

```

