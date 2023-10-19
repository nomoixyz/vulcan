# Results \& Errors

The concept of "Results" is inspired by Rust. It centers around using specific types for returning values while also offering mechanisms to handle any potential errors.

Similar to Rust's Results API, Vulcan implements the following functions for all result types:
- `unwrap()`: if the Result is an Error, reverts with the default error message. If if is `Ok`, it returns the underlying value
- `expect(message)`: same as `unwrap()`, but reverts with the provided error message
- `isError()`: returns `true` if the `Result` is an error, `false` otherwise
- `isOk()`: the oposite of `isError()`
- `toError()`: transforms the Result into an `Error`
- `toValue()`: gets the Result's underlying value (if the Result is Ok)

{{#include ../examples/results/example.md}}

[**Results API reference**](../references/Result.md)

[**Errors API reference**](../references/Error.md)
