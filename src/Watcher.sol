// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.7.0;

import "./Vulcan.sol";

contract Watcher {
    using vulcan for *;


    struct Call {
        bytes callData;
        bool success;
        bytes returnData;
        Log[] logs;
    }

    bytes32 constant CALLS_SLOT = keccak256("vulcan.callwatcher.slot");
    address immutable target = address(this);
    VulcanVmTest vm;

    function calls(uint256 _index) external view returns (Call memory) {
        return _getCalls()[_index];
    }

    fallback(bytes calldata _callData) external payable returns (bytes memory) {
        vulcan.vm().recordLogs();
        (bool success, bytes memory data) = target.delegatecall(_callData);

        Log[] memory logs = vm.getRecordedLogs();

        // Filter logs by address and replace in place
        uint256 watcherLogCount = 0;
        for (uint256 i = 0; i < logs.length; i++) {
            if (logs[i].emitter == address(this)) {
                logs[watcherLogCount] = logs[i];
                watcherLogCount++;
            }
        }

        // Copy logs to new array
        Log[] memory filteredLogs = new Log[](watcherLogCount);
        for (uint256 i = 0; i < watcherLogCount; i++) {
            filteredLogs[i] = logs[i];
        }

        Call memory call = Call(_callData, success, data, filteredLogs);
        _getCalls().push(call);
        // _getCalls().push(call);

        return data;
    }

    function _getCalls() internal pure returns (Call[] storage results) {
        bytes32 slot = CALLS_SLOT;

        assembly {
            results.slot := slot
        }
    }
}
