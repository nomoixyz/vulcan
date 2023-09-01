// SPDX-License-Identifier: MIT
pragma solidity >=0.8.13 <0.9.0;

function rawConsoleLog(string memory arg) view {
    address console2Addr = 0x000000000000000000636F6e736F6c652e6c6f67;
    (bool status,) = console2Addr.staticcall(abi.encodeWithSignature("log(string)", arg));
    status;
}
