// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.13 <0.9.0;

import {vulcan} from "./Vulcan.sol";

/// @dev Struct used to hold command parameters. Useful for creating commands that can be run
/// multiple times
struct Command {
    string[] inputs;
}

library commands {
    using commands for *;

    /// @dev Creates a new `Command` struct using the provided `inputs` as command parameters.
    /// @param inputs An array of strings representing the parameters of the command.
    /// @return A new `Command` struct with the specified parameters.
    function create(string[] memory inputs) internal pure returns (Command memory) {
        return Command(inputs);
    }

    /// @dev Runs a command with the specified `inputs` as parameters and returns the result.
    /// @param inputs An array of strings representing the parameters of the command.
    /// @return The result of the command as a bytes array.
    function run(string[] memory inputs) internal returns (bytes memory) {
        return vulcan.hevm.ffi(inputs);
    }

    /// @dev Runs a command using the specified `Command` struct as parameters and returns the result.
    /// @param self The `Command` struct that holds the parameters of the command.
    /// @return The result of the command as a bytes array.
    function run(Command memory self) internal returns (bytes memory) {
        return self.inputs.run();
    }
}

using commands for Command global;
