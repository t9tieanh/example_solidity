// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract VotingEligibility {
    address public owner; 
    uint public minAge = 18;

    constructor() {
        owner = msg.sender;
    }

    modifier isOwner {
        require(owner == msg.sender,"Not owner");
        _;
    }

    function checkEligibility(uint age) public view returns (bool) {
        return age >= minAge;
    }

    function updateMinAge(uint newMinAge) public isOwner {
        minAge = newMinAge;
    }
}