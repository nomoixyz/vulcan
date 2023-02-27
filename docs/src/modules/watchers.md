# Watchers

Monitor contract calls.

Watchers work by replacing an address code with a proxy contract that records all calls and events.

```Solidity
import { Test, watchers, expect, any } from "vulcan/test.sol";

contract TestMyContract is Test {
    using watchers for *;
    function testMyContract() external {
        MyContract mc = new MyContract();

        address(mc).watch().captureReverts();

        mc.doSomething();
        mc.doSomethingElse();

        expect(address(mc).calls.length).toEqual(2);
        expect(address(mc).calls[0]).toHaveRevertedWith("Something went wrong");
        expect(address(mc).calls[1]).toHaveEmitted(
            "SomeEvent(address,bytes32,uint256)",
            [address(1).topic(), any()], // Event topics (indexed arguments)
            abi.encode(123) // Event data
        );
    }
}
```