// SPDX-License-Identifier: MIT
pragma solidity >=0.8.13 <0.9.0;

import {Test} from "src/test.sol";
import {expect} from "src/test/Expect.sol";
import {fs, FsErrors, FsMetadata, FsMetadataResult} from "src/test/Fs.sol";
import {commands} from "src/test/Commands.sol";
import {Error} from "src/test/Error.sol";
import {StringResult, BoolResult, BytesResult, EmptyResult} from "src/test/Result.sol";

contract FsTest is Test {
    string constant HELLO_WORLD = "./test/fixtures/fs/read/hello_world.txt";
    string constant TEXT_TEST_FILE = "./test/fixtures/fs/write/test.txt";
    string constant BINARY_TEST_FILE = "./test/fixtures/fs/write/test_binary.txt";

    function testItCanReadAFile() external {
        StringResult output = fs.readFile(HELLO_WORLD);

        expect(output.unwrap()).toEqual("Hello, World!\n");
    }

    function testItCanCheckIfAFileExists() external {
        BoolResult shouldExists = fs.fileExists("./test/modules/Fs.t.sol");
        BoolResult shouldNotExist = fs.fileExists("./test/modules/Fsssss.t.sol");
        BoolResult shouldBeError = fs.fileExists("/tmp/klsajdflksjadfrlkjasdf");

        expect(shouldExists.isError()).toBeFalse();
        expect(shouldNotExist.isError()).toBeFalse();
        expect(shouldBeError.isError()).toBeTrue();

        expect(shouldExists.toValue()).toBeTrue();
        expect(shouldNotExist.toValue()).toBeFalse();

        Error err = shouldBeError.toError();
        (, string memory message,) = err.decode();

        expect(message).toEqual(
            "Not enough permissions to access file: \"The path \"/tmp/klsajdflksjadfrlkjasdf\" is not allowed to be accessed for read operations.\""
        );
    }

    function testItCanReadAFileAsBinary() external {
        BytesResult result = fs.readFileBinary(HELLO_WORLD);

        expect(result.isOk()).toBeTrue();

        expect(result.toValue()).toEqual(bytes("Hello, World!\n"));
    }

    function testItCanWriteAFile() external {
        string memory content = "Writing from a test";

        EmptyResult writeResult = fs.writeFile(TEXT_TEST_FILE, content);

        expect(writeResult.isOk()).toBeTrue();

        StringResult readResult = fs.readFile(TEXT_TEST_FILE);

        expect(readResult.isOk()).toBeTrue();

        expect(readResult.toValue()).toEqual(content);
    }

    function testItCanWriteAFileAsBinary() external {
        bytes memory content = bytes("Writing from a test using bytes");

        EmptyResult writeResult = fs.writeFileBinary(BINARY_TEST_FILE, content);

        expect(writeResult.isOk()).toBeTrue();

        BytesResult readResult = fs.readFileBinary(BINARY_TEST_FILE);

        expect(readResult.isOk()).toBeTrue();

        expect(readResult.toValue()).toEqual(content);
    }

    function testItCanRemoveFiles() external {
        string memory path = "./test/fixtures/fs/write/temp.txt";

        EmptyResult writeResult = fs.writeFile(path, string("Should be removed"));

        expect(writeResult.isOk()).toBeTrue();

        EmptyResult removeResult = fs.removeFile(path);

        expect(removeResult.isOk()).toBeTrue();

        expect(fs.fileExists(path).toValue()).toBeFalse();
    }

    function testItCanCopyAFile() external {
        string memory path = "./test/fixtures/fs/write/hello_world_copy.txt";

        EmptyResult copyResult = fs.copyFile(HELLO_WORLD, path);

        expect(copyResult.isOk()).toBeTrue();

        expect(fs.readFile(path).toValue()).toEqual("Hello, World!\n");

        expect(fs.removeFile(path).isOk()).toBeTrue();
    }

    function testItCanMoveAfile() external {
        string memory path = "./test/fixtures/fs/write/hello_world.txt";
        string memory newPath = "./test/fixtures/fs/write/new_hello_world.txt";

        expect(fs.copyFile(HELLO_WORLD, path).isOk()).toBeTrue();
        expect(fs.moveFile(path, newPath).isOk()).toBeTrue();

        expect(fs.readFile(newPath).toValue()).toEqual("Hello, World!\n");

        expect(fs.fileExists(path).toValue()).toBeFalse();

        expect(fs.removeFile(newPath).isOk()).toBeTrue();
    }

    function testItCanReadLines() external {
        string memory content = "Lorem\nipsum\ndolor\nsit\n";
        string memory path = "./test/fixtures/fs/write/test_read_lines.txt";

        expect(fs.writeFile(path, content).isOk()).toBeTrue();

        expect(fs.readLine(path).toValue()).toEqual("Lorem");
        expect(fs.readLine(path).toValue()).toEqual("ipsum");
        expect(fs.readLine(path).toValue()).toEqual("dolor");
        expect(fs.readLine(path).toValue()).toEqual("sit");

        expect(fs.removeFile(path).isOk()).toBeTrue();
    }

    function testItCanWriteLines() external {
        string memory content = "Lorem\nipsum\ndolor\nsit\n";
        string memory path = "./test/fixtures/fs/write/test_write_lines.txt";

        expect(fs.writeFile(path, content).isOk()).toBeTrue();

        expect(fs.writeLine(path, string("amet")).isOk()).toBeTrue();

        expect(fs.readLine(path).toValue()).toEqual("Lorem");
        expect(fs.readLine(path).toValue()).toEqual("ipsum");
        expect(fs.readLine(path).toValue()).toEqual("dolor");
        expect(fs.readLine(path).toValue()).toEqual("sit");
        expect(fs.readLine(path).toValue()).toEqual("amet");

        expect(fs.removeFile(path).isOk()).toBeTrue();
    }

    function testItCanGetMetadata() external {
        string memory dirPath = "./test/fixtures/fs/read";
        string memory filePath = HELLO_WORLD;

        FsMetadataResult dirMetadataResult = fs.metadata(dirPath);

        expect(dirMetadataResult.isOk()).toBeTrue();
        expect(dirMetadataResult.toValue().isDir).toBeTrue();

        FsMetadataResult fileMetadataResult = fs.metadata(filePath);

        expect(fileMetadataResult.isOk()).toBeTrue();
        expect(fileMetadataResult.toValue().isDir).toBeFalse();
    }
}
