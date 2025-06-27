// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract FirstCoin {

    address public minter; 
    mapping (address => uint) public balances;

    event Sent(address from, address to, uint amount);

    modifier onlyMinter() {
        require(msg.sender == minter, "Not minter");
        _;
    }

    modifier checkAmount (uint amount) {
        require(amount < 1e60);
        _;
    }

    modifier checkBalance (uint amount) {
        require(amount <= balances[msg.sender], "ammount not enough");
        _;
    }

    function mint(address receiver, uint amount) public onlyMinter checkAmount(amount) {
        //require(msg.sender == minter);
        //require(amount < 1e60);
        balances[receiver] += amount; 
    }

    constructor () {
        minter = msg.sender; 
    }

    function send(address receiver, uint amount) public checkAmount(amount) checkBalance(amount) {
        //require(amount < 1e60);
        //require(amount <= balances[msg.sender], "ammount not enough");
        balances[msg.sender] -= amount;
        balances[receiver] += amount;
        emit Sent(msg.sender, receiver, amount);
    }
}