// contracts/CryptoLiensNFT.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


contract CryptoLienzNFT is ERC721URIStorage, Ownable {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    string private uri = "https://gateway.pinata.cloud/ipfs/QmYEic7z997fbaMqv7LNXs2GHfdu7DvHxRsGXvHB7wKXkm";

    constructor() ERC721("CryptoLienzNFT", "CLNFT") {}
    event MintNFT(address indexed _from, string url);


    function mintNFT()
        public
        returns (uint256)
    {
        _tokenIds.increment();

        uint256 newItemId = _tokenIds.current();
        _mint(msg.sender, newItemId);
        string memory url = string(abi.encodePacked(uri, uint2str(newItemId), ".json"));

        emit MintNFT(msg.sender, url);

        _setTokenURI(newItemId, url);

        return newItemId;
    }

    function uint2str(uint256 _i) internal pure returns (string memory str) {
        if (_i == 0) {
          return "0";
        }
        uint256 j = _i;
        uint256 length;
        while (j != 0) {
          length++;
          j /= 10;
        }
        bytes memory bstr = new bytes(length);
        uint256 k = length;
        j = _i;
        while (j != 0) {
          bstr[--k] = bytes1(uint8(48 + j % 10));
          j /= 10;
        }
        str = string(bstr);
        return str;
    }
}

// const contract = await CryptoLienzNFT.deployed();

// contract.awardItem("0x63126293FA2E90d87aCF90A79134A2761943136b", "https://upload.wikimedia.org/wikipedia/commons/thumb/0/05/Ethereum_logo_2014.svg/256px-Ethereum_logo_2014.svg.png")