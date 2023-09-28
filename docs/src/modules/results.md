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
import { Test, StringResult, Ok, console, CommandResult, Error } from "vulcan/test.sol";

contract TestMyContract is Test {
    function testMyContract() external {
        CommandResult result = commands.run(["echo", "Hello, world!"]);

        // We can handle different types of errors
        if (result.isError()) {
        Error err = result.toError();

        if (err.matches(CommandError.NotExecuted)) {
            revert("Something weird happened!");
        } else {
            revert("Unknown error");
        }

        // Or we could immediately get the actual output, reverting if the command failed to run
        bytes memory out = result.expect("wtf echo failed!").stdout;

        // Another way is to check if the result is ok
        if (result.isOk()) {
            // We know the result is ok so we can access the underlying value
            out = result.toValue().stdout;
        }
    }
}
```
