## Examples
### Reading files

Read files as string or bytes

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, expect, fs, BytesResult, StringResult} from "vulcan/test.sol";

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

```

### Writing files

Write files as strings or bytes

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, expect, fs, BytesResult, StringResult, EmptyResult} from "vulcan/test.sol";

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

```

### Other operations

Obtain metadata and check if file exists

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, expect, fs, BoolResult, FsMetadataResult} from "vulcan/test.sol";

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

```

