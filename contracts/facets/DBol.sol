// SPDX-License-Identifier: MIT
pragma solidity ^0.7.5;

import "@openzeppelin/contracts/presets/ERC721PresetMinterPauserAutold.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

//Inherits from IERC20.sol, Need this to check balance on transferERC20.sol
//Actually might not need this, I know great comments
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

//IERC99820TopDown.sol inherits from IERC721.sol
import "../interfaces/IERC998ERC20TopDown.sol";

contract DBol is ERC721PresetMinterPauserAutoId, IERC721 {
	using Counters for Counters.Counter;
	Counters.Counter private _tokenIds;

	constructor() public ERC721("DBol", "DBL") public {
	}


	//This function will be called from the original ticket contract.
	//Uses openzeppelin 
	function createDBol(address driver, string memory tokenURI) public returns (uint256) {
		require(hasRole(MINTER_ROLE, msg.sender), "Don't have permission to mint DBol token");

		_tokenIds.increment();
		uint256 newDBolId = _tokenIds.current();
		_mint(driver, newDBolId);
		_setTokenUri(newDBolId, tokenURI);

		return newDBolId;
	}


	////////////////////// Iplementation of ERC998ERC20TopDown.sol below ///////////////////

	mapping(uint256 => uint256) NFTownsFT;
	mapping(uint256 => mapping(address => uint256)) balanceOfFungibleToken;

	//A token recives ERC20 tokens, In this case it would be the msg.sender. So new owner is the one calling tokenFallback
	//params@from is the owner of the previous ERC20 tokens
	//params@value amount of tokens of being sent
	//params@data up to the first 32 bytes contains an integer which is the receiving tokenId
	function tokenFallback(address from, uint256 value, bytes calldata data) external {
		
	}

	function balanceOfERC20(uint256 tokenId, address erc20Contract) external view returns (uint256) {
		balanceOfFungibleToken[tokenId][erc20Contract];
	}

	/////////////////////////////////////////////////////////////////////////////////////////////

		// MUST FIX THIS MISTOOK THIS FOR tokenFallback()
		// transferERC20 is for transferring FT among NFTs that already own some FTs.


	//params@tokenId refers to NFT who will be owner of FT
	//params@to refers to owner of tokenId and will also by nature be the new owner of the FT
	//params@erc20Contract refers to contract addrress of FT factory
	//params@value refers to amount of FT tokens being transferred
	function transferERC20(uint256 tokenId, address to, address erc20Contract, uint256 value) external {
		//Checks that the sender of these ERC20 tokens has enough to send
		//This also makes sure balanceOf(msg.sender) doens't come back undefined
		require(address(erc20Contract).balanceOf(msg.sender)) >= value);

		// Check that the owner of tokenId is params@to
		string memory NFTOwner = ownerOf(tokenId);
		require(NFTOwner == to);

		//Sends FT tokens from the address(erc20Contract) to address(this) contract
		address(erc20Contract).transfer(address(this), value);

		//
	}
	/////////////////////////////////////////////////////////////////////////////////////////////
}