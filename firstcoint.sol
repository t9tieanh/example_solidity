// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract firstcoin {

    address public minter; 
    mapping (address => uint) public balances;

    event Sent(address from, address to, uint amount);

    constructor () {
        minter = msg.sender; 
    }

    function mint(address receiver, uint amount) public {
        require(msg.sender == minter);
        require(amount < 1e60);
        balances[receiver] += amount; 
    }

    function send(address receiver, uint amount) public {
        require(amount <= balances[msg.sender], "Khong du tien ma doi chuyen");
        balances[msg.sender] -= amount;
        balances[receiver] += amount;
        emit Sent(msg.sender, receiver, amount);
    }
}