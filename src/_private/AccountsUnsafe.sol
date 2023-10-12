// SPDX-License-Identifier: MIT
pragma solidity >=0.8.13 <0.9.0;

import {stdStorage, StdStorage} from "forge-std/StdStorage.sol";

import {strings} from "./Strings.sol";
import "./Vulcan.sol";
import {formatError} from "../_utils/formatError.sol";
import {accountsSafe as _accountsSafe} from "./AccountsSafe.sol";

library accountsUnsafe {
    using stdStorage for StdStorage;

    function stdStore() internal pure returns (StdStorage storage s) {
        bytes32 slot = keccak256("vulcan.accounts.stdStore");

        assembly {
            s.slot := slot
        }
    }

    function readStorage(address who, bytes32 slot) internal view returns (bytes32) {
        return _accountsSafe.readStorage(who, slot);
    }

    function sign(uint256 privKey, bytes32 digest) internal pure returns (uint8, bytes32, bytes32) {
        return _accountsSafe.sign(privKey, digest);
    }

    function derive(uint256 privKey) internal pure returns (address) {
        return _accountsSafe.derive(privKey);
    }

    function deriveKey(string memory mnemonicOrPath, uint32 index) internal pure returns (uint256) {
        return _accountsSafe.deriveKey(mnemonicOrPath, index);
    }

    function deriveKey(string memory mnemonicOrPath, string memory derivationPath, uint32 index)
        internal
        pure
        returns (uint256)
    {
        return _accountsSafe.deriveKey(mnemonicOrPath, derivationPath, index);
    }

    function rememberKey(uint256 privKey) internal returns (address) {
        return _accountsSafe.rememberKey(privKey);
    }

    function getNonce(address who) internal view returns (uint64) {
        return _accountsSafe.getNonce(who);
    }

    function recordStorage() internal {
        return _accountsSafe.recordStorage();
    }

    function getStorageAccesses(address who) internal returns (bytes32[] memory reads, bytes32[] memory writes) {
        return _accountsSafe.getStorageAccesses(who);
    }

    function label(address who, string memory lbl) internal returns (address) {
        return _accountsSafe.label(who, lbl);
    }

    function create() internal returns (address) {
        return _accountsSafe.create();
    }

    function create(string memory name) internal returns (address) {
        return _accountsSafe.create(name);
    }

    function create(string memory name, string memory lbl) internal returns (address) {
        return _accountsSafe.create(name, lbl);
    }

    /// @dev Calculates the deployment address of `who` with nonce `nonce`.
    /// @param who The deployer address.
    /// @param nonce The deployer nonce.
    function getDeploymentAddress(address who, uint64 nonce) internal pure returns (address) {
        return _accountsSafe.getDeploymentAddress(who, nonce);
    }

    /// @dev Calculates the deployment address of `who` with the current nonce.
    /// @param who The deployer address.
    function getDeploymentAddress(address who) internal view returns (address) {
        return _accountsSafe.getDeploymentAddress(who);
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

    /// @dev Sets the nonce of the given `self` address to the provided value `n`. It will revert if
    // the new nonce is lower than the current address nonce.
    /// @param self The address to set the nonce for.
    /// @param n The value to set the nonce to.
    /// @return The updated address with the modified nonce.
    function setNonce(address self, uint64 n) internal returns (address) {
        vulcan.hevm.setNonce(self, n);
        return self;
    }

    /// @dev Sets the nonce of the given `self` address to the arbitrary provided value `n`.
    /// @param self The address to set the nonce for.
    /// @param n The value to set the nonce to.
    /// @return The updated address with the modified nonce.
    function setNonceUnsafe(address self, uint64 n) internal returns (address) {
        vulcan.hevm.setNonceUnsafe(self, n);
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
        try vulcan.hevm.stopPrank() {} catch (bytes memory) {}
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
    /// @return The address that owns the minted tokens.
    function mintToken(address self, address token, uint256 amount) internal returns (address) {
        (, bytes memory balData) = token.call(abi.encodeWithSelector(0x70a08231, self));

        uint256 prevBal = abi.decode(balData, (uint256));

        setTokenBalance(self, token, prevBal + amount);

        (, bytes memory totSupData) = token.call(abi.encodeWithSelector(0x18160ddd));
        uint256 totSup = abi.decode(totSupData, (uint256));

        setTotalSupply(token, totSup + amount);

        return self;
    }

    /// @dev Burns an amount of tokens from an address. This operation modifies the total supply of the token.
    /// @dev self The address that owns the tokens.
    /// @dev token The token to burn.
    /// @dev amount The amount of tokens to burn.
    /// @return The address that owned the burned tokens.
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

    /// @dev Sets the total supply of a token.
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

    /// @dev Generates an array of addresses with a specific length.
    /// @param length The amount of addresses to generate.
    function createMany(uint256 length) internal returns (address[] memory) {
        return _accountsSafe.createMany(length);
    }

    /// @dev Generates an array of addresses with a specific length and a prefix as label.
    /// The label for each address will be `{prefix}_{i}`.
    /// @param length The amount of addresses to generate.
    /// @param prefix The prefix of the label for each address.
    function createMany(uint256 length, string memory prefix) internal returns (address[] memory) {
        return _accountsSafe.createMany(length, prefix);
    }
}
