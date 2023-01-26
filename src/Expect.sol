// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.7.0;
import "./TestLib.sol";
import "./VmLib.sol";
import { console } from "./ConsoleLib.sol";


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

library ExpectLib {
    using TestLib for _T;

    /* BOOL */

    function toEqual(_BoolExpectation memory self, bool expected) internal {
        if (self.actual != expected) {
            console.log("Error: a == b not satisfied [bool]");
            console.log("  Expected", expected);
            console.log("    Actual", self.actual);
            vm.fail();
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
            vm.fail();
        }
    }

    function toEqual(_AddressExpectationNot memory self, address expected) internal {
        if (self.actual == expected) {
            console.log("Error: a != b not satisfied [address]");
            console.log("  Value a", expected);
            console.log("  Value b", self.actual);
            vm.fail();
        }
    }

    function toBeAContract(_AddressExpectation memory self) internal {
        if (self.actual.code.length == 0) {
            console.log("Error: a is not a contract [address]");
            console.log("  Value", self.actual);
            vm.fail();
        }
    }

    function toBeAContract(_AddressExpectationNot memory self) internal {
        if (self.actual.code.length == 0) {
            console.log("Error: a is a contract [address]");
            console.log("  Value", self.actual);
            vm.fail();
        }
    }

    /* BYTES */

    function toEqual(_BytesExpectation memory self, bytes memory expected) internal {
        if (keccak256(self.actual) != keccak256(expected)) {
            console.log("Error: a == b not satisfied [bytes]");
            console.log("  Expected", expected);
            console.log("    Actual", self.actual);
            vm.fail();
        }
    }

    function toEqual(_BytesExpectationNot memory self, bytes memory expected) internal {
        if (keccak256(self.actual) == keccak256(expected)) {
            console.log("Error: a != b not satisfied [bytes]");
            console.log("  Value", expected);
            console.log("  Value", self.actual);
            vm.fail();
        }
    }

    /* STRING */

    function toEqual(_StringExpectation memory self, string memory expected) internal {
        if (keccak256(abi.encodePacked(self.actual)) != keccak256(abi.encodePacked(expected))) {
            console.log("Error: a == b not satisfied [string]");
            console.log("  Expected", expected);
            console.log("    Actual", self.actual);
            vm.fail();
        }
    }

    function toEqual(_StringExpectationNot memory self, string memory expected) internal {
        if (keccak256(abi.encodePacked(self.actual)) == keccak256(abi.encodePacked(expected))) {
            console.log("Error: a != b not satisfied [string]");
            console.log("  Value a", expected);
            console.log("  Value b", self.actual);
            vm.fail();
        }
    }

    /* UINT256 */

    function toEqual(_UintExpectation memory self, uint256 expected) internal {
        if (self.actual != expected) {
            console.log("Error: a == b not satisfied [uint]");
            console.log("  Expected", expected);
            console.log("    Actual", self.actual);
            vm.fail();
        }
    }

    function toEqual(_UintExpectationNot memory self, uint256 expected) internal {
        if (self.actual == expected) {
            console.log("Error: a != b not satisfied [uint]");
            console.log("  Value a", expected);
            console.log("  Value b", self.actual);
            vm.fail();
        }
    }

    function toBeCloseTo(_UintExpectation memory self, uint256 expected, uint256 delta) internal {
        uint256 diff = self.actual > expected ? self.actual - expected : expected - self.actual;
        if (diff > delta) {
            console.log("Error: a ~= b not satisfied [uint]");
            console.log("  Expected", expected);
            console.log("    Actual", self.actual);
            console.log(" Max Delta", delta);
            console.log("     Delta", diff);
            vm.fail();
        }
    }

    function toBeLessThan(_UintExpectation memory self, uint256 expected) internal {
        if (self.actual >= expected) {
            console.log("Error: a < b not satisfied [uint]");
            console.log("  Value a", self.actual);
            console.log("  Value b", expected);
            vm.fail();
        }
    }

    function toBeLessThanOrEqual(_UintExpectation memory self, uint256 expected) internal {
        if (self.actual > expected) {
            console.log("Error: a <= b not satisfied [uint]");
            console.log("  Value a", self.actual);
            console.log("  Value b", expected);
            vm.fail();
        }
    }

    function toBeGreaterThan(_UintExpectation memory self, uint256 expected) internal {
        if (self.actual <= expected) {
            console.log("Error: a > b not satisfied [uint]");
            console.log("  Value a", self.actual);
            console.log("  Value b", expected);
            vm.fail();
        }
    }

    function toBeGreaterThanOrEqual(_UintExpectation memory self, uint256 expected) internal {
        if (self.actual < expected) {
            console.log("Error: a >= b not satisfied [uint]");
            console.log("  Value a", self.actual);
            console.log("  Value b", expected);
            vm.fail();
        }
    }

    /* INT */

    function toEqual(_IntExpectation memory self, int256 expected) internal {
        if (self.actual != expected) {
            console.log("Error: a == b not satisfied [int]");
            console.log("  Expected", expected);
            console.log("    Actual", self.actual);
            vm.fail();
        }
    }

    function toEqual(_IntExpectationNot memory self, int256 expected) internal {
        if (self.actual == expected) {
            console.log("Error: a != b not satisfied [int]");
            console.log("  Value a", expected);
            console.log("  Value b", self.actual);
            vm.fail();
        }
    }

    function toBeCloseTo(_IntExpectation memory self, int256 expected, uint256 delta) internal {
        // Adapted from forge-std stdMath

        // TODO: test for int256 min

        // absolute values
        uint256 a = uint256(self.actual < 0 ? -self.actual : self.actual);
        uint256 b = uint256(expected < 0 ? -expected : expected);

        uint256 diff;

        // same sign
        if ((self.actual ^ expected) > -1) {
            diff = a > b ? a - b : b - a;
        } else {
            diff = a + b;
        }

        if (diff > delta) {
            console.log("Error: a ~= b not satisfied [uint]");
            console.log("  Expected", expected);
            console.log("    Actual", self.actual);
            console.log(" Max Delta", delta);
            console.log("     Delta", diff);
            vm.fail();
        }
    }


    function toBeLessThan(_IntExpectation memory self, int256 expected) internal {
        if (self.actual >= expected) {
            console.log("Error: a < b not satisfied [int]");
            console.log("  Value a", self.actual);
            console.log("  Value b", expected);
            vm.fail();
        }
    }

    function toBeLessThanOrEqual(_IntExpectation memory self, int256 expected) internal {
        if (self.actual > expected) {
            console.log("Error: a <= b not satisfied [int]");
            console.log("  Value a", self.actual);
            console.log("  Value b", expected);
            vm.fail();
        }
    }

    function toBeGreaterThan(_IntExpectation memory self, int256 expected) internal {
        if (self.actual <= expected) {
            console.log("Error: a > b not satisfied [int]");
            console.log("  Value a", self.actual);
            console.log("  Value b", expected);
            vm.fail();
        }
    }

    function toBeGreaterThanOrEqual(_IntExpectation memory self, int256 expected) internal {
        if (self.actual < expected) {
            console.log("Error: a >= b not satisfied [int]");
            console.log("  Value a", self.actual);
            console.log("  Value b", expected);
            vm.fail();
        }
    }
}

