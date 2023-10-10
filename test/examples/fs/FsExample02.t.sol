// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, expect, fs, BytesResult, StringResult, EmptyResult} from "vulcan/test.sol";

/// @title Writing files
/// @dev Write files as strings or bytes
contract FsExample is Test {
    // These files are available only on the context of vulcan
    // You will need to provide your own files and edit the read permissions accordingly
    string constant TEXT_TEST_FILE = "./test/fixtures/fs/write/example.txt";

    function test() external {
        EmptyResult writeStringResult = fs.writeFile(TEXT_TEST_FILE, "This is a test");

        expect(writeStringResult.isOk()).toBeTrue();

        StringResult readStringResult = fs.readFile(TEXT_TEST_FILE);

        expect(readStringResult.unwrap()).toEqual("This is a test");

        EmptyResult writeBytesResult = fs.writeFileBinary(TEXT_TEST_FILE, bytes("This is a test in binary"));

        expect(writeBytesResult.isOk()).toBeTrue();

        BytesResult readBytesResult = fs.readFileBinary(TEXT_TEST_FILE);

        expect(readBytesResult.unwrap()).toEqual(bytes("This is a test in binary"));
    }
}
