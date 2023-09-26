# Results

Results are an idea taken from
[`rust`](https://doc.rust-lang.org/rust-by-example/error/result.html). The main idea is to have
types that can be used to return values and provide ways to handle errors if they ocurr.

```solidity
import { Test, StringResult, Ok, console } from "vulcan/test.sol";

contract TestMyContract is Test {
    function testMyContract() external {
        // foo.bar() returns a StringResult
        StringResult result = foo.bar();

        // Check if the function failed
        if (result.isError()) {
            // Decode the error and get the message that can explain why the function failed
            (, string memory message, ) = result.toError().decode();

            expect(message).toEqual("foo.bar() failed");
        } else {
            // Otherwise get the value encapsulated in the `StringResult`
            string memory value = result.toValue();

            expect(value).toEqual("baz");
        }

        // Another way to get the value of a `Result` is to use `unwrap`.
        // `unwrap` will return the value if the function call didn't fail or revert if its an error
        string memory a = result.unwrap();

        // There is also a `expect(string)` function that is similar to `unwrap` but a custom error message can
        // be set
        string memory b = result.expect("Could not extract foo.bar() result value");
    }
}
```
