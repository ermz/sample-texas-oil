pragma solidity ^0.7.3;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract StableBol is ERC20 {
	constructor(uint256 initialSupply) public ERC20("StableBol", "DBL") {
		_mint(msg.sender, initialSupply);
	}
}