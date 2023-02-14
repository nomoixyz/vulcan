![Vulcan](./assets/landscape.png)

## Usage

```Solidity
import { Test, accounts, watchers, expect } from  "vulcan/test.sol";
import "MyContract.sol";

contract TestMyContract is Test {
    using accounts for *;
    using watchers for *;

    function testMyContract() external {
        MyContract myContract = new MyContract();
        
        address alice = accounts.create("Alice").setBalance(123).impersonate();
        
        myContract.setValue(1);
        uint256 val = myContract.getValue();
        
        expect(val).toEqual(1);
    }
    
    function testSomethingElse() external {
        MyContract myContract = new MyContract();
        
        address(myContract).watch();
        
        myContract.doSomethingThatReverts();
        
        expect(address(myContract).lastCall()).toHaveRevertedWith("Reverted!");
    }
}
```
