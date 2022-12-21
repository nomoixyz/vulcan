// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.7.0;

struct _BoolExpectation {
    bool actual;
    string message;
}

struct _Uint256Expectation {
    uint256 actual;
    string message;
}

library ExpectLib {
    function toEqual(_BoolExpectation memory self, bool expected) internal pure {
        if (self.actual != expected) {
            revert(self.message);
        }
    }

    function toBeTrue(_BoolExpectation memory self) internal pure {
        toEqual(self, true);
    }

    function toBeFalse(_BoolExpectation memory self) internal pure {
        toEqual(self, false);
    }

    function toEqual(_Uint256Expectation memory self, uint256 expected) internal pure {
        if (self.actual != expected) {
            revert(self.message);
        }
    }
}


function expect(bool condition, string memory message) pure returns (_BoolExpectation memory) {
    return _BoolExpectation(condition, message);
}

function expect(bool condition) pure returns (_BoolExpectation memory) {
    return _BoolExpectation(condition, "Expect failed"); // TODO improve default message
}

function expect(uint256 actual, string memory message) pure returns (_Uint256Expectation memory) {
    return _Uint256Expectation(actual, message);
}

function expect(uint256 actual) pure returns (_Uint256Expectation memory) {
    return _Uint256Expectation(actual, "Expect failed"); // TODO improve default message
}

using ExpectLib for _BoolExpectation global;
using ExpectLib for _Uint256Expectation global;
