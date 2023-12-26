// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, expect, fe, Fe} from "vulcan/test.sol";

/// @title How to compile `fe` code
/// @dev How to compile `fe` using the `fe` module (Requires to have `fe` installed)
contract FeExample is Test {
    function test() external {
        Fe memory feCmd = fe.create().setFilePath("./test/mocks/guest_book.fe").setOverwrite(true);

        // Compile the bytecode and revert if there is an error
        feCmd.build().unwrap();

        bytes memory bytecode = feCmd.getBytecode("MyFeContract").toValue();

        expect(bytecode).toEqual("600180600c6000396000f3fe00");
    }
}
