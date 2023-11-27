## Examples
### Logging events

Logging events and reading events topics and data

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, expect, events, Log} from "vulcan/test.sol";

contract EventsExample is Test {
    using events for *;

    event SomeEvent(uint256 indexed a, address b);

    function run() external {
        uint256 a = 666;
        address b = address(333);

        events.recordLogs();

        emit SomeEvent(a, b);

        Log[] memory logs = events.getRecordedLogs();

        expect(logs.length).toEqual(1);
        expect(logs[0].emitter).toEqual(address(this));
        expect(logs[0].topics[0]).toEqual(SomeEvent.selector);
        expect(logs[0].topics[1]).toEqual(a.topic());
        expect(logs[0].data).toEqual(abi.encode(b));
    }
}

```

