// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Profile {
    string public name;
    uint public age; 

    function setProfile (string calldata _name, uint _age) public {
        name = _name;
        age = _age;
    }
}