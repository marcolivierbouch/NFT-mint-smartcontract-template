
const NFT = artifacts.require("CryptoLienzNFT");

module.exports = function(deployer) {
  // Use deployer to state migration tasks.
  deployer.deploy(NFT);
};
