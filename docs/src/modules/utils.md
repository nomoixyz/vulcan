# Utils

This module provides a set of utility functions that make use of other modules in Vulcan.

Some of the utility functions:
- `format`: Formats a string in a similar way to rust [`format!`](https://doc.rust-lang.org/std/macro.format.html) macro. This function uses the [`fmt` module](./fmt.md) underneath meaning that all templating options from the [`fmt` module](./fmt.md) are available.
- `println`: Logs a formatted string in a similar way to rust [`println!`](https://doc.rust-lang.org/std/macro.println.html) macro. This function uses
  the `format` function underneath

{{#include ../examples/utils/example.md}}

[**Utils API reference**](../references/Utils.md)
