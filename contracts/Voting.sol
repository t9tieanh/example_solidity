// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract Voting {

    address private owner;

    struct Candidate {
        string name;
        uint voteCount;
    }

    mapping (address => Candidate) private candidates;
    mapping (address => bool) private hasVoted;

    // modifer giới hạn quyền cho owner
    modifier isOwner() {
        require(msg.sender == owner, "Not Owner");
        _;
    }

    // modifer giới hạn lượt vote
    modifier hasNotVoted() {
        require(hasVoted[msg.sender] == false, "Already voted");
        _;
    }

    event Voted(address voter, address candidateId);

    constructor() {
        owner = msg.sender;
    }

    function addCandidate(address candidateAddress, string calldata name) external isOwner {
        candidates[candidateAddress] = Candidate(name, 0);
    }

    function vote(address candidateAddress) external hasNotVoted {
        candidates[candidateAddress].voteCount += 1; 
        hasVoted[msg.sender] = true; 

        // thông báo voted 
        emit Voted(msg.sender, candidateAddress); 
    }

    //public function để đọc số phiếu 
    function getVoteCount(address candidateAddress) external view returns (uint) {
        return candidates[candidateAddress].voteCount;
    }
}