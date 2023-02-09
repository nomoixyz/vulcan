// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.13 <0.9.0;

import {vulcan} from "./Vulcan.sol";

struct Command {
    string[] inputs;
}

library commands {
    using commands for *;

    function create(string[] memory inputs) internal pure returns (Command memory) {
        return Command(inputs);
    }

    function run(string[] memory inputs) internal returns (bytes memory) {
        return vulcan.hevm.ffi(inputs);       
    }

    function run(Command memory self) internal returns (bytes memory) {
        return self.inputs.run();
    }
}

using commands for Command global;
