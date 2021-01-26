// SPDX-License-Identifier: MIT
pragma solidity ^0.7.5;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/presets/ERC20PresetMinterPauser.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract BolToken is ERC20, ERC20PresetMinterPauser {
	bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
	constructor(uint256 supply) ERC2PresetMinterPauser("Bol", "BOL") public {
		//Creating intial supply to accomodate approx. 100 BOLs
		_mint(msg.sender, 10000);
	}

	//Grant permission to specific address, most likely a 
	function grantPermission(address minter) onlyOwner {
		_setupRole(MINTER_ROLE, minter);
	}

	//In order to mint you must be a minter or contract deployer
	function mint(address to, uint256 amount) public {
		require(hasRole(MINTER_ROLE, msg.sender), "Must be a minter");
		_mint(to, amount);
	}



	//Give permission to certain field workers who need to check on drivers and may can grant them bol tokens
	//Limit their availability to mint, based on time or how much tokens they have. Create additional modifiers

}