// SPDX-License-Identifier: MIT
pragma solidity >=0.8.13 <0.9.0;

import {console} from "./Console.sol";
import "./Events.sol";
import "./Any.sol";
import "./Vulcan.sol";
import "./Util.sol";

struct _BoolExpectation {
    bool actual;
    _BoolExpectationNot not;
}

struct _BoolExpectationNot {
    bool actual;
}

struct _UintExpectation {
    uint256 actual;
    _UintExpectationNot not;
}

struct _UintExpectationNot {
    uint256 actual;
}

struct _IntExpectation {
    int256 actual;
    _IntExpectationNot not;
}

struct _IntExpectationNot {
    int256 actual;
}

struct _AddressExpectation {
    address actual;
    _AddressExpectationNot not;
}

struct _AddressExpectationNot {
    address actual;
}

struct _Bytes32Expectation {
    bytes32 actual;
    _Bytes32ExpectationNot not;
}

struct _Bytes32ExpectationNot {
    bytes32 actual;
}

struct _BytesExpectation {
    bytes actual;
    _BytesExpectationNot not;
}

struct _BytesExpectationNot {
    bytes actual;
}

struct _StringExpectation {
    string actual;
    _StringExpectationNot not;
}

struct _StringExpectationNot {
    string actual;
}

struct _CallExpectation {
    Call call;
    _CallExpectationNot not;
}

struct _CallExpectationNot {
    Call call;
}