function expect(bool actual) pure returns (_BoolExpectation memory) {
    return _BoolExpectation(actual, _BoolExpectationNot(actual));
}

// function expect(uint8 actual) pure returns (_UintExpectation memory) {
//     return _UintExpectation(actual, _UintExpectationNot(actual));
// }

// function expect(uint32 actual) pure returns (_UintExpectation memory) {
//     return _UintExpectation(actual, _UintExpectationNot(actual));
// }

// function expect(uint64 actual) pure returns (_UintExpectation memory) {
//     return _UintExpectation(actual, _UintExpectationNot(actual));
// }

// function expect(uint96 actual) pure returns (_UintExpectation memory) {
//     return _UintExpectation(actual, _UintExpectationNot(actual));
// }

// function expect(uint128 actual) pure returns (_UintExpectation memory) {
//     return _UintExpectation(actual, _UintExpectationNot(actual));
// }

// function expect(uint160 actual) pure returns (_UintExpectation memory) {
//     return _UintExpectation(actual, _UintExpectationNot(actual));
// }

// function expect(uint192 actual) pure returns (_UintExpectation memory) {
//     return _UintExpectation(actual, _UintExpectationNot(actual));
// }

// function expect(uint224 actual) pure returns (_UintExpectation memory) {
//     return _UintExpectation(actual, _UintExpectationNot(actual));
// }

function expect(uint256 actual) pure returns (_UintExpectation memory) {
    return _UintExpectation(actual, _UintExpectationNot(actual));
}

// function expect(int8 actual) pure returns (_IntExpectation memory) {
//     return _IntExpectation(actual, _IntExpectationNot(actual));
// }

// function expect(int32 actual) pure returns (_IntExpectation memory) {
//     return _IntExpectation(actual, _IntExpectationNot(actual));
// }

// function expect(int64 actual) pure returns (_IntExpectation memory) {
//     return _IntExpectation(actual, _IntExpectationNot(actual));
// }

// function expect(int96 actual) pure returns (_IntExpectation memory) {
//     return _IntExpectation(actual, _IntExpectationNot(actual));
// }

// function expect(int128 actual) pure returns (_IntExpectation memory) {
//     return _IntExpectation(actual, _IntExpectationNot(actual));
// }

// function expect(int160 actual) pure returns (_IntExpectation memory) {
//     return _IntExpectation(actual, _IntExpectationNot(actual));
// }

// function expect(int192 actual) pure returns (_IntExpectation memory) {
//     return _IntExpectation(actual, _IntExpectationNot(actual));
// }

// function expect(int224 actual) pure returns (_IntExpectation memory) {
//     return _IntExpectation(actual, _IntExpectationNot(actual));
// }

function expect(int256 actual) pure returns (_IntExpectation memory) {
    return _IntExpectation(actual, _IntExpectationNot(actual));
}

function expect(address actual) pure returns (_AddressExpectation memory) {
    return _AddressExpectation(actual, _AddressExpectationNot(actual));
}

function expect(bytes memory actual) pure returns (_BytesExpectation memory) {
    return _BytesExpectation(actual, _BytesExpectationNot(actual));
}

function expect(string memory actual) pure returns (_StringExpectation memory) {
    return _StringExpectation(actual, _StringExpectationNot(actual));
}

using ExpectLib for _BoolExpectation global;
using ExpectLib for _BoolExpectationNot global;
using ExpectLib for _UintExpectation global;
using ExpectLib for _UintExpectationNot global;
using ExpectLib for _IntExpectation global;
using ExpectLib for _IntExpectationNot global;
using ExpectLib for _AddressExpectation global;
using ExpectLib for _AddressExpectationNot global;
using ExpectLib for _BytesExpectation global;
using ExpectLib for _BytesExpectationNot global;
using ExpectLib for _StringExpectation global;
using ExpectLib for _StringExpectationNot global;
