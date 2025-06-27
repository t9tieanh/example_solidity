// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract StudentRegistry {

    mapping  (address => Student) private students;

    struct Student {
        string name;
        uint age;
        bool isRegistered;
    }

    function getStudent (address user) external view returns (string memory ,uint, bool) {
        Student memory student = students[user];
        return (student.name, student.age, student.isRegistered);
    }

    function register(string calldata name, uint age) external {
        students[msg.sender] = Student(name, age, true);
    }

    function isStudentRegistered(address user) external view returns (bool) {
        return students[user].isRegistered;
    }
}