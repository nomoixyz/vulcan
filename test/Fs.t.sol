pragma solidity >=0.8.13 <0.9.0;

import {Test, expect, console, fs, FsMetadata, commands} from "../src/test.sol";

contract FsTest is Test {
    string constant HELLO_WORLD = "./test/fixtures/fs/read/hello_world.txt";
    string constant TEXT_TEST_FILE = "./test/fixtures/fs/write/test.txt";
    string constant BINARY_TEST_FILE = "./test/fixtures/fs/write/test_binary.txt";

    function testItCanReadAFile() external {
        string memory output = fs.readFile(HELLO_WORLD);

        expect(output).toEqual("Hello, World!\n");
    }

    function testItCanReadAFileAsBinary() external {
        bytes memory output = fs.readFileBinary(HELLO_WORLD);

        expect(output).toEqual(bytes("Hello, World!\n"));
    }

    function testItCanWriteAFile() external {
        string memory content = "Writing from a test";

        fs.writeFile(TEXT_TEST_FILE, content);

        expect(fs.readFile(TEXT_TEST_FILE)).toEqual(content);
    }

    function testItCanWriteAFileAsBinary() external {
        bytes memory content = bytes("Writing from a test using bytes");

        fs.writeFileBinary(BINARY_TEST_FILE, content);

        expect(fs.readFileBinary(BINARY_TEST_FILE)).toEqual(content);
    }

    function testItCanRemoveFiles() external {
        string memory path = "./test/fixtures/fs/write/temp.txt";

        fs.writeFile(path, string("Should be removed"));

        fs.removeFile(path);

        expect(fs.fileExists(path)).toBeFalse();
    }

    function testItCanCopyAFile() external {
        string memory path = "./test/fixtures/fs/write/hello_world_copy.txt";

        fs.copyFile(HELLO_WORLD, path);

        expect(fs.readFile(path)).toEqual("Hello, World!\n");

        fs.removeFile(path);
    }

    function testItCanMoveAfile() external {
        string memory path = "./test/fixtures/fs/write/hello_world.txt";
        string memory newPath = "./test/fixtures/fs/write/new_hello_world.txt";

        fs.copyFile(HELLO_WORLD, path);
        fs.moveFile(path, newPath);

        expect(fs.readFile(newPath)).toEqual("Hello, World!\n");

        expect(fs.fileExists(path)).toBeFalse();

        fs.removeFile(newPath);
    }

    function testItCanReadLines() external {
        string memory content = "Lorem\nipsum\ndolor\nsit\n";
        string memory path = "./test/fixtures/fs/write/test_read_lines.txt";

        fs.writeFile(path, content);

        expect(fs.readLine(path)).toEqual("Lorem");
        expect(fs.readLine(path)).toEqual("ipsum");
        expect(fs.readLine(path)).toEqual("dolor");
        expect(fs.readLine(path)).toEqual("sit");

        fs.removeFile(path);
    }

    function testItCanWriteLines() external {
        string memory content = "Lorem\nipsum\ndolor\nsit\n";
        string memory path = "./test/fixtures/fs/write/test_write_lines.txt";

        fs.writeFile(path, content);

        fs.writeLine(path, string("amet"));

        expect(fs.readLine(path)).toEqual("Lorem");
        expect(fs.readLine(path)).toEqual("ipsum");
        expect(fs.readLine(path)).toEqual("dolor");
        expect(fs.readLine(path)).toEqual("sit");
        expect(fs.readLine(path)).toEqual("amet");

        fs.removeFile(path);
    }

    function testItCanGetMetadata() external {
        string memory dirPath = "./test/fixtures/fs/read";
        string memory filePath = HELLO_WORLD;

        FsMetadata memory dirMetadata = fs.metadata(dirPath);
        expect(dirMetadata.isDir).toBeTrue();

        FsMetadata memory fileMetadata = fs.metadata(filePath);
        expect(fileMetadata.isDir).toBeFalse();
    }
}
