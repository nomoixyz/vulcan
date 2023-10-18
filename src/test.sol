// SPDX-License-Identifier: MIT
pragma solidity >=0.8.13 <0.9.0;

// Common imports
import "./_imports.sol";

// Unsafe or test only imports
import {accountsUnsafe as accounts} from "./_internal/Accounts.sol";
import {ctxUnsafe as ctx} from "./_internal/Context.sol";
import {expect, any} from "./_internal/Expect.sol";
import {forksUnsafe as forks, Fork} from "./_internal/ForksUnsafe.sol";
import {InvariantsBase, invariants} from "./_internal/Invariants.sol";
import {bound} from "./_utils/bound.sol";
import {formatError} from "./_utils/formatError.sol";

// @dev Main entry point to Vulcan tests
contract Test is InvariantsBase {
    bool public IS_TEST = true;

    constructor() {
        vulcan.init();
    }

    function failed() public view returns (bool) {
        return vulcan.failed();
    }

    modifier shouldFail() {
        bool pre = vulcan.failed();
        _;
        bool post = vulcan.failed();

        if (pre) {
            return;
        }

        if (!post) {
            revert(formatError("test", "shouldFail()", "Test expected to fail"));
        }

        vulcan.clearFailure();
    }
}
