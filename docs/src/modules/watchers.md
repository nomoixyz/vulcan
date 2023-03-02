# Watchers

Monitor contract calls and emitted events.

> **Important:**
> Watchers work by replacing an address code with a proxy contract that records all calls and events.
```solidity
import { Test, events, watchers, expect, any } from "vulcan/test.sol";

contract TestMyContract is Test {
    using watchers for *;
    using events for *;

    function testMyContract() external {
        MyContract mc = new MyContract();

        // Start watching the `mc` contract.
        // This will replace the `mc` contract code with a `proxy`
        address(mc).watch().captureReverts();

        mc.doSomething();
        mc.doSomethingElse();

        // Two calls were made to `mc`
        expect(address(mc).calls.length).toEqual(2);
        // First call reverted with a message
        expect(address(mc).calls[0]).toHaveRevertedWith("Something went wrong");
        // Second call emitted an event
        expect(address(mc).calls[1]).toHaveEmitted(
            "SomeEvent(address,bytes32,uint256)",
            [address(1).topic(), any()], // Event topics (indexed arguments)
            abi.encode(123) // Event data
        );

        // Stop watching the `mc` contract.
        // The `mc` contract code returns to the original state.
        address(mc).stopWatcher();
    }
}
```

[**Watchers API reference**](../reference/modules/watchers.md)
