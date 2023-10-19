# Expect

The `Expect` module introduces the `expect` function, designed to validate if specified conditions are satisfied.
Depending on the type of the input parameter, the `expect` function offers a range of matchers tailored to the 
context. For instance, with a string like `"Hello World"`, you can use `.toContain("Hello")`, or for numbers,
`expect(1).toBeGreaterThan(0)` can be applied. This adaptability ensures precise and concise condition 
checking across various data types.

{{#include ../examples/expect/example.md}}

[**Expect API reference**](../references/Expect.md)
