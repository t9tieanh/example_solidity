// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract NFTWhitelist is ERC721, Ownable {
    uint256 public cost = 0.01 ether;
    uint256 public maxSupply = 1000;
    uint256 public maxPerWallet = 3;
    uint256 public nextTokenId;

    mapping(address => bool) public whitelisted;
    mapping(address => uint256) public mintedPerWallet;

    // Events for React Dapp
    event Minted(address indexed user, uint256 amount);
    event AddedToWhitelist(address indexed user);
    event Withdrawn(uint256 amount);

    constructor(string memory name, string memory symbol)
        ERC721(name, symbol)
        Ownable(msg.sender) 
    {}

    // ----------------------
    // MODIFIERS
    // ----------------------

    modifier onlyWhitelisted() {
        require(whitelisted[msg.sender], "Not whitelisted");
        _;
    }

    modifier checkAmount(uint256 amount) {
        require(amount > 0, "Amount must > 0");
        _;
    }

    modifier checkMaxSupply(uint256 amount) {
        require(nextTokenId + amount <= maxSupply, "Max supply exceeded");
        _;
    }

    modifier checkPerWallet(uint256 amount) {
        require(mintedPerWallet[msg.sender] + amount <= maxPerWallet, "Max per wallet exceeded");
        _;
    }

    modifier checkPayment(uint256 amount) {
        require(msg.value >= cost * amount, "Not enough ETH");
        _;
    }

    // ----------------------
    // FUNCTIONS
    // ----------------------

    function addToWhitelist(address[] calldata users) external onlyOwner {
        for (uint256 i; i < users.length; ++i) {
            whitelisted[users[i]] = true;
            emit AddedToWhitelist(users[i]);
        }
    }

    function mint(uint256 amount)
        external
        payable
        onlyWhitelisted
        checkAmount(amount)
        checkMaxSupply(amount)
        checkPerWallet(amount)
        checkPayment(amount)
    {
        mintedPerWallet[msg.sender] += amount;

        for (uint256 i; i < amount; ++i) {
            _safeMint(msg.sender, nextTokenId + 1);
            nextTokenId++;
        }

        emit Minted(msg.sender, amount);
    }

    function withdraw() external onlyOwner {
        uint256 balance = address(this).balance;
        payable(owner()).transfer(balance);
        emit Withdrawn(balance);
    }
}
