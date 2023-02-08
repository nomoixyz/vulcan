// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.13 <0.9.0;

import "./Vulcan.sol";

type Env is bytes32;

library EnvLib {
    /// @dev sets the value of the  environment variable with name `name` to `value`
    /// @param name the name of the environment variable
    /// @param value the new value of the environment variable
    function setEnv(Env, string memory name, string memory value) internal {
        vulcan.hevm.setEnv(name, value);
    }

    /// @dev Reads the environment variable with name `name` and returns the value as `bool`
    /// @param name the name of the environment variable to read
    /// @return the value of the environment variable as `bool`
    function envBool(Env, string memory name) internal view returns (bool) {
        return vulcan.hevm.envBool(name);
    }

    /// @dev Reads the environment variable with name `name` and returns the value as `uint256`
    /// @param name the name of the environment variable to read
    /// @return the value of the environment variable as `uint256`
    function envUint(Env, string memory name) internal view returns (uint256) {
        return vulcan.hevm.envUint(name);
    }

    /// @dev Reads the environment variable with name `name` and returns the value as `int256`
    /// @param name the name of the environment variable to read
    /// @return the value of the environment variable as `int256`
    function envInt(Env, string memory name) internal view returns (int256) {
        return vulcan.hevm.envInt(name);
    }

    /// @dev Reads the environment variable with name `name` and returns the value as `address`
    /// @param name the name of the environment variable to read
    /// @return the value of the environment variable as `address`
    function envAddress(Env, string memory name) internal view returns (address) {
        return vulcan.hevm.envAddress(name);
    }

    /// @dev Reads the environment variable with name `name` and returns the value as `bytes32`
    /// @param name the name of the environment variable to read
    /// @return the value of the environment variable as `bytes32`
    function envBytes32(Env, string memory name) internal view returns (bytes32) {
        return vulcan.hevm.envBytes32(name);
    }

    /// @dev Reads the environment variable with name `name` and returns the value as `string`
    /// @param name the name of the environment variable to read
    /// @return the value of the environment variable as `string`
    function envString(Env, string memory name) internal view returns (string memory) {
        return vulcan.hevm.envString(name);
    }

    /// @dev Reads the environment variable with name `name` and returns the value as `bytes`
    /// @param name the name of the environment variable to read
    /// @return the value of the environment variable as `bytes`
    function envBytes(Env, string memory name) internal view returns (bytes memory) {
        return vulcan.hevm.envBytes(name);
    }

    /// @dev Reads the environment variable with name `name` and returns the value as `bool[]`
    /// @param name the name of the environment variable to read
    /// @param delim the delimiter used to split the values 
    /// @return the value of the environment variable as `bool[]`
    function envBool(Env, string memory name, string memory delim) internal view returns (bool[] memory) {
        return vulcan.hevm.envBool(name, delim);
    }

    /// @dev Reads the environment variable with name `name` and returns the value as `uint256[]`
    /// @param name the name of the environment variable to read
    /// @param delim the delimiter used to split the values 
    /// @return the value of the environment variable as `uint256[]`
    function envUint(Env, string memory name, string memory delim) internal view returns (uint256[] memory) {
        return vulcan.hevm.envUint(name, delim);
    }

    /// @dev Reads the environment variable with name `name` and returns the value as `int256[]`
    /// @param name the name of the environment variable to read
    /// @param delim the delimiter used to split the values 
    /// @return the value of the environment variable as `int256[]`
    function envInt(Env, string memory name, string memory delim) internal view returns (int256[] memory) {
        return vulcan.hevm.envInt(name, delim);
    }

    /// @dev Reads the environment variable with name `name` and returns the value as `address[]`
    /// @param name the name of the environment variable to read
    /// @param delim the delimiter used to split the values 
    /// @return the value of the environment variable as `address[]`
    function envAddress(Env, string memory name, string memory delim) internal view returns (address[] memory) {
        return vulcan.hevm.envAddress(name, delim);
    }

    /// @dev Reads the environment variable with name `name` and returns the value as `bytes32[]`
    /// @param name the name of the environment variable to read
    /// @param delim the delimiter used to split the values 
    /// @return the value of the environment variable as `bytes32[]`
    function envBytes32(Env, string memory name, string memory delim) internal view returns (bytes32[] memory) {
        return vulcan.hevm.envBytes32(name, delim);
    }

    /// @dev Reads the environment variable with name `name` and returns the value as `string[]`
    /// @param name the name of the environment variable to read
    /// @param delim the delimiter used to split the values 
    /// @return the value of the environment variable as `string[]`
    function envString(Env, string memory name, string memory delim) internal view returns (string[] memory) {
        return vulcan.hevm.envString(name, delim);
    }

    /// @dev Reads the environment variable with name `name` and returns the value as `bytes[]`
    /// @param name the name of the environment variable to read
    /// @param delim the delimiter used to split the values 
    /// @return the value of the environment variable as `bytes[]`
    function envBytes(Env, string memory name, string memory delim) internal view returns (bytes[] memory) {
        return vulcan.hevm.envBytes(name, delim);
    }

    function envOr(string memory name, bool defaultValue) internal returns (bool value) {
        return vulcan.hevm.envOr(name, defaultValue);
    }
    function envOr(string memory name, uint256 defaultValue) external returns (uint256 value) {
        return vulcan.hevm.envOr(name, defaultValue);
    }
    function envOr(string memory name, int256 defaultValue) external returns (int256 value) {
        return vulcan.hevm.envOr(name, defaultValue);
    }
    function envOr(string memory name, address defaultValue) external returns (address value) {
        return vulcan.hevm.envOr(name, defaultValue);
    }
    function envOr(string memory name, bytes32 defaultValue) external returns (bytes32 value) {
        return vulcan.hevm.envOr(name, defaultValue);
    }
    function envOr(string memory name, string memory defaultValue) external returns (string memory value) {
        return vulcan.hevm.envOr(name, defaultValue);
    }
    function envOr(string memory name, bytes memory defaultValue) external returns (bytes memory value) {
        return vulcan.hevm.envOr(name, defaultValue);
    }
    // Read environment variables as arrays with default value
    function envOr(string memory name, string memory delim, bool[] memory defaultValue)
        external
        returns (bool[] memory value)
    {
        return vulcan.hevm.envOr(name, delim, defaultValue);
    }

    function envOr(string memory name, string memory delim, uint256[] memory defaultValue)
        external
        returns (uint256[] memory value)
    {
        return vulcan.hevm.envOr(name, delim, defaultValue);
    }
    function envOr(string memory name, string memory delim, int256[] memory defaultValue)
        external
        returns (int256[] memory value)
    {
        return vulcan.hevm.envOr(name, delim, defaultValue);
    }
    function envOr(string memory name, string memory delim, address[] memory defaultValue)
        external
        returns (address[] memory value)
    {
        return vulcan.hevm.envOr(name, delim, defaultValue);
    }
    function envOr(string memory name, string memory delim, bytes32[] memory defaultValue)
        external
        returns (bytes32[] memory value)
    {
        return vulcan.hevm.envOr(name, delim, defaultValue);
    }
    function envOr(string memory name, string memory delim, string[] memory defaultValue)
        external
        returns (string[] memory value)
    {
        return vulcan.hevm.envOr(name, delim, defaultValue);
    }
    function envOr(string memory name, string memory delim, bytes[] memory defaultValue)
        external
        returns (bytes[] memory value)
    {
        return vulcan.hevm.envOr(name, delim, defaultValue);
    }

}

Env constant env = Env.wrap(0);

using EnvLib for Env global;