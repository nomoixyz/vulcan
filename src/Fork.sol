// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.13 <0.9.0;

import { Vm as Hevm } from "forge-std/Vm.sol";
import "./Vulcan.sol";

type Forking is uint256;
type Fork is uint256;

library ForkingLib {

    function forkAtBlock(Forking, string memory endpoint, uint256 blockNumber) internal returns (Fork) {
        return Fork.wrap(vulcan.hevm.createFork(endpoint, blockNumber));
    }
    function create(Forking, string memory endpoint) internal returns (Fork) {
        return Fork.wrap(vulcan.hevm.createFork(endpoint));
    }
    function forkBeforeTx(Forking, string memory endpoint, bytes32 txHash) internal returns (Fork) {
        return Fork.wrap(vulcan.hevm.createFork(endpoint, txHash));
    }

    function select(Fork self) internal returns (Fork) {
        vulcan.hevm.selectFork(Fork.unwrap(self));
        return self;
    }

    function activeFork(Fork) internal view returns (Fork) {
        return Fork.wrap(vulcan.hevm.activeFork());
    }

    function setBlockNumber(Fork self, uint256 blockNumber) internal returns (Fork) {
        vulcan.hevm.rollFork(Fork.unwrap(self), blockNumber);
        return self;
    }

    function beforeTx(Fork self, bytes32 txHash) internal returns (Fork) {
        vulcan.hevm.rollFork(Fork.unwrap(self), txHash);
        return self;
    }


    function persistBetweenForks(address self) internal returns(address) {
        vulcan.hevm.makePersistent(self);
        return self;
    }

    function persistBetweenForks(Forking, address who) internal {
        vulcan.hevm.makePersistent(who);
    }

    function persistBetweenForks(Forking, address who1, address who2) internal {
        vulcan.hevm.makePersistent(who1, who2);
    }
    function persistBetweenForks(Forking, address who1, address who2, address who3) internal {
        vulcan.hevm.makePersistent(who1, who2, who3);
    }
    function persistBetweenForks(Forking, address[] memory whos) internal {
        vulcan.hevm.makePersistent(whos);
    }
    function stopPersist(Forking, address who) internal {
        vulcan.hevm.revokePersistent(who);
    }
    function stopPersist(Forking, address[] memory whos) internal {
        vulcan.hevm.revokePersistent(whos);
    }
    function isPersistent(Forking, address who) internal view returns (bool) {
        return vulcan.hevm.isPersistent(who);
    }
    function allowCheatcodes(Forking, address who) internal {
        vulcan.hevm.allowCheatcodes(who);
    }
    function executeTx(Forking, bytes32 txHash) internal {
        vulcan.hevm.transact(txHash);
    }
    function executeTx(Fork self, bytes32 txHash) internal returns(Fork) {
        vulcan.hevm.transact(Fork.unwrap(self), txHash);
        return self;
    }
}

Forking constant forking = Forking.wrap(0);

using ForkingLib for Forking global;