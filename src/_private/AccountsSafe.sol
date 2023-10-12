// SPDX-License-Identifier: MIT
pragma solidity >=0.8.13 <0.9.0;

import {stdStorage, StdStorage} from "forge-std/StdStorage.sol";

import {strings} from "./Strings.sol";
import "./Vulcan.sol";
import {formatError} from "../_utils/formatError.sol";

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

    /// @dev Creates an address without label.
    function create() internal returns (address) {
        uint256 id = _incrementId();
        return derive(uint256(keccak256(abi.encode(id))));
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

    /// @dev Calculates the deployment address of `who` with nonce `nonce`.
    /// @param who The deployer address.
    /// @param nonce The deployer nonce.
    function getDeploymentAddress(address who, uint64 nonce) internal pure returns (address) {
        bytes memory data;

        if (nonce == 0x00) {
            data = abi.encodePacked(bytes1(0xd6), bytes1(0x94), who, bytes1(0x80));
        } else if (nonce <= 0x7f) {
            data = abi.encodePacked(bytes1(0xd6), bytes1(0x94), who, uint8(nonce));
        } else if (nonce <= 0xff) {
            data = abi.encodePacked(bytes1(0xd7), bytes1(0x94), who, bytes1(0x81), uint8(nonce));
        } else if (nonce <= 0xffff) {
            data = abi.encodePacked(bytes1(0xd8), bytes1(0x94), who, bytes1(0x82), uint16(nonce));
        } else if (nonce <= 0xffffff) {
            data = abi.encodePacked(bytes1(0xd9), bytes1(0x94), who, bytes1(0x83), uint24(nonce));
        } else if (nonce <= 0xffffffff) {
            data = abi.encodePacked(bytes1(0xda), bytes1(0x94), who, bytes1(0x84), uint32(nonce));
        } else if (nonce <= 0xffffffffff) {
            data = abi.encodePacked(bytes1(0xdb), bytes1(0x94), who, bytes1(0x85), uint40(nonce));
        } else if (nonce <= 0xffffffffffff) {
            data = abi.encodePacked(bytes1(0xdc), bytes1(0x94), who, bytes1(0x86), uint48(nonce));
        } else if (nonce <= 0xffffffffffffff) {
            data = abi.encodePacked(bytes1(0xdd), bytes1(0x94), who, bytes1(0x87), uint56(nonce));
        } else if (nonce <= 0xffffffffffffffff) {
            data = abi.encodePacked(bytes1(0xde), bytes1(0x94), who, bytes1(0x88), uint64(nonce));
        }

        return address(uint160(uint256(keccak256(data))));
    }

    /// @dev Calculates the deployment address of `who` with the current nonce.
    /// @param who The deployer address.
    function getDeploymentAddress(address who) internal view returns (address) {
        return getDeploymentAddress(who, getNonce(who));
    }

    /// @dev Generates an array of addresses with a specific length.
    /// @param length The amount of addresses to generate.
    function createMany(uint256 length) internal returns (address[] memory) {
        require(length > 0, _formatError("createMany(uint256)", "Invalid length for addresses array"));

        address[] memory addresses = new address[](length);

        for (uint256 i = 0; i < length; i++) {
            addresses[i] = create();
        }

        return addresses;
    }

    /// @dev Generates an array of addresses with a specific length and a prefix as label.
    /// The label for each address will be `{prefix}_{i}`.
    /// @param length The amount of addresses to generate.
    /// @param prefix The prefix of the label for each address.
    function createMany(uint256 length, string memory prefix) internal returns (address[] memory) {
        require(length > 0, "accounts: invalid length for addresses array");

        address[] memory addresses = new address[](length);

        for (uint256 i = 0; i < length; i++) {
            addresses[i] = create(string.concat(prefix, "_", strings.toString(i)));
        }

        return addresses;
    }

    function _incrementId() private returns (uint256 count) {
        bytes32 slot = keccak256("vulcan.accounts.id.counter");

        assembly {
            count := sload(slot)
            sstore(slot, add(count, 1))
        }
    }

    function _formatError(string memory func, string memory message) private pure returns (string memory) {
        return formatError("accounts", func, message);
    }
}
