// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, expect, fs, BytesResult, StringResult} from "vulcan/test.sol";

/// @title Reading files
/// @dev Read files as string or bytes
contract FsExample is Test {
    // These files are available only on the context of vulcan
    // You will need to provide your own files and edit the read permissions accordingly
    string constant HELLO_WORLD = "./test/fixtures/fs/read/hello_world.txt";
    string constant BINARY_TEST_FILE = "./test/fixtures/fs/write/test_binary.txt";

    function test() external {
        StringResult stringResult = fs.readFile(HELLO_WORLD);
        BytesResult bytesResult = fs.readFileBinary(HELLO_WORLD);

        expect(stringResult.isOk()).toBeTrue();
        expect(bytesResult.isOk()).toBeTrue();

        expect(stringResult.unwrap()).toEqual("Hello, World!\n");
        expect(bytesResult.toValue()).toEqual(bytes("Hello, World!\n"));
    }
}
