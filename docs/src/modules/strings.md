# Strings

Convert basic types from / to strings.

```Solidity
import { Test, strings } from "vulcan/test.sol";

contract TestMyContract is Test {
    using strings for *;

    function testMyContract() external {
        uint256 val = 1;

        expect(val.toString()).toEqual("1");

        expect("1".parseUint()).toEqual(1);
    }
}
```