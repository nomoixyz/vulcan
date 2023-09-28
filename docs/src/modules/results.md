# Results

The concept of "Results" is inspired by Rust. It centers around using specific types for returning values while also offering mechanisms to handle any potential errors.

Similar to Rust's Results API, Vulcan implements the following functions for all result types:
- `unwrap()`: if the Result is an Error, reverts with the default error message. If if is `Ok`, it returns the underlying value
- `expect(message)`: same as `unwrap()`, but reverts with the provided error message
- `isError()`: returns `true` if the `Result` is an error, `false` otherwise
- `isOk()`: the oposite of `isError()`
- `toError()`: transforms the Result into an `Error`
- `toValue()`: gets the Result's underlying value (if the Result is Ok)

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
