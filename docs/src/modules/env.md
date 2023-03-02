# Env

Set and read environmental variables.

```solidity
import { Test, env } from "vulcan/test.sol";

contract TestMyContract is Test {
    function testMyContract() external {
        // Sets the value of the environment variable `MY_VAR` to `Hello World`
        env.set("MY_VAR", string("Hello World"));

        // Reads the content of the `MY_VAR` environment variable
        string memory MY_VAR = env.getString("MY_VAR");

        // Reads an environment variable and sets a default value
        bytes32 foo = env.getBytes32("FOO", bytes32(123));

        // Reads an environment variable string as an array of booleans where
        // the string uses `,` to separate each value
        bool[] bar = env.getBoolArray("BAR", ",");

        uint256[] memory defaultValue = new uint256[](100);
        // Reads an environment variable string as an array of uint256 where
        // the string uses `;` to separate each value and provides a default.
        uint256[] baz = env.getUintArray("BAZ", ";", defaultValue);
    }
}
```
