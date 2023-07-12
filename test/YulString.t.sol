// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import "forge-std/Test.sol";
import "./lib/YulDeployer.sol";

interface YulString {
    function value() external returns(string memory);
    function setValue(string memory input) external;
}

contract ExampleTest is Test {
    YulDeployer yulDeployer = new YulDeployer();

    YulString str;

    function setUp() public {
        str = YulString(yulDeployer.deployContract("YulString"));
    }

    function testExample() public {
        bytes memory setValue = abi.encodeWithSignature("setValue()", "Hello World");
        // bytes memory getValue = abi.encodeWithSignature("value()");

        (bool success, bytes memory data) = address(str).call{value: 0}(setValue);
        assertTrue(success);

        // (success, data) = address(str).call{value: 0}(getValue);
        // assertTrue(success);
        // assertEq(data, "Hello World");
    }
}
