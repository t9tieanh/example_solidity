// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Donation {
    address public owner;

    struct Donor {
        address sender;
        uint amount;
        string message;
    }

    Donor[] public donors;

    constructor() {
        owner = msg.sender;
    }

    // Hàm nhận tiền donate
    function donate(string memory _message) public payable {
        require(msg.value > 0, "Must send ETH");

        donors.push(Donor({
            sender: msg.sender,
            amount: msg.value,
            message: _message
        }));
    }

    function getTotalDonors() public view returns (uint) {
        return donors.length;
    }

    function withdrawAll() public {
        require(msg.sender == owner, "Only owner can withdraw");

        payable(owner).transfer(address(this).balance);
    }

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}