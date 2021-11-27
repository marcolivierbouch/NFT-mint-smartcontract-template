// contracts/CryptoLiensNFT.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract SlimeToken is ERC20 {

    constructor() ERC20("SLIME", "SLM") {
        _mint(msg.sender, 5000000000);
    }

}