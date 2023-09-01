pragma solidity >=0.8.13 <0.9.0;

import {Test, expect, commands, forks, Fork, CommandResult, println} from "../../src/test.sol";
import {Sender} from "../mocks/Sender.sol";

contract ForksTest is Test {
    string private constant ENDPOINT = "http://localhost:8545";

    modifier skipIfEndpointFails() {
        string memory data = '{"jsonrpc":"2.0","method":"web3_clientVersion","params":[],"id":67}';

        CommandResult memory res = commands.create("curl").args(
            ["--silent", "-H", "Content-Type: application/json", "-X", "POST", "--data", data, ENDPOINT]
        ).run();

        if (res.stdout.length == 0) {
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
