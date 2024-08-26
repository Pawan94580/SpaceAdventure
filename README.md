# Space Adventure System

## Description

The SpaceAdventure contract is an ERC20 token implementation named "GalaxyCoin" with added features for a space-themed game. The contract allows users to check available ships, their fleet, and their token balance.

## Getting Started

In this assessment, I have used remix IDE [https://remix.ethereum.org/]

### Executing program
written the code on remix IDE [https://remix.ethereum.org/]


// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract SpaceAdventure is ERC20, Ownable {
    string[] public ships = ["Explorer", "Battleship", "Cargo", "Stealth"];

    struct Fleet {
        uint explorer;
        uint battleship;
        uint cargo;
        uint stealth;
    }
    
    mapping(address => Fleet) public userFleet;

    constructor() ERC20("GalaxyCoin", "GLX") Ownable(msg.sender) {}

    function mintTokens(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function burnTokens(uint _amount) public {
        _burn(msg.sender, _amount);
    }

    function redeemShip(uint _index) public {
        require(_index < ships.length, "Invalid index");
        
        uint256[4] memory costs = [uint256(15), uint256(25), uint256(20), uint256(35)];
        require(balanceOf(msg.sender) >= costs[_index], "Insufficient balance");
        _burn(msg.sender, costs[_index]);
        
        if (_index == 0) userFleet[msg.sender].explorer++;
        else if (_index == 1) userFleet[msg.sender].battleship++;
        else if (_index == 2) userFleet[msg.sender].cargo++;
        else if (_index == 3) userFleet[msg.sender].stealth++;
    }

    function checkAvailableShips() public view returns (string[] memory) {
        return ships;
    }

    function checkMyFleet() public view returns (Fleet memory) {
        return userFleet[msg.sender];
    }
    
    function checkBalance() public view returns (uint) {
        return balanceOf(msg.sender);
    }
}

When you're ready, you can deploy the contract to a live network like Ethereum Mainnet or any testnet. 
After deployment we can use all its functionalities of mintTokens, burnToken, redeemShip, checkAvailableShips, checkMyFleet, checkBalance

## Authors

Pawan Kumar- (https://www.linkedin.com/in/pawan-pandey-540a94266/)

## License

This project is licensed under the MIT License
