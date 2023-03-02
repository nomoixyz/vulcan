# Strings

Convert basic types from / to strings.

```solidity
import { Test, strings } from "vulcan/test.sol";

contract TestMyContract is Test {
    using strings for *;

    function testMyContract() external {
        // Obtain the string representation of uints
        expect(uint256(1).toString()).toEqual("1");

        // Obtain the string representation of booleans
        expect(true.toString()).toEqual("true");
        expect(false.toString()).toEqual("false");

        // Obtain the string representation of an address
        expect(address(1).toString()).toEqual("0x0000000000000000000000000000000000000001")

        // Parse a number string to a `uint256`
        expect("1".parseUint()).toEqual(1);

        // Parse a boolean string to a `bool`
        expect("true".parseBool()).toBeTrue();

        // Parse an address string to an `address`
        expect("0x13DFD56424777BAC80070a98Cf83DD82246c2bC0".parseAddress()).toEqual(0x13DFD56424777BAC80070a98Cf83DD82246c2bC0);
    }
}
```
[**Strings API reference**](../reference/modules/strings.md)
