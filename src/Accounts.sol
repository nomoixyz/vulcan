// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.13 <0.9.0;

import "./Vulcan.sol";

library accounts {
    /// @dev reads an storage slot from an adress and returns the content
    /// @param who the target address from which the storage slot will be read
    /// @param slot the storage slot to read
    /// @return the content of the storage at slot `slot` on the address `who`
    function readStorage(address who, bytes32 slot) internal view returns(bytes32) {
        return vulcan.hevm.load(who, slot);
    }

    /// @dev signs `digest` using `privKey`
    /// @param privKey the private key used to sign
    /// @param digest the data to sign
    /// @return signature in the form of (v, r, s)
    function sign(uint256 privKey, bytes32 digest) internal pure returns (uint8, bytes32, bytes32) {
        return vulcan.hevm.sign(privKey, digest);
    }

    /// @dev obtains the address derived from `privKey`
    /// @param privKey the private key to derive
    /// @return the address derived from `privKey`
    function derive(uint256 privKey) internal pure returns (address) {
        return vulcan.hevm.addr(privKey);
    }

    function deriveKey(string memory mnemonicOrPath, uint32 index) internal pure returns (uint256) {
        return vulcan.hevm.deriveKey(mnemonicOrPath, index);
    }

    function deriveKey(string memory mnemonicOrPath, string memory derivationPath, uint32 index) internal pure returns (uint256) {
        return vulcan.hevm.deriveKey(mnemonicOrPath, derivationPath, index);
    }

    function rememberKey(uint256 privKey) internal returns (address) {
        return vulcan.hevm.rememberKey(privKey);
    }

    /// @dev obtains the nonce of the address `who`
    /// @param who the target address
    /// @return the nonce of address `who`
    function getNonce(address who) internal view returns (uint64) {
        return vulcan.hevm.getNonce(who);
    }

    /* Maybe this should be in a storage module? */

    /// @dev records all storage reads and writes
    function recordStorage() internal {
        vulcan.hevm.record();
    }

    /// @dev obtains all reads and writes to the storage from address `who`
    /// @param who the target address to read all accesses to the storage
    /// @return reads and writes in the form of (bytes32[] reads, bytes32[] writes)
    function getStorageAccesses(address who) internal returns (bytes32[] memory reads, bytes32[] memory writes) {
        return vulcan.hevm.accesses(who);
    }

    /// @dev labels the address `who` with label `lbl`
    /// @param who the address to label
    /// @param lbl the new label for address `who`
    function label(address who, string memory lbl) internal returns (address) {
        vulcan.hevm.label(who, lbl);
        return who;
    }

    /// @dev creates an address from `name`
    function create(string memory name) internal returns (address) {
        return create(name, name);
    }

    /// @dev creates an address from `name` and labels it with `lbl`
    function create(string memory name, string memory lbl) internal returns (address) {
        address addr = derive(uint256(keccak256(abi.encodePacked(name))));

        return label(addr, lbl);
    }

    /// @dev sets the value of the storage slot `slot` to `value`
    /// @param self the address that will be updated
    /// @param slot the slot to update
    /// @param value the new value of the slot `slot` on the address `self`
    /// @return the modified address so other methods can be chained
    function setStorage(address self, bytes32 slot, bytes32 value) internal returns(address) {
        vulcan.hevm.store(self, slot, value);
        return self;
    }

    /// @dev sets the nonce of the address `addr` to `n`
    /// @param self the address that will be updated
    /// @param n the new nonce
    /// @return the address that was updated
    function setNonce(address self, uint64 n) internal returns(address) {
        vulcan.hevm.setNonce(self, n);
        return self;
    }

    /// @dev sets the next call's `msg.sender` to `sender`
    /// @param self the address to set the `msg.sender`
    /// @return the `msg.sender` for the next call
    function impersonateOnce(address self) internal returns(address) {
        vulcan.hevm.prank(self);
        return self;
    }

    /// @dev sets all subsequent call's `msg.sender` to `sender` until `stopPrank` is called
    /// @param self the address to set the `msg.sender`
    /// @return the `msg.sender` for the next calls
    function impersonate(address self) internal returns(address) {
        vulcan.hevm.startPrank(self);
        return self;
    }

    /// @dev sets the next call's `msg.sender` to `sender` and `tx.origin` to `origin`
    /// @param self the address to set the `msg.sender`
    /// @param origin the address to set the `tx.origin`
    /// @return the `msg.sender` for the next call
    function impersonateOnce(address self, address origin) internal returns(address) {
        vulcan.hevm.prank(self, origin);
        return self;
    }

    /// @dev sets all subsequent call's `msg.sender` to `sender` and `tx.origin` to `origin` until `stopPrank` is called
    /// @param self the address to set the `msg.sender`
    /// @param origin the address to set the `tx.origin`
    /// @return the `msg.sender` for the next calls
    function impersonate(address self, address origin) internal returns(address) {
        vulcan.hevm.startPrank(self, origin);
        return self;
    }

    /// @dev resets the values of `msg.sender` and `tx.origin` to their original values
    function stopImpersonate() internal {
        vulcan.hevm.stopPrank();
    }

    /// @dev sets the balance of the address `addr` to `bal`
    /// @param self the address that will be updated
    /// @param bal the new balance
    /// @return the address that was updated
    function setBalance(address self, uint256 bal) internal returns(address) {
        vulcan.hevm.deal(self, bal);
        return self;
    }

    function setCode(address self, bytes memory code) internal returns(address) {
        vulcan.hevm.etch(self, code);
        return self;
    }
}
