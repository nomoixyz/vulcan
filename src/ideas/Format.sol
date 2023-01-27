
pragma solidity ^0.8.13;

struct _Fmt {
    string template;
    bytes data;
    string sig;
}

library Format {
    address constant CONSOLE_ADDRESS = address(0x000000000000000000636F6e736F6c652e6c6f67);

    function _sendLogPayload(bytes memory payload) private view {
        uint256 payloadLength = payload.length;
        address consoleAddress = CONSOLE_ADDRESS;
        /// @solidity memory-safe-assembly
        assembly {
            let payloadStart := add(payload, 32)
            let r := staticcall(gas(), consoleAddress, payloadStart, payloadLength, 0, 0)
        }
    }




    function arg(_Fmt memory self, string memory s) internal pure returns (_Fmt memory) {
        self.data = bytes.concat(self.data, abi.encode(s));
        self.sig = string.concat(self.sig, bytes(self.sig).length == 0 ? "string" : ",string");
        return self;
    }

    function arg(_Fmt memory self, uint256 s) internal pure returns (_Fmt memory) {
        self.data = bytes.concat(self.data, abi.encode(s));
        self.sig = string.concat(self.sig, bytes(self.sig).length == 0 ? "uint256" : ",uint256");
        return self;
    }

    function log(_Fmt memory self) internal view {
        // bytes memory payload = abi.encodePacked(bytes4(keccak256(bytes(string.concat("log(", self.sig, ")")))), self.data);
        // bytes memory payload = abi.encodeWithSignature("log(string)", string.concat("log(", self.sig, ")"));
        // _sendLogPayload(payload);

        _sendLogPayload(abi.encodeWithSignature("log(bytes)", self.data));
        _sendLogPayload(abi.encodeWithSignature("log(bytes)", abi.encode("hello", 123, "hello", 123)));

        // bytes memory payload = abi.encodeWithSignature("log(string,uint256,string,uint256)", "hello", 123, "hello", 123);
        // payload = abi.encodeWithSignature("log(bytes)", payload);
        // _sendLogPayload(payload);
    }
}

function fmt(string memory template) pure returns (_Fmt memory) {
    return _Fmt({template: template, data: "", sig: ""});
}

using Format for _Fmt global;