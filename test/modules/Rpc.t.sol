// SPDX-License-Identifier: MIT
pragma solidity >=0.8.13 <0.9.0;

import {Test} from "vulcan/test.sol";
import {rpc} from "vulcan/test/Rpc.sol";
import {println} from "vulcan/utils.sol";
import {Fork, forks} from "vulcan/test/Forks.sol";

contract RpcTest is Test {
    function testRpcCall() external {
        forks.create("http://127.0.0.1:8545").select();

        string memory method = "eth_chainId";
        string memory params = "[]";

        bytes memory data = rpc.call(method, params);

        println("Result {s}", abi.encode(data));
    }
}
