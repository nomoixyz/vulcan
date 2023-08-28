// SPDX-License-Identifier: MIT
pragma solidity >=0.8.13 <0.9.0;

import {vulcan} from "./Vulcan.sol";

/// @dev Struct used to hold command parameters. Useful for creating commands that can be run
/// multiple times
struct Command {
    string[] inputs;
}

struct CommandResult {
    int32 exitCode;
    bytes stdout;
    bytes stderr;
    Command command;
}

struct FfiResult {
    int32 exitCode;
    bytes stdout;
    bytes stderr;
}

/// @dev Hackish way of getting access to the new `tryFfi` cheat code until it gets realeased on a
/// new `forge-std` version.
interface TryFfi {
    function tryFfi(string[] memory args) external returns (FfiResult memory);
}

library commands {
    using commands for *;

    /// @dev Creates a new 'Command' struct with empty arguments.
    /// @return cmd A new empty 'Command' struct.
    function create() internal pure returns (Command memory cmd) {
        return cmd;
    }

    /// @dev Creates a new `Command` struct using the provided `input` as the executable.
    /// @param input The name of the command.
    /// @return A new `Command` struct with the specified input.
    function create(string memory input) internal pure returns (Command memory) {
        return Command(_toDynamic([input]));
    }

    function arg(Command memory self, string memory _arg) internal pure returns (Command memory) {
        string[] memory inputs = new string[](self.inputs.length + 1);
        for (uint256 i = 0; i < self.inputs.length; i++) {
            inputs[i] = self.inputs[i];
        }
        inputs[inputs.length - 1] = _arg;
        return Command(inputs);
    }

    function args(Command memory self, string[] memory _args) internal pure returns (Command memory) {
        string[] memory inputs = new string[](self.inputs.length + _args.length);
        for (uint256 i = 0; i < self.inputs.length; i++) {
            inputs[i] = self.inputs[i];
        }
        for (uint256 i = 0; i < _args.length; i++) {
            inputs[self.inputs.length + i] = _args[i];
        }
        return Command(inputs);
    }

    function args(Command memory self, string[1] memory _args) internal pure returns (Command memory) {
        return self.args(_toDynamic(_args));
    }

    function args(Command memory self, string[2] memory _args) internal pure returns (Command memory) {
        return self.args(_toDynamic(_args));
    }

    function args(Command memory self, string[3] memory _args) internal pure returns (Command memory) {
        return self.args(_toDynamic(_args));
    }

    function args(Command memory self, string[4] memory _args) internal pure returns (Command memory) {
        return self.args(_toDynamic(_args));
    }

    function args(Command memory self, string[5] memory _args) internal pure returns (Command memory) {
        return self.args(_toDynamic(_args));
    }

    function args(Command memory self, string[6] memory _args) internal pure returns (Command memory) {
        return self.args(_toDynamic(_args));
    }

    function args(Command memory self, string[7] memory _args) internal pure returns (Command memory) {
        return self.args(_toDynamic(_args));
    }

    function args(Command memory self, string[8] memory _args) internal pure returns (Command memory) {
        return self.args(_toDynamic(_args));
    }

    function args(Command memory self, string[9] memory _args) internal pure returns (Command memory) {
        return self.args(_toDynamic(_args));
    }

    function args(Command memory self, string[10] memory _args) internal pure returns (Command memory) {
        return self.args(_toDynamic(_args));
    }

    function args(Command memory self, string[11] memory _args) internal pure returns (Command memory) {
        return self.args(_toDynamic(_args));
    }

    function args(Command memory self, string[12] memory _args) internal pure returns (Command memory) {
        return self.args(_toDynamic(_args));
    }

    function args(Command memory self, string[13] memory _args) internal pure returns (Command memory) {
        return self.args(_toDynamic(_args));
    }

    function args(Command memory self, string[14] memory _args) internal pure returns (Command memory) {
        return self.args(_toDynamic(_args));
    }

    function args(Command memory self, string[15] memory _args) internal pure returns (Command memory) {
        return self.args(_toDynamic(_args));
    }

    function args(Command memory self, string[16] memory _args) internal pure returns (Command memory) {
        return self.args(_toDynamic(_args));
    }

    function args(Command memory self, string[17] memory _args) internal pure returns (Command memory) {
        return self.args(_toDynamic(_args));
    }

    function args(Command memory self, string[18] memory _args) internal pure returns (Command memory) {
        return self.args(_toDynamic(_args));
    }

    function args(Command memory self, string[19] memory _args) internal pure returns (Command memory) {
        return self.args(_toDynamic(_args));
    }

    function args(Command memory self, string[20] memory _args) internal pure returns (Command memory) {
        return self.args(_toDynamic(_args));
    }

    /// @dev Transforms a command to its string representation.
    /// @param self The command struct that will be transformed to a string.
    /// @return The string representation of the command.
    function toString(Command memory self) internal pure returns (string memory) {
        string memory output;

        uint256 length = self.inputs.length;

        for (uint256 i; i < length; ++i) {
            output = string.concat(output, self.inputs[i]);

            if (i < length - 1) {
                output = string.concat(output, " ");
            }
        }

        return output;
    }

    /// @dev Runs a command using the specified `Command` struct as parameters and returns the result.
    /// @param self The `Command` struct that holds the parameters of the command.
    /// @return The result of the command as a bytes array.
    function run(Command memory self) internal returns (CommandResult memory) {
        return self.inputs.run();
    }

    /// @dev Runs a command with the specified `inputs` as parameters and returns the result.
    /// @param inputs An array of strings representing the parameters of the command.
    /// @return result The result of the command as a bytes array.
    function run(string[] memory inputs) internal returns (CommandResult memory result) {
        FfiResult memory ffiResult = TryFfi(address(vulcan.hevm)).tryFfi(inputs);

        result.exitCode = ffiResult.exitCode;
        result.stdout = ffiResult.stdout;
        result.stderr = ffiResult.stderr;
        result.command = Command(inputs);
    }

    function run(string[1] memory inputs) internal returns (CommandResult memory) {
        return _toDynamic(inputs).run();
    }

    function run(string[2] memory inputs) internal returns (CommandResult memory) {
        return _toDynamic(inputs).run();
    }

    function run(string[3] memory inputs) internal returns (CommandResult memory) {
        return _toDynamic(inputs).run();
    }

    function run(string[4] memory inputs) internal returns (CommandResult memory) {
        return _toDynamic(inputs).run();
    }

    function run(string[5] memory inputs) internal returns (CommandResult memory) {
        return _toDynamic(inputs).run();
    }

    function run(string[6] memory inputs) internal returns (CommandResult memory) {
        return _toDynamic(inputs).run();
    }

    function run(string[7] memory inputs) internal returns (CommandResult memory) {
        return _toDynamic(inputs).run();
    }

    function run(string[8] memory inputs) internal returns (CommandResult memory) {
        return _toDynamic(inputs).run();
    }

    function run(string[9] memory inputs) internal returns (CommandResult memory) {
        return _toDynamic(inputs).run();
    }

    function run(string[10] memory inputs) internal returns (CommandResult memory) {
        return _toDynamic(inputs).run();
    }

    function run(string[11] memory inputs) internal returns (CommandResult memory) {
        return _toDynamic(inputs).run();
    }

    function run(string[12] memory inputs) internal returns (CommandResult memory) {
        return _toDynamic(inputs).run();
    }

    function run(string[13] memory inputs) internal returns (CommandResult memory) {
        return _toDynamic(inputs).run();
    }

    function run(string[14] memory inputs) internal returns (CommandResult memory) {
        return _toDynamic(inputs).run();
    }

    function run(string[15] memory inputs) internal returns (CommandResult memory) {
        return _toDynamic(inputs).run();
    }

    function run(string[16] memory inputs) internal returns (CommandResult memory) {
        return _toDynamic(inputs).run();
    }

    function run(string[17] memory inputs) internal returns (CommandResult memory) {
        return _toDynamic(inputs).run();
    }

    function run(string[18] memory inputs) internal returns (CommandResult memory) {
        return _toDynamic(inputs).run();
    }

    function run(string[19] memory inputs) internal returns (CommandResult memory) {
        return _toDynamic(inputs).run();
    }

    function run(string[20] memory inputs) internal returns (CommandResult memory) {
        return _toDynamic(inputs).run();
    }

    /// @dev Checks if a `CommandResult` returned an `ok` exit code.
    function isOk(CommandResult memory self) internal pure returns (bool) {
        return self.exitCode == 0;
    }

    /// @dev Checks if a `CommandResult` struct is an error.
    function isError(CommandResult memory self) internal pure returns (bool) {
        return !self.isOk();
    }

    /// @dev Returns the output of a `CommandResult` or reverts if the result was an error.
    function unwrap(CommandResult memory self) internal pure returns (bytes memory) {
        string memory error;

        if (self.isError()) {
            error = string.concat("Failed to run command ", self.command.toString());

            if (self.stderr.length > 0) {
                error = string.concat(error, ": ", string(self.stderr));
            }
        }

        return expect(self, error);
    }

    /// @dev Returns the output of a `CommandResult` or reverts if the result was an error.
    /// @param customError The error message that will be used when reverting.
    function expect(CommandResult memory self, string memory customError)
        internal
        pure
        returns (bytes memory)
    {
        if (self.isError()) {
            revert(customError);
        }

        return self.stdout;
    }

    function _toDynamic(string[1] memory inputs) private pure returns (string[] memory _inputs) {
        _inputs = new string[](1);
        _inputs[0] = inputs[0];
    }

    function _toDynamic(string[2] memory inputs) private pure returns (string[] memory _inputs) {
        _inputs = new string[](2);
        for (uint256 i = 0; i < 2; i++) {
            _inputs[i] = inputs[i];
        }
    }

    function _toDynamic(string[3] memory inputs) private pure returns (string[] memory _inputs) {
        _inputs = new string[](3);
        for (uint256 i = 0; i < 3; i++) {
            _inputs[i] = inputs[i];
        }
    }

    function _toDynamic(string[4] memory inputs) private pure returns (string[] memory _inputs) {
        _inputs = new string[](4);
        for (uint256 i = 0; i < 4; i++) {
            _inputs[i] = inputs[i];
        }
    }

    function _toDynamic(string[5] memory inputs) private pure returns (string[] memory _inputs) {
        _inputs = new string[](5);
        for (uint256 i = 0; i < 5; i++) {
            _inputs[i] = inputs[i];
        }
    }

    function _toDynamic(string[6] memory inputs) private pure returns (string[] memory _inputs) {
        _inputs = new string[](6);
        for (uint256 i = 0; i < 6; i++) {
            _inputs[i] = inputs[i];
        }
    }

    function _toDynamic(string[7] memory inputs) private pure returns (string[] memory _inputs) {
        _inputs = new string[](7);
        for (uint256 i = 0; i < 7; i++) {
            _inputs[i] = inputs[i];
        }
    }

    function _toDynamic(string[8] memory inputs) private pure returns (string[] memory _inputs) {
        _inputs = new string[](8);
        for (uint256 i = 0; i < 8; i++) {
            _inputs[i] = inputs[i];
        }
    }

    function _toDynamic(string[9] memory inputs) private pure returns (string[] memory _inputs) {
        _inputs = new string[](9);
        for (uint256 i = 0; i < 9; i++) {
            _inputs[i] = inputs[i];
        }
    }

    function _toDynamic(string[10] memory inputs) private pure returns (string[] memory _inputs) {
        _inputs = new string[](10);
        for (uint256 i = 0; i < 10; i++) {
            _inputs[i] = inputs[i];
        }
    }

    function _toDynamic(string[11] memory inputs) private pure returns (string[] memory _inputs) {
        _inputs = new string[](11);
        for (uint256 i = 0; i < 11; i++) {
            _inputs[i] = inputs[i];
        }
    }

    function _toDynamic(string[12] memory inputs) private pure returns (string[] memory _inputs) {
        _inputs = new string[](12);
        for (uint256 i = 0; i < 12; i++) {
            _inputs[i] = inputs[i];
        }
    }

    function _toDynamic(string[13] memory inputs) private pure returns (string[] memory _inputs) {
        _inputs = new string[](13);
        for (uint256 i = 0; i < 13; i++) {
            _inputs[i] = inputs[i];
        }
    }

    function _toDynamic(string[14] memory inputs) private pure returns (string[] memory _inputs) {
        _inputs = new string[](14);
        for (uint256 i = 0; i < 14; i++) {
            _inputs[i] = inputs[i];
        }
    }

    function _toDynamic(string[15] memory inputs) private pure returns (string[] memory _inputs) {
        _inputs = new string[](15);
        for (uint256 i = 0; i < 15; i++) {
            _inputs[i] = inputs[i];
        }
    }

    function _toDynamic(string[16] memory inputs) private pure returns (string[] memory _inputs) {
        _inputs = new string[](16);
        for (uint256 i = 0; i < 16; i++) {
            _inputs[i] = inputs[i];
        }
    }

    function _toDynamic(string[17] memory inputs) private pure returns (string[] memory _inputs) {
        _inputs = new string[](17);
        for (uint256 i = 0; i < 17; i++) {
            _inputs[i] = inputs[i];
        }
    }

    function _toDynamic(string[18] memory inputs) private pure returns (string[] memory _inputs) {
        _inputs = new string[](18);
        for (uint256 i = 0; i < 18; i++) {
            _inputs[i] = inputs[i];
        }
    }

    function _toDynamic(string[19] memory inputs) private pure returns (string[] memory _inputs) {
        _inputs = new string[](19);
        for (uint256 i = 0; i < 19; i++) {
            _inputs[i] = inputs[i];
        }
    }

    function _toDynamic(string[20] memory inputs) private pure returns (string[] memory _inputs) {
        _inputs = new string[](20);
        for (uint256 i = 0; i < 20; i++) {
            _inputs[i] = inputs[i];
        }
    }
}

using commands for Command global;
using commands for CommandResult global;
