pragma solidity ^0.8.13;

contract Sender {
    function get() external view returns (address) {
        return msg.sender;
    }

    function getWithOrigin() external view returns (address, address) {
        return (msg.sender, tx.origin);
    }
}
