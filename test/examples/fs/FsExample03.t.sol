// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test} from "vulcan/test.sol";
import {expect} from "vulcan/test/Expect.sol";
import {fs, FsMetadataResult} from "vulcan/test/Fs.sol";
import {BoolResult} from "vulcan/test/Result.sol";

/// @title Other operations
/// @dev Obtain metadata and check if file exists
contract FsExample is Test {
    // These files are available only on the context of vulcan
    // You will need to provide your own files and edit the read permissions accordingly
    string constant READ_EXAMPLE = "./test/fixtures/fs/read/hello_world.txt";
    string constant NOT_FOUND_EXAMPLE = "./test/fixtures/fs/read/lkjjsadflkjasdf.txt";

    function test() external {
        FsMetadataResult metadataResult = fs.metadata(READ_EXAMPLE);
        expect(metadataResult.isOk()).toBeTrue();
        expect(metadataResult.unwrap().isDir).toBeFalse();

        BoolResult existsResult = fs.fileExists(READ_EXAMPLE);
        expect(existsResult.isOk()).toBeTrue();
        expect(existsResult.unwrap()).toBeTrue();

        BoolResult notFoundResult = fs.fileExists(NOT_FOUND_EXAMPLE);
        expect(notFoundResult.isOk()).toBeTrue();
        expect(notFoundResult.unwrap()).toBeFalse();
    }
}