// This library provides a set of matchers to assert conditions over values.
// Many of these functions are based on forge-std StdAssertions https://github.com/foundry-rs/forge-std/blob/c2236853aadb8e2d9909bbecdc490099519b70a4/src/StdAssertions.sol#L7
// We tried to keep the same error messages and overall functionality, although some assertions are still missing.
// TODO: add support for arrays
library ExpectLib {
    using vulcan for *;
    using events for *;

    /* BOOL */

    function toEqual(_BoolExpectation memory self, bool expected) internal {
        if (self.actual != expected) {
            console.log("Error: a == b not satisfied [bool]");
            console.log("  Expected", expected);
            console.log("    Actual", self.actual);
            vulcan.fail();
        }
    }

    function toEqual(_BoolExpectationNot memory self, bool expected) internal {
        if (self.actual == expected) {
            console.log("Error: a != b not satisfied [bool]");
            console.log("  Value a", expected);
            console.log("  Value b", self.actual);
            vulcan.fail();
        }
    }

    function toBeTrue(_BoolExpectation memory self) internal {
        toEqual(self, true);
    }

    function toBeFalse(_BoolExpectation memory self) internal {
        toEqual(self, false);
    }

    /* ADDRESS */

    function toEqual(_AddressExpectation memory self, address expected) internal {
        if (self.actual != expected) {
            console.log("Error: a == b not satisfied [address]");
            console.log("  Expected", expected);
            console.log("    Actual", self.actual);
            vulcan.fail();
        }
    }

    function toEqual(_AddressExpectationNot memory self, address expected) internal {
        if (self.actual == expected) {
            console.log("Error: a != b not satisfied [address]");
            console.log("  Value a", expected);
            console.log("  Value b", self.actual);
            vulcan.fail();
        }
    }

    function toBeAContract(_AddressExpectation memory self) internal {
        if (self.actual.code.length == 0) {
            console.log("Error: a is not a contract [address]");
            console.log("  Value", self.actual);
            vulcan.fail();
        }
    }

    function toBeAContract(_AddressExpectationNot memory self) internal {
        if (self.actual.code.length == 0) {
            console.log("Error: a is a contract [address]");
            console.log("  Value", self.actual);
            vulcan.fail();
        }
    }

    /* BYTES32 */

    function toEqual(_Bytes32Expectation memory self, bytes32 expected) internal {
        if (self.actual != expected) {
            console.log("Error: a == b not satisfied [bytes32]");
            console.log("  Expected", expected);
            console.log("    Actual", self.actual);
            vulcan.fail();
        }
    }

    function toEqual(_Bytes32ExpectationNot memory self, bytes32 expected) internal {
        if (self.actual == expected) {
            console.log("Error: a != b not satisfied [bytes32]");
            console.log("  Value a", expected);
            console.log("  Value b", self.actual);
            vulcan.fail();
        }
    }

    function toBeTheHashOf(_Bytes32Expectation memory self, bytes memory data) internal {
        if (self.actual != keccak256(data)) {
            console.log("Error: a is not the hash of b [bytes32]");
            console.log("  Expected", keccak256(data));
            console.log("    Actual", self.actual);
            vulcan.fail();
        }
    }

    function toBeTheHashOf(_Bytes32ExpectationNot memory self, bytes memory data) internal {
        if (self.actual == keccak256(data)) {
            console.log("Error: a is the hash of b [bytes32]");
            console.log("  Value a", keccak256(data));
            console.log("  Value b", self.actual);
            vulcan.fail();
        }
    }

    /* BYTES */

    function toEqual(_BytesExpectation memory self, bytes memory expected) internal {
        if (keccak256(self.actual) != keccak256(expected)) {
            console.log("Error: a == b not satisfied [bytes]");
            console.log("  Expected", expected);
            console.log("    Actual", self.actual);
            vulcan.fail();
        }
    }

    function toEqual(_BytesExpectationNot memory self, bytes memory expected) internal {
        if (keccak256(self.actual) == keccak256(expected)) {
            console.log("Error: a != b not satisfied [bytes]");
            console.log("  Value", expected);
            console.log("  Value", self.actual);
            vulcan.fail();
        }
    }

    /* STRING */

    function toEqual(_StringExpectation memory self, string memory expected) internal {
        if (keccak256(abi.encodePacked(self.actual)) != keccak256(abi.encodePacked(expected))) {
            console.log("Error: a == b not satisfied [string]");
            console.log("  Expected", expected);
            console.log("    Actual", self.actual);
            vulcan.fail();
        }
    }

    function toEqual(_StringExpectationNot memory self, string memory expected) internal {
        if (keccak256(abi.encodePacked(self.actual)) == keccak256(abi.encodePacked(expected))) {
            console.log("Error: a != b not satisfied [string]");
            console.log("  Value a", expected);
            console.log("  Value b", self.actual);
            vulcan.fail();
        }
    }

    function toContain(_StringExpectation memory self, string memory contained) internal {
        bytes memory actual = bytes(self.actual);
        bytes memory expected = bytes(contained);

        if (actual.length >= expected.length) {
            for (uint256 i = 0; i < actual.length - expected.length + 1; i++) {
                bool found = true;

                for (uint256 j = 0; j < expected.length; j++) {
                    if (actual[i + j] != expected[j]) {
                        found = false;
                        break;
                    }
                }

                if (found) {
                    return;
                }
            }
        }

        console.log("Error: a does not contain b [string]");
        console.log("  Value a", self.actual);
        console.log("  Value b", contained);
        vulcan.fail();
    }

    function toContain(_StringExpectationNot memory self, string memory contained) internal {
        bytes memory actual = bytes(self.actual);
        bytes memory expected = bytes(contained);

        if (actual.length < expected.length) {
            return;
        }

        for (uint256 i = 0; i < actual.length - expected.length + 1; i++) {
            uint256 j = 0;
            for (; j < expected.length; j++) {
                if (actual[i + j] != expected[j]) {
                    break;
                }
            }

            // Found
            if (j == expected.length) {
                console.log("Error: a contains b [string]");
                console.log("  Value a", self.actual);
                console.log("  Value b", contained);
                vulcan.fail();
                return;
            }
        }
    }

    function toHaveLength(_StringExpectation memory self, uint256 expected) internal {
        if (bytes(self.actual).length != expected) {
            console.log("Error: a.length != b [string]");
            console.log("  Expected", expected);
            console.log("    Actual", bytes(self.actual).length);
            vulcan.fail();
        }
    }

    function toHaveLength(_StringExpectationNot memory self, uint256 expected) internal {
        if (bytes(self.actual).length == expected) {
            console.log("Error: a.length == b [string]");
            console.log("  Value a", expected);
            console.log("  Value b", bytes(self.actual).length);
            vulcan.fail();
        }
    }

    /* UINT256 */

    function toEqual(_UintExpectation memory self, uint256 expected) internal {
        if (self.actual != expected) {
            console.log("Error: a == b not satisfied [uint]");
            console.log("  Expected", expected);
            console.log("    Actual", self.actual);
            vulcan.fail();
        }
    }

    function toEqual(_UintExpectationNot memory self, uint256 expected) internal {
        if (self.actual == expected) {
            console.log("Error: a != b not satisfied [uint]");
            console.log("  Value a", expected);
            console.log("  Value b", self.actual);
            vulcan.fail();
        }
    }

    function toBeCloseTo(_UintExpectation memory self, uint256 expected, uint256 delta) internal {
        uint256 diff = util.delta(self.actual, expected);
        if (diff > delta) {
            console.log("Error: a ~= b not satisfied [uint]");
            console.log("  Expected", expected);
            console.log("    Actual", self.actual);
            console.log(" Max Delta", delta);
            console.log("     Delta", diff);
            vulcan.fail();
        }
    }

    function toBeLessThan(_UintExpectation memory self, uint256 expected) internal {
        if (self.actual >= expected) {
            console.log("Error: a < b not satisfied [uint]");
            console.log("  Value a", self.actual);
            console.log("  Value b", expected);
            vulcan.fail();
        }
    }

    function toBeLessThanOrEqual(_UintExpectation memory self, uint256 expected) internal {
        if (self.actual > expected) {
            console.log("Error: a <= b not satisfied [uint]");
            console.log("  Value a", self.actual);
            console.log("  Value b", expected);
            vulcan.fail();
        }
    }

    function toBeGreaterThan(_UintExpectation memory self, uint256 expected) internal {
        if (self.actual <= expected) {
            console.log("Error: a > b not satisfied [uint]");
            console.log("  Value a", self.actual);
            console.log("  Value b", expected);
            vulcan.fail();
        }
    }

    function toBeGreaterThanOrEqual(_UintExpectation memory self, uint256 expected) internal {
        if (self.actual < expected) {
            console.log("Error: a >= b not satisfied [uint]");
            console.log("  Value a", self.actual);
            console.log("  Value b", expected);
            vulcan.fail();
        }
    }

    /* INT */

    function toEqual(_IntExpectation memory self, int256 expected) internal {
        if (self.actual != expected) {
            console.log("Error: a == b not satisfied [int]");
            console.log("  Expected", expected);
            console.log("    Actual", self.actual);
            vulcan.fail();
        }
    }

    function toEqual(_IntExpectationNot memory self, int256 expected) internal {
        if (self.actual == expected) {
            console.log("Error: a != b not satisfied [int]");
            console.log("  Value a", expected);
            console.log("  Value b", self.actual);
            vulcan.fail();
        }
    }

    function toBeCloseTo(_IntExpectation memory self, int256 expected, uint256 delta) internal {
        uint256 diff = util.delta(self.actual, expected);

        if (diff > delta) {
            console.log("Error: a ~= b not satisfied [uint]");
            console.log("  Expected", expected);
            console.log("    Actual", self.actual);
            console.log(" Max Delta", delta);
            console.log("     Delta", diff);
            vulcan.fail();
        }
    }

    function toBeLessThan(_IntExpectation memory self, int256 expected) internal {
        if (self.actual >= expected) {
            console.log("Error: a < b not satisfied [int]");
            console.log("  Value a", self.actual);
            console.log("  Value b", expected);
            vulcan.fail();
        }
    }

    function toBeLessThanOrEqual(_IntExpectation memory self, int256 expected) internal {
        if (self.actual > expected) {
            console.log("Error: a <= b not satisfied [int]");
            console.log("  Value a", self.actual);
            console.log("  Value b", expected);
            vulcan.fail();
        }
    }

    function toBeGreaterThan(_IntExpectation memory self, int256 expected) internal {
        if (self.actual <= expected) {
            console.log("Error: a > b not satisfied [int]");
            console.log("  Value a", self.actual);
            console.log("  Value b", expected);
            vulcan.fail();
        }
    }

    function toBeGreaterThanOrEqual(_IntExpectation memory self, int256 expected) internal {
        if (self.actual < expected) {
            console.log("Error: a >= b not satisfied [int]");
            console.log("  Value a", self.actual);
            console.log("  Value b", expected);
            vulcan.fail();
        }
    }

    /* CALLS */

    function toHaveReverted(_CallExpectation memory self) internal {
        if (self.call.success) {
            console.log("Error: call expected to revert [call]");
            vulcan.fail();
        }
    }

    function toHaveRevertedWith(_CallExpectation memory self, bytes4 expectedSelector) internal {
        self.toHaveReverted();

        bytes4 actualSelector = bytes4(self.call.returnData);

        if (actualSelector != expectedSelector) {
            console.log("Error: call expected to revert with selector [call]");
            console.log("  Expected error", expectedSelector);
            console.log("    Actual error", actualSelector);

            vulcan.fail();
        }
    }

    function toHaveRevertedWith(_CallExpectationNot memory self, bytes4 expectedSelector) internal {
        bytes4 actualSelector = bytes4(self.call.returnData);

        if (!self.call.success && actualSelector == expectedSelector) {
            console.log("Error: call expected to not revert with selector [call]");
            console.log("    Actual error", actualSelector);

            vulcan.fail();
        }
    }

    function toHaveRevertedWith(_CallExpectation memory self, string memory error) internal {
        bytes memory expectedError = abi.encodeWithSignature("Error(string)", error);

        self.toHaveRevertedWith(expectedError);
    }

    function toHaveRevertedWith(_CallExpectationNot memory self, string memory error) internal {
        bytes memory expectedError = abi.encodeWithSignature("Error(string)", error);

        // This will use the `not` version of the function
        self.toHaveRevertedWith(expectedError);
    }

    function toHaveRevertedWith(_CallExpectation memory self, bytes memory expectedError) internal {
        self.toHaveReverted();

        bytes32 expectedHash = keccak256(expectedError);
        bytes32 actualHash = keccak256(self.call.returnData);

        if (!self.call.success && actualHash != expectedHash) {
            console.log("Error: function expected to revert with error [call]");
            console.log("  Expected error", expectedError);
            console.log("    Actual error", self.call.returnData);

            vulcan.fail();
        }
    }

    function toHaveRevertedWith(_CallExpectationNot memory self, bytes memory expectedError) internal {
        bytes32 expectedHash = keccak256(expectedError);
        bytes32 actualHash = keccak256(self.call.returnData);

        if (!self.call.success && actualHash == expectedHash) {
            console.log("Error: function expected to not revert with error [call]");
            console.log("    Actual error", self.call.returnData);

            vulcan.fail();
        }
    }

    function toHaveSucceeded(_CallExpectation memory self) internal {
        if (!self.call.success) {
            console.log("Error: call expected to succeed [call]");
            vulcan.fail();
        }
    }

    function toHaveEmitted(_CallExpectation memory self, string memory eventSig) internal {
        self.toHaveEmitted(eventSig, new bytes32[](0), new bytes(0));
    }

    function toHaveEmitted(_CallExpectation memory self, bytes32[1] memory topics) internal {
        self.toHaveEmitted("", topics.toDynamic(), new bytes(0));
    }

    function toHaveEmitted(_CallExpectation memory self, bytes32[2] memory topics) internal {
        self.toHaveEmitted("", topics.toDynamic(), new bytes(0));
    }

    function toHaveEmitted(_CallExpectation memory self, bytes32[3] memory topics) internal {
        self.toHaveEmitted("", topics.toDynamic(), new bytes(0));
    }

    function toHaveEmitted(_CallExpectation memory self, bytes32[4] memory topics) internal {
        self.toHaveEmitted("", topics.toDynamic(), new bytes(0));
    }

    function toHaveEmitted(_CallExpectation memory self, string memory eventSig, bytes memory data) internal {
        self.toHaveEmitted(eventSig, new bytes32[](0), data);
    }

    function toHaveEmitted(_CallExpectation memory self, string memory eventSig, bytes32[1] memory topics) internal {
        self.toHaveEmitted(eventSig, topics.toDynamic(), new bytes(0));
    }

    function toHaveEmitted(_CallExpectation memory self, string memory eventSig, bytes32[2] memory topics) internal {
        self.toHaveEmitted(eventSig, topics.toDynamic(), new bytes(0));
    }

    function toHaveEmitted(_CallExpectation memory self, string memory eventSig, bytes32[3] memory topics) internal {
        self.toHaveEmitted(eventSig, topics.toDynamic(), new bytes(0));
    }

    function toHaveEmitted(_CallExpectation memory self, bytes32[1] memory topics, bytes memory data) internal {
        self.toHaveEmitted("", topics.toDynamic(), data);
    }

    function toHaveEmitted(_CallExpectation memory self, bytes32[2] memory topics, bytes memory data) internal {
        self.toHaveEmitted("", topics.toDynamic(), data);
    }

    function toHaveEmitted(_CallExpectation memory self, bytes32[3] memory topics, bytes memory data) internal {
        self.toHaveEmitted("", topics.toDynamic(), data);
    }

    function toHaveEmitted(_CallExpectation memory self, bytes32[4] memory topics, bytes memory data) internal {
        self.toHaveEmitted("", topics.toDynamic(), data);
    }

    function toHaveEmitted(
        _CallExpectation memory self,
        string memory eventSig,
        bytes32[1] memory topics,
        bytes memory data
    ) internal {
        self.toHaveEmitted(eventSig, topics.toDynamic(), data);
    }

    function toHaveEmitted(
        _CallExpectation memory self,
        string memory eventSig,
        bytes32[2] memory topics,
        bytes memory data
    ) internal {
        self.toHaveEmitted(eventSig, topics.toDynamic(), data);
    }

    function toHaveEmitted(
        _CallExpectation memory self,
        string memory eventSig,
        bytes32[3] memory topics,
        bytes memory data
    ) internal {
        self.toHaveEmitted(eventSig, topics.toDynamic(), data);
    }

    function toHaveEmitted(
        _CallExpectation memory self,
        string memory eventSig,
        bytes32[] memory topics,
        bytes memory data
    ) internal {
        self.toHaveSucceeded();

        bytes32[] memory _topics;
        if (bytes(eventSig).length > 0) {
            _topics = new bytes32[](topics.length + 1);
            _topics[0] = events.topic(eventSig);
            for (uint256 i = 0; i < topics.length; i++) {
                _topics[i + 1] = topics[i];
            }
        }

        // kind of ugly, improve this whole function
        for (uint256 i = 0; i < self.call.logs.length; i++) {
            Log memory log = self.call.logs[i];

            if (log.topics.length < _topics.length) {
                continue;
            }

            if (data.length > 0 && keccak256(log.data) != keccak256(data)) {
                continue;
            }

            bool topicsMatch = true;
            for (uint256 j = 0; j < _topics.length; j++) {
                if (!AnyLib.check(_topics[j]) && log.topics[j] != _topics[j]) {
                    console.log("topics don't match");
                    topicsMatch = false;
                    break;
                }
            }

            if (topicsMatch) {
                return;
            }
        }

        // If we reach here, the topics did not match
        console.log("Error: event not emitted [call]");
        console.log("  Event", bytes(eventSig).length > 0 ? eventSig : "anonymous");
        vulcan.fail();
    }
}

