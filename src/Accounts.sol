// SPDX-License-Identifier: MIT
pragma solidity >=0.8.13 <0.9.0;

import {stdStorage, StdStorage} from "forge-std/StdStorage.sol";

import "./Vulcan.sol";

library accountsSafe {
    /// @dev Reads the storage at the specified `slot` for the given `who` address and returns the content.
    /// @param who The address whose storage will be read.
    /// @param slot The position of the storage slot to read.
    /// @return The contents of the specified storage slot as a bytes32 value.
    function readStorage(address who, bytes32 slot) internal view returns (bytes32) {
        return vulcan.hevm.load(who, slot);
    }

    /// @dev Signs the specified `digest` using the provided `privKey` and returns the signature in the form of `(v, r, s)`.
    /// @param privKey The private key to use for signing the digest.
    /// @param digest The message digest to sign.
    /// @return A tuple containing the signature parameters `(v, r, s)` as a `uint8`, `bytes32`, and `bytes32`, respectively.
    function sign(uint256 privKey, bytes32 digest) internal pure returns (uint8, bytes32, bytes32) {
        return vulcan.hevm.sign(privKey, digest);
    }

    /// @dev Derives the Ethereum address corresponding to the provided `privKey`.
    /// @param privKey The private key to use for deriving the Ethereum address.
    /// @return The Ethereum address derived from the provided private key.
    function derive(uint256 privKey) internal pure returns (address) {
        return vulcan.hevm.addr(privKey);
    }

    /// @dev Derives the private key corresponding to the specified `mnemonicOrPath` and `index`.
    /// @param mnemonicOrPath The mnemonic or derivation path to use for deriving the private key.
    /// @param index The index of the derived private key to retrieve.
    /// @return The private key derived from the specified mnemonic and index as a `uint256` value.
    function deriveKey(string memory mnemonicOrPath, uint32 index) internal pure returns (uint256) {
        return vulcan.hevm.deriveKey(mnemonicOrPath, index);
    }

    /// @dev Derives the private key corresponding to the specified `mnemonicOrPath`, `derivationPath`, and `index`.
    /// @param mnemonicOrPath The mnemonic or derivation path to use for deriving the master key.
    /// @param derivationPath The specific derivation path to use for deriving the private key (optional).
    /// @param index The index of the derived private key to retrieve.
    /// @return The private key derived from the specified mnemonic, derivation path, and index as a `uint256` value.
    function deriveKey(string memory mnemonicOrPath, string memory derivationPath, uint32 index)
        internal
        pure
        returns (uint256)
    {
        return vulcan.hevm.deriveKey(mnemonicOrPath, derivationPath, index);
    }

    /// @dev Adds the specified `privKey` to the local forge wallet.
    /// @param privKey The private key to add to the local forge wallet.
    /// @return The Ethereum address corresponding to the added private key.
    function rememberKey(uint256 privKey) internal returns (address) {
        return vulcan.hevm.rememberKey(privKey);
    }

    /// @dev Returns the current `nonce` of the specified `who` address.
    /// @param who The address for which to obtain the current `nonce`.
    /// @return The current `nonce` of the specified address as a `uint64` value.
    function getNonce(address who) internal view returns (uint64) {
        return vulcan.hevm.getNonce(who);
    }

    /// @dev Starts recording all storage reads and writes for later analysis.
    function recordStorage() internal {
        vulcan.hevm.record();
    }

    /// @dev Obtains an array of slots that have been read and written for the specified address `who`.
    /// @param who The address for which to obtain the storage accesses.
    /// @return reads An array of storage slots that have been read.
    /// @return writes An array of storage slots that have been written.
    function getStorageAccesses(address who) internal returns (bytes32[] memory reads, bytes32[] memory writes) {
        return vulcan.hevm.accesses(who);
    }

    /// @dev Adds a label to the specified address `who` for identification purposes in debug traces.
    /// @param who The address to label.
    /// @param lbl The label to apply to the address.
    /// @return The same address that was passed as input.
    function label(address who, string memory lbl) internal returns (address) {
        vulcan.hevm.label(who, lbl);
        return who;
    }

    /// @dev Creates an address using the hash of the specified `name` as the private key and adds a label to the address.
    /// @param name The name to use as the basis for the address.
    /// @return The newly created address.
    function create(string memory name) internal returns (address) {
        return create(name, name);
    }

    /// @dev Creates an address using the hash of the specified `name` as the private key and adds a label to the address.
    /// @param name The name to use as the basis for the address.
    /// @param lbl The label to apply to the address.
    /// @return The newly created address.
    function create(string memory name, string memory lbl) internal returns (address) {
        address addr = derive(uint256(keccak256(abi.encodePacked(name))));

        return label(addr, lbl);
    }
}

