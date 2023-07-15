// SPDX-License-Identifier: MIT

pragma solidity 0.8.20;

contract IString {
    string public value;

    function setValue(string memory _value) public {
      value = _value;
    }
}
