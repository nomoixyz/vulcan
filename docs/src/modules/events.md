# Events

Provides utitilies to get logs and transform values into their topic representation.

```solidity
import { Test, events, Log } from "vulcan/test.sol";

contract TestMyContract is Test {
    using events for *;

    function testMyContract() external {
        // Gets the topic representation of an `uint256` value
        bytes32 topic1 = uint256(1).topic();
        // Gets the topic representation of a `bool` value
        bytes32 topic2 = false.topic();
        // Gets the toipic representation of an `address` value
        bytes32 topic3 = address(1).topic();

        // Start recording logs. Same as `forge-std/Vm.sol:recordLogs`
        events.recordLogs();

        // Gets the recorded logs. Same as `forge-std/Vm.sol:getRecordedLogs`
        Log[] memory logs = events.getRecordedLogs();
    }
}
```
[**Events API reference**](../reference/modules/events.md)