library accounts {
    using stdStorage for StdStorage;

    function stdStore() internal pure returns (StdStorage storage s) {
        bytes32 slot = keccak256("vulcan.accounts.stdStore");

        assembly {
            s.slot := slot
        }
    }

    function readStorage(address who, bytes32 slot) internal view returns (bytes32) {
        return accountsSafe.readStorage(who, slot);
    }

    function sign(uint256 privKey, bytes32 digest) internal pure returns (uint8, bytes32, bytes32) {
        return accountsSafe.sign(privKey, digest);
    }

    function derive(uint256 privKey) internal pure returns (address) {
        return accountsSafe.derive(privKey);
    }

    function deriveKey(string memory mnemonicOrPath, uint32 index) internal pure returns (uint256) {
        return accountsSafe.deriveKey(mnemonicOrPath, index);
    }

    function deriveKey(string memory mnemonicOrPath, string memory derivationPath, uint32 index)
        internal
        pure
        returns (uint256)
    {
        return accountsSafe.deriveKey(mnemonicOrPath, derivationPath, index);
    }

    function rememberKey(uint256 privKey) internal returns (address) {
        return accountsSafe.rememberKey(privKey);
    }

    function getNonce(address who) internal view returns (uint64) {
        return accountsSafe.getNonce(who);
    }

    function recordStorage() internal {
        return accountsSafe.recordStorage();
    }

    function getStorageAccesses(address who) internal returns (bytes32[] memory reads, bytes32[] memory writes) {
        return accountsSafe.getStorageAccesses(who);
    }

    function label(address who, string memory lbl) internal returns (address) {
        return accountsSafe.label(who, lbl);
    }

    function create(string memory name) internal returns (address) {
        return accountsSafe.create(name);
    }

    function create(string memory name, string memory lbl) internal returns (address) {
        return accountsSafe.create(name, lbl);
    }

    /// @dev Sets the specified `slot` in the storage of the given `self` address to the provided `value`.
    /// @param self The address to modify the storage of.
    /// @param slot The storage slot to set.
    /// @param value The value to set the storage slot to.
    /// @return The address that was modified.
    function setStorage(address self, bytes32 slot, bytes32 value) internal returns (address) {
        vulcan.hevm.store(self, slot, value);
        return self;
    }

    /// @dev Sets the nonce of the given `self` address to the provided value `n`.
    /// @param self The address to set the nonce for.
    /// @param n The value to set the nonce to.
    /// @return The updated address with the modified nonce.
    function setNonce(address self, uint64 n) internal returns (address) {
        vulcan.hevm.setNonce(self, n);
        return self;
    }

    /// @dev Sets the `msg.sender` of the next call to `self`.
    /// @param self The address to impersonate.
    /// @return The address that was impersonated.
    function impersonateOnce(address self) internal returns (address) {
        stopImpersonate();
        vulcan.hevm.prank(self);
        return self;
    }

    /// @notice Sets the `msg.sender` of all subsequent calls to `self` until `stopImpersonate` is called
    /// @param self The address to impersonate.
    /// @return The address being impersonated.
    function impersonate(address self) internal returns (address) {
        stopImpersonate();
        vulcan.hevm.startPrank(self);
        return self;
    }

    /// @dev Sets the `msg.sender` of the next call to `self` and the `tx.origin`
    /// to `origin`.
    /// @param self The address to impersonate.
    /// @param origin The new `tx.origin`.
    /// @return The address that was impersonated.
    function impersonateOnce(address self, address origin) internal returns (address) {
        stopImpersonate();
        vulcan.hevm.prank(self, origin);
        return self;
    }

    /// @dev Sets the `msg.sender` and `tx.origin` of all the subsequent calls to `self` and `origin`
    /// respectively until `stopImpersonate` is called.
    /// @param self The address to impersonate.
    /// @param origin The new value for `tx.origin`.
    /// @return The address being impersonated.
    function impersonate(address self, address origin) internal returns (address) {
        stopImpersonate();
        vulcan.hevm.startPrank(self, origin);
        return self;
    }

    /// @notice Resets the values of `msg.sender` and `tx.origin` to the original values.
    function stopImpersonate() internal {
        vulcan.hevm.stopPrank();
    }

    /// @dev Sets the balance of an address and returns the address that was modified.
    /// @param self The address to set the balance of.
    /// @param bal The new balance to set.
    /// @return The address that was modified.
    function setBalance(address self, uint256 bal) internal returns (address) {
        vulcan.hevm.deal(self, bal);
        return self;
    }

    /// @dev Mints an amount of tokens to an address. This operation modifies the total supply of the token.
    /// @dev self The address that will own the tokens.
    /// @dev token The token to mint.
    /// @dev amount The amount of tokens to mint.
    /// @return The adress that owns the minted tokens.
    function mintToken(address self, address token, uint256 amount) internal returns (address) {
        (, bytes memory balData) = token.call(abi.encodeWithSelector(0x70a08231, self));

        uint256 prevBal = abi.decode(balData, (uint256));

        setTokenBalance(self, token, prevBal + amount);

        (, bytes memory totSupData) = token.call(abi.encodeWithSelector(0x18160ddd));
        uint256 totSup = abi.decode(totSupData, (uint256));

        setTotalSupply(token, totSup + amount);

        return self;
    }

    /// @dev Burns an amount of tokens from an address.This operation modifies the total supply of the token.
    /// @dev self The address that owns the tokens.
    /// @dev token The token to burn.
    /// @dev amount The amount of tokens to burn.
    /// @return The adress that owned the burned tokens.
    function burnToken(address self, address token, uint256 amount) internal returns (address) {
        (, bytes memory balData) = token.call(abi.encodeWithSelector(0x70a08231, self));

        uint256 prevBal = abi.decode(balData, (uint256));

        setTokenBalance(self, token, prevBal - amount);

        (, bytes memory totSupData) = token.call(abi.encodeWithSelector(0x18160ddd));
        uint256 totSup = abi.decode(totSupData, (uint256));

        setTotalSupply(token, totSup - amount);

        return self;
    }

    /// @dev Sets the token balance of an address.
    /// @param self The address to set the balance of.
    /// @param token The token that will be given to `self`.
    /// @param bal The new token balance of `self`.
    /// @return The address that was modified.
    function setTokenBalance(address self, address token, uint256 bal) internal returns (address) {
        stdStore().target(token).sig(0x70a08231).with_key(self).checked_write(bal);

        return self;
    }

    /// @dev Sets the token total supply of a token.
    /// @param token The token that will be modified.
    /// @param totalSupply The new total supply of token.
    /// @return The token address.
    function setTotalSupply(address token, uint256 totalSupply) private returns (address) {
        stdStore().target(token).sig(0x18160ddd).checked_write(totalSupply);

        return token;
    }

    /// @dev Sets the code of an address.
    /// @param self The address to set the code for.
    /// @param code The new code to set for the address.
    /// @return The address that was modified.
    function setCode(address self, bytes memory code) internal returns (address) {
        vulcan.hevm.etch(self, code);
        return self;
    }
}
