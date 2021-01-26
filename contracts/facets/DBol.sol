// SPDX-License-Identifier: MIT
pragma solidity ^0.7.5;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "../interfaces/ERC20TopDown.sol";
import "../interfaces/ERC721BottomUp.sol";

contract DBol is ERC721 {
	//DBol will be instantiated by the Bol.sol and then based on how many stablecoins are owed,
	//Stablecoins will be minted from here and they'll own them
	//Bol won't know that DBol is it's child, but the DBol will know it's parent


}