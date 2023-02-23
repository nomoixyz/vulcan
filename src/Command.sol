// SPDX-License-Identifier: MIT
pragma solidity >=0.8.13 <0.9.0;

import {vulcan} from "./Vulcan.sol";

/// @dev Struct used to hold command parameters. Useful for creating commands that can be run
/// multiple times
struct Command {
    string[] inputs;
}

library commands {
    using commands for *;

    /// @dev Creates a new `Command` struct using the provided `input` as the executable.
    /// @param input The name of the command.
    /// @return A new `Command` struct with the specified input.
    function create(string memory input) internal pure returns (Command memory) {
        return Command([input].toDynamic());
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
        return self.args(_args.toDynamic());
    }

    function args(Command memory self, string[2] memory _args) internal pure returns (Command memory) {
        return self.args(_args.toDynamic());
    }

    function args(Command memory self, string[3] memory _args) internal pure returns (Command memory) {
        return self.args(_args.toDynamic());
    }

    function args(Command memory self, string[4] memory _args) internal pure returns (Command memory) {
        return self.args(_args.toDynamic());
    }

    function args(Command memory self, string[5] memory _args) internal pure returns (Command memory) {
        return self.args(_args.toDynamic());
    }

    function args(Command memory self, string[6] memory _args) internal pure returns (Command memory) {
        return self.args(_args.toDynamic());
    }

    function args(Command memory self, string[7] memory _args) internal pure returns (Command memory) {
        return self.args(_args.toDynamic());
    }

    function args(Command memory self, string[8] memory _args) internal pure returns (Command memory) {
        return self.args(_args.toDynamic());
    }

    function args(Command memory self, string[9] memory _args) internal pure returns (Command memory) {
        return self.args(_args.toDynamic());
    }

    function args(Command memory self, string[10] memory _args) internal pure returns (Command memory) {
        return self.args(_args.toDynamic());
    }

    function args(Command memory self, string[11] memory _args) internal pure returns (Command memory) {
        return self.args(_args.toDynamic());
    }

    function args(Command memory self, string[12] memory _args) internal pure returns (Command memory) {
        return self.args(_args.toDynamic());
    }

    function args(Command memory self, string[13] memory _args) internal pure returns (Command memory) {
        return self.args(_args.toDynamic());
    }

    function args(Command memory self, string[14] memory _args) internal pure returns (Command memory) {
        return self.args(_args.toDynamic());
    }

    function args(Command memory self, string[15] memory _args) internal pure returns (Command memory) {
        return self.args(_args.toDynamic());
    }

    function args(Command memory self, string[16] memory _args) internal pure returns (Command memory) {
        return self.args(_args.toDynamic());
    }

    function args(Command memory self, string[17] memory _args) internal pure returns (Command memory) {
        return self.args(_args.toDynamic());
    }

    function args(Command memory self, string[18] memory _args) internal pure returns (Command memory) {
        return self.args(_args.toDynamic());
    }

    function args(Command memory self, string[19] memory _args) internal pure returns (Command memory) {
        return self.args(_args.toDynamic());
    }

    function args(Command memory self, string[20] memory _args) internal pure returns (Command memory) {
        return self.args(_args.toDynamic());
    }

    /// @dev Runs a command using the specified `Command` struct as parameters and returns the result.
    /// @param self The `Command` struct that holds the parameters of the command.
    /// @return The result of the command as a bytes array.
    function run(Command memory self) internal returns (bytes memory) {
        return self.inputs.run();
    }

    /// @dev Runs a command with the specified `inputs` as parameters and returns the result.
    /// @param inputs An array of strings representing the parameters of the command.
    /// @return The result of the command as a bytes array.
    function run(string[] memory inputs) internal returns (bytes memory) {
        return vulcan.hevm.ffi(inputs);
    }

    function run(string[1] memory inputs) internal returns (bytes memory) {
        return inputs.toDynamic().run();
    }

    function run(string[2] memory inputs) internal returns (bytes memory) {
        return inputs.toDynamic().run();
    }

    function run(string[3] memory inputs) internal returns (bytes memory) {
        return inputs.toDynamic().run();
    }

    function run(string[4] memory inputs) internal returns (bytes memory) {
        return inputs.toDynamic().run();
    }

    function run(string[5] memory inputs) internal returns (bytes memory) {
        return inputs.toDynamic().run();
    }

    function run(string[6] memory inputs) internal returns (bytes memory) {
        return inputs.toDynamic().run();
    }

    function run(string[7] memory inputs) internal returns (bytes memory) {
        return inputs.toDynamic().run();
    }

    function run(string[8] memory inputs) internal returns (bytes memory) {
        return inputs.toDynamic().run();
    }

    function run(string[9] memory inputs) internal returns (bytes memory) {
        return inputs.toDynamic().run();
    }

    function run(string[10] memory inputs) internal returns (bytes memory) {
        return inputs.toDynamic().run();
    }

    function run(string[11] memory inputs) internal returns (bytes memory) {
        return inputs.toDynamic().run();
    }

    function run(string[12] memory inputs) internal returns (bytes memory) {
        return inputs.toDynamic().run();
    }

    function run(string[13] memory inputs) internal returns (bytes memory) {
        return inputs.toDynamic().run();
    }

    function run(string[14] memory inputs) internal returns (bytes memory) {
        return inputs.toDynamic().run();
    }

    function run(string[15] memory inputs) internal returns (bytes memory) {
        return inputs.toDynamic().run();
    }

    function run(string[16] memory inputs) internal returns (bytes memory) {
        return inputs.toDynamic().run();
    }

    function run(string[17] memory inputs) internal returns (bytes memory) {
        return inputs.toDynamic().run();
    }

    function run(string[18] memory inputs) internal returns (bytes memory) {
        return inputs.toDynamic().run();
    }

    function run(string[19] memory inputs) internal returns (bytes memory) {
        return inputs.toDynamic().run();
    }

    function run(string[20] memory inputs) internal returns (bytes memory) {
        return inputs.toDynamic().run();
    }

    // TODO: We probably want to move this to a different module at some point
    function toDynamic(string[1] memory inputs) internal pure returns (string[] memory _inputs) {
        _inputs = new string[](1);
        _inputs[0] = inputs[0];
    }

    function toDynamic(string[2] memory inputs) internal pure returns (string[] memory _inputs) {
        _inputs = new string[](2);
        for (uint256 i = 0; i < 2; i++) {
            _inputs[i] = inputs[i];
        }
    }

    function toDynamic(string[3] memory inputs) internal pure returns (string[] memory _inputs) {
        _inputs = new string[](3);
        for (uint256 i = 0; i < 3; i++) {
            _inputs[i] = inputs[i];
        }
    }

    function toDynamic(string[4] memory inputs) internal pure returns (string[] memory _inputs) {
        _inputs = new string[](4);
        for (uint256 i = 0; i < 4; i++) {
            _inputs[i] = inputs[i];
        }
    }

    function toDynamic(string[5] memory inputs) internal pure returns (string[] memory _inputs) {
        _inputs = new string[](5);
        for (uint256 i = 0; i < 5; i++) {
            _inputs[i] = inputs[i];
        }
    }

    function toDynamic(string[6] memory inputs) internal pure returns (string[] memory _inputs) {
        _inputs = new string[](6);
        for (uint256 i = 0; i < 6; i++) {
            _inputs[i] = inputs[i];
        }
    }

    function toDynamic(string[7] memory inputs) internal pure returns (string[] memory _inputs) {
        _inputs = new string[](7);
        for (uint256 i = 0; i < 7; i++) {
            _inputs[i] = inputs[i];
        }
    }

    function toDynamic(string[8] memory inputs) internal pure returns (string[] memory _inputs) {
        _inputs = new string[](8);
        for (uint256 i = 0; i < 8; i++) {
            _inputs[i] = inputs[i];
        }
    }

    function toDynamic(string[9] memory inputs) internal pure returns (string[] memory _inputs) {
        _inputs = new string[](9);
        for (uint256 i = 0; i < 9; i++) {
            _inputs[i] = inputs[i];
        }
    }

    function toDynamic(string[10] memory inputs) internal pure returns (string[] memory _inputs) {
        _inputs = new string[](10);
        for (uint256 i = 0; i < 10; i++) {
            _inputs[i] = inputs[i];
        }
    }

    function toDynamic(string[11] memory inputs) internal pure returns (string[] memory _inputs) {
        _inputs = new string[](11);
        for (uint256 i = 0; i < 11; i++) {
            _inputs[i] = inputs[i];
        }
    }

    function toDynamic(string[12] memory inputs) internal pure returns (string[] memory _inputs) {
        _inputs = new string[](12);
        for (uint256 i = 0; i < 12; i++) {
            _inputs[i] = inputs[i];
        }
    }

    function toDynamic(string[13] memory inputs) internal pure returns (string[] memory _inputs) {
        _inputs = new string[](13);
        for (uint256 i = 0; i < 13; i++) {
            _inputs[i] = inputs[i];
        }
    }

    function toDynamic(string[14] memory inputs) internal pure returns (string[] memory _inputs) {
        _inputs = new string[](14);
        for (uint256 i = 0; i < 14; i++) {
            _inputs[i] = inputs[i];
        }
    }

    function toDynamic(string[15] memory inputs) internal pure returns (string[] memory _inputs) {
        _inputs = new string[](15);
        for (uint256 i = 0; i < 15; i++) {
            _inputs[i] = inputs[i];
        }
    }

    function toDynamic(string[16] memory inputs) internal pure returns (string[] memory _inputs) {
        _inputs = new string[](16);
        for (uint256 i = 0; i < 16; i++) {
            _inputs[i] = inputs[i];
        }
    }

    function toDynamic(string[17] memory inputs) internal pure returns (string[] memory _inputs) {
        _inputs = new string[](17);
        for (uint256 i = 0; i < 17; i++) {
            _inputs[i] = inputs[i];
        }
    }

    function toDynamic(string[18] memory inputs) internal pure returns (string[] memory _inputs) {
        _inputs = new string[](18);
        for (uint256 i = 0; i < 18; i++) {
            _inputs[i] = inputs[i];
        }
    }

    function toDynamic(string[19] memory inputs) internal pure returns (string[] memory _inputs) {
        _inputs = new string[](19);
        for (uint256 i = 0; i < 19; i++) {
            _inputs[i] = inputs[i];
        }
    }

    function toDynamic(string[20] memory inputs) internal pure returns (string[] memory _inputs) {
        _inputs = new string[](20);
        for (uint256 i = 0; i < 20; i++) {
            _inputs[i] = inputs[i];
        }
    }
}

using commands for Command global;
