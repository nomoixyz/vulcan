pragma solidity ^0.8.13;

import "../src/Test2.sol";

contract ExampleTest is Test {
    using test for *;

    function testSomething() external {
        test.impersonate(address(0));
        // OR
        address(0).impersonate();
        address(0).setBalance(100 ether).setNonce(123).impersonate();
    }
}