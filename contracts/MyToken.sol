// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MyToken is ERC20 {
    constructor() ERC20("MyToken", "MTK") {
        // Mint 1,000,000 token (đơn vị nhỏ nhất, decimals = 18)
        _mint(msg.sender, 1000000 * 10 ** decimals());
    }
}