// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.7.0;


struct Log {
        bytes32[] topics;
        bytes data;
        address emitter;
}


library Call {
    struct Call {
        address callee;
        uint256 value;
        bytes data;
        uint256 gas;

        uint256 snapshot;
        bool executed;
    }

    function execute(Call storage self) internal returns (bool, bytes memory) {
        uint256 currentSnapshot;
        if (!self.executed) {
            self.snapshot = vm.snapshot();
            self.executed = true;
        } else {
            currentSnapshot = vm.snapshot();
            vm.revertToSnapshot(self.snapshot);
        }

        (bool success, bytes memory returnData) = self.callee.call{value: self.value, gas: self.gas}(self.data);

        if (currentSnapshot != 0) {
            vm.revertToSnapshot(currentSnapshot);
        }

        return (success, returnData);
    }
}

library Expect {
    using CallLib for CallLib.Call;

    /* Events */

    type Events is uint256;

    struct __ExpectCall {
        CallLib.Call call;
        bool _not;
    }

    function not(__ExpectCall storage self) internal pure returns (__ExpectCall storage) {
        self._not = !self._not;
        return self;
    }


    function toEmit(__ExpectCall storage self, LogFilter memory filter) internal view returns (__ExpectCall storage) {
        filter.execute();
        (bool success,,) = self.call.execute();
    }


    function toRevert(__ExpectCall storage self) internal pure {
        if (self.not) {
            vm.expectRevert();
            (bool reverted,) = self.call.execute();
            assertTrue(status, "call did not revert");
        } else {
            (bool ok,) = self.call.execute();
            assertTrue(ok, "call reverted");
        }
    }
}
