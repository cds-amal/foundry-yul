// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "../src/IString.sol";

contract ExampleTest is Test {

    IString str;

    function setUp() public {
        str = new IString();
    }

    function testFuzz_string(string calldata text) public {
        // vm.assume(bytes(text).length < 64);
        str.setValue(text);
        string memory value = str.value();
        console.log("text: %s", text);
        console.log("value: %s", value);
        assertEq(
          keccak256(abi.encodePacked(text)),
          keccak256(abi.encodePacked(value))
        );
    }

    function testSmall() public {
        string memory text = "Hello World";
        str.setValue(text);

        string memory value = str.value();
        assertEq(text, value);
    }

    function testExactly32() public {
        // string memory text = "10000000200000003000000040000000";
        string memory text = "00000000000000000000000000000000";
        // string memory text = "000000000000000000000000000000)";
        str.setValue(text);

        string memory value = str.value();
        assertEq(text, value);
    }

    function testGreaterThan32() public {
        string memory text = "1000000020000000300000004000000050000000";
        str.setValue(text);
        string memory value = str.value();
        assertEq(text, value);
    }
}

