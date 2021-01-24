pragma solidity ^0.7.3;

import '@openzeppelin/contracts/token/ERC721/ERC721.sol';
import '@openzeppelin/contracts/utils/Counters.sol';
import '@openzeppelin/contracts/access/Ownable.sol';

contract bolFactory is ERC721, Ownable {
	using Counters for Counters.Counter;
	Counters.Counter private _bolIds;
	constructor() ERC721('Bol name', 'Bol Symbol') {}

	function createBol(address owner, string memory tokenSymbol) public onlyOwner() {
		_safeMint(owner, tokenSymbol);
	}
}
