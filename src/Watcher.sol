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

    bytes32 constant CAPTURE_REVERTS_SLOT = keccak256("vulcan.watcher.captureReverts.slot");
    bytes32 constant CALLS_SLOT = keccak256("vulcan.watcher.calls.slot");
    address public immutable target = address(this);

    function calls(uint256 _index) external view returns (Call memory) {
        return _getCalls()[_index];
    }

    function firstCall() external view returns (Call memory) {
        return _getCalls()[0];
    }

    function lastCall() external view returns (Call memory) {
        Call[] memory calls = _getCalls();

        return calls[calls.length - 1];
    }

    function reset() external {
        _setCaptureReverts(false);

        Call[] storage calls = _getCalls();

        uint256 callsLength = calls.length;

        for (uint256 i; i < callsLength; ++i) {
            calls.pop();
        }
    } 

    function captureReverts() external {
        _setCaptureReverts(true);
    }

    function disableCaptureReverts() external {
        _setCaptureReverts(false);
    }

    fallback(bytes calldata _callData) external payable returns (bytes memory) {
        vulcan.vm.recordLogs();

        (bool success, bytes memory returnData) = target.delegatecall(_callData);

        Log[] memory logs = vulcan.vm.getRecordedLogs();

        // Filter logs by address and replace in place
        uint256 watcherLogCount = 0;
        for (uint256 i = 0; i < logs.length; i++) {
            if (logs[i].emitter == address(this)) {
                logs[watcherLogCount] = logs[i];
                watcherLogCount++;
            }
        }

        Call storage call = _getCalls().push();

        call.callData = _callData;
        call.success = success;
        call.returnData = returnData;

        // Add logs to call
        for (uint256 i = 0; i < watcherLogCount; i++) {
            call.logs.push(logs[i]);
        }

        if (!_shouldCaptureReverts() && !success) {
            assembly {
                revert(add(returnData, 32), mload(returnData))
            }
        }
        
        return returnData;
    }

    function _shouldCaptureReverts() internal view returns (bool val) {
        bytes32 slot = CAPTURE_REVERTS_SLOT;

        assembly {
            val := sload(slot)
        }
    }

    function _setCaptureReverts(bool value) internal {
        bytes32 slot = CAPTURE_REVERTS_SLOT;

        assembly {
            sstore(slot, value)
        }
    }

    function _getCalls() internal pure returns (Call[] storage results) {
        bytes32 slot = CALLS_SLOT;

        assembly {
            results.slot := slot
        }
    }
}
