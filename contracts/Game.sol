// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Game {

    mapping (address => Player) public players;

    enum Level {Beginner, Intermediate, Advande}

    struct Player {
        address addressPlayer;
        string fullName;
        uint age;
        string sex;
        Level myLevel;
    }

    function addPlayer(string memory fullname, uint age, string memory sex) public {
        players[msg.sender] = Player(msg.sender, fullname, age, sex, Level.Beginner);
    }

    function getPlayer (address playerAddress) public view returns (
        address,
        string memory,
        uint,
        string memory,
        Level
    ) {
        Player memory p = players[playerAddress];
        return (p.addressPlayer, p.fullName, p.age, p.sex, p.myLevel);
    }
}