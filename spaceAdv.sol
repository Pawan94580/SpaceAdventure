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
