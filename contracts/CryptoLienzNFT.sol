// contracts/CryptoLiensNFT.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract CryptoLienzNFT is ERC721Enumerable, Ownable {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    address payable public minter;
    uint256 public maxBatch = 5;
    uint256 public maxMintcount = 5;
    uint256 public totalCount = 200;
    uint256 public price = 60000000000000000; // 0.06 eth

    mapping (address => bool) public allowList;
    mapping(address => bool) public mintlist;

    uint256 mintPhase = 0; //Mint phase 0 is for not started; Mint phase 1 is for allowlist; Mint phase 2 is for public mint

    bool private reveal = false;
    string private uri = "";
    string private preRevealURI = "";

    event MintNFT(address indexed _from, uint256 id);

    modifier restricted() {
      require(msg.sender == minter, "Must be the owner to call this function");
      _;
    }

    constructor() ERC721("CryptoLienzNFT", "CLNFT") {
      minter = payable(msg.sender);
    }

    function mintNFT(uint256 _times) public payable {
        require(mintPhase > 0, "not started");
        require(_times > 0 && _times <= maxBatch, "Wrong batch number");
        require(_tokenIds.current() + _times <= totalCount, "Not enough item left");
        require(msg.value == _times * price, "Not the good price");
        require(mintlist[msg.sender] != true, "You've already minted a Cryptolienz! Don't be greedy!");

        if (mintPhase == 1) { // allowed list mint
          require(allowList[msg.sender], "You must be in the allowed list to mint right now!");
        }
        
        mintlist[msg.sender] = true;

        for(uint256 i = 0; i < _times; i++){
            _tokenIds.increment();

            uint256 newItemId = _tokenIds.current();
            _mint(msg.sender, newItemId);

            emit MintNFT(msg.sender, newItemId);
        }
    }

    function setAllowList(address[] calldata _addresses) external restricted {
      for (uint256 i = 0; i < _addresses.length; i++) {
          allowList[_addresses[i]] = true;
      }
    }

    function setMintPhase(uint256 _mintPhase) public restricted {
      mintPhase = _mintPhase;
    }

    function tokenURI(uint256 _tokenId) public view override returns (string memory) {
      if (!reveal) {
        return baseTokenURI();
      }
      return string(abi.encodePacked(baseTokenURI(), uint2str(_tokenId)));
    }

    function withdraw(address payable _wallet) public payable restricted {
        payable(_wallet).transfer(address(this).balance);
    }
        
    function baseTokenURI() public view returns (string memory) {
        if (!reveal) {
          return preRevealURI;
        }
        return uri;
    }

    function setPreRevealTokenURI(string memory _tokenURI) public restricted {
        preRevealURI  = _tokenURI;
    }

    function setReveal(bool _reveal) public restricted {
        reveal = _reveal;
    }

    function setBaseTokenURI(string memory _baseURI) public restricted {
        uri = _baseURI;
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
