// SPDX-License-Identifier: MIT
pragma solidity >=0.8.13 <0.9.0;

import {Test, forks, Fork, println} from "src/test.sol";
import {expect} from "src/test/Expect.sol";
import {commands, CommandResult, CommandOutput} from "src/test/Commands.sol";
import {forks, Fork} from "src/test/Forks.sol";
import {println} from "src/utils.sol";
import {Sender} from "../mocks/Sender.sol";

contract ForksTest is Test {
    string private constant ENDPOINT = "http://localhost:8545";

    modifier skipIfEndpointFails() {
        string memory data = '{"jsonrpc":"2.0","method":"web3_clientVersion","params":[],"id":67}';

        CommandResult res = commands.create("curl").args(
            ["--silent", "-H", "Content-Type: application/json", "-X", "POST", "--data", data, ENDPOINT]
        ).run();

        CommandOutput memory cmdOutput = res.unwrap();

        if (cmdOutput.stdout.length == 0) {
            println("Skipping test because forking endpoint is not available");
            return;
        }

        _;
    }

    function testItCanForkAtBlock() external skipIfEndpointFails {
        uint256 blockNumber = 1337;

        Fork fork = forks.createAtBlock(ENDPOINT, blockNumber).select();

        expect(Fork.unwrap(forks.active())).toEqual(Fork.unwrap(fork));
        expect(block.number).toEqual(blockNumber);
    }

    function testItCanSetBlockNumber() external skipIfEndpointFails {
        uint256 blockNumber = 1337;

        Fork fork = forks.createAtBlock(ENDPOINT, blockNumber).select();

        uint256 newBlockNumber = 1338;

        fork.setBlockNumber(newBlockNumber);

        expect(block.number).toEqual(newBlockNumber);
    }
}