function expect(bool actual) pure returns (_BoolExpectation memory) {
    return _BoolExpectation(actual, _BoolExpectationNot(actual));
}

function expect(uint256 actual) pure returns (_UintExpectation memory) {
    return _UintExpectation(actual, _UintExpectationNot(actual));
}

function expect(int256 actual) pure returns (_IntExpectation memory) {
    return _IntExpectation(actual, _IntExpectationNot(actual));
}

function expect(address actual) pure returns (_AddressExpectation memory) {
    return _AddressExpectation(actual, _AddressExpectationNot(actual));
}

function expect(bytes32 actual) pure returns (_Bytes32Expectation memory) {
    return _Bytes32Expectation(actual, _Bytes32ExpectationNot(actual));
}

function expect(bytes memory actual) pure returns (_BytesExpectation memory) {
    return _BytesExpectation(actual, _BytesExpectationNot(actual));
}

function expect(string memory actual) pure returns (_StringExpectation memory) {
    return _StringExpectation(actual, _StringExpectationNot(actual));
}

function expect(Call memory call) pure returns (_CallExpectation memory) {
    return _CallExpectation(call, _CallExpectationNot(call));
}

using ExpectLib for _BoolExpectation global;
using ExpectLib for _BoolExpectationNot global;
using ExpectLib for _UintExpectation global;
using ExpectLib for _UintExpectationNot global;
using ExpectLib for _IntExpectation global;
using ExpectLib for _IntExpectationNot global;
using ExpectLib for _AddressExpectation global;
using ExpectLib for _AddressExpectationNot global;
using ExpectLib for _Bytes32Expectation global;
using ExpectLib for _Bytes32ExpectationNot global;
using ExpectLib for _BytesExpectation global;
using ExpectLib for _BytesExpectationNot global;
using ExpectLib for _StringExpectation global;
using ExpectLib for _StringExpectationNot global;
using ExpectLib for _CallExpectation global;
using ExpectLib for _CallExpectationNot global;
