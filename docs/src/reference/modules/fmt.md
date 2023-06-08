# Format

#### **`format(string template, bytes args) → (string)`**

## Template Reference

The template is a string that can contain placeholders for the arguments. The placeholders are defined by curly braces `{}` and can be of the following types:

- **Address**: `{address}` or `{a}`
- **Bytes32**: `{bytes32}` or `{b32}`
- **String**: `{string}` or `{s}`
- **Bytes**: `{bytes}` or `{b}`
- **Uint**: `{uint}` or `{u}`
- **Int**: `{int}` or `{i}`
- **Boolean**: `{bool}`

### Modifiers

Some placeholder types can be followed by a colon `:` and a format specifier. The format specifier is a single character that defines how the argument should be formatted, and can also contain additional arguments. The following format specifiers are supported:

#### Decimals (`dX`)

Supported types: `uint`, `int`

Formats the provided value to a string representation that uses the specified amount of decimals. One of the main use cases is to format token amounts.
 
Examples:
- `{uint:d18}` formats the value `1e18` to `"1.0"`
- `{uint:d2}` formats the value `10` to `"0.1"`
