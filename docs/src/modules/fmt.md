# Format

The format function defined under the `fmt` module enables you to format strings dynamically by using a template string and the ABI encoded arguments.

The accepted placeholders are:
- `{address} or {a}` for the `address` type.
- `{bytes32} or {b32}` for the `bytes32` type.
- `{string} or {s}` for the `string` type.
- `{bytes} or {b}` for the `bytes` type.
- `{uint} or {u}` for the `uint256` type.
- `{int} or {i}` for the `int256` type.
- `{bool}` for the `bool` type.
 
For the `uint256` type there is a special placeholder to deal with decimals `{u:dx}` where `x` is
the number of decimals, for example `{u:d18}` to format numbers with `18` decimals.

{{#include ../examples/format/example.md}}

[**Format API reference**](../references/Fmt.md)
