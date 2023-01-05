// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.7.0;

import "./VmLib.sol";

library TestLib {
    using VmLib for _T;
    using VmLib for address;

    bytes32 constant GLOBAL_FAILED_SLOT = bytes32("failed");

    function failed(_T self) internal view returns (bool) {
        bytes32 globalFailed = self.readStorage(address(self.underlying()), GLOBAL_FAILED_SLOT);
        return globalFailed == bytes32(uint256(1));
    } 

    function fail(_T self) internal {
        address(self.underlying()).setStorage(GLOBAL_FAILED_SLOT, bytes32(uint256(1)));
    }
}
