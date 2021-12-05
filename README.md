# smartcontract



Truffle console commands:

```
truffle(rinkeby)> let instance = await CryptoLienzNFT.deployed()

# Start the mint
truffle(rinkeby)> instance.setStart(true, {from: accounts[0], value: 0})

# Set base uri
truffle(rinkeby)> instance.setBaseTokenURI("https://my api or my ipfs gateway/", {from: accounts[0], value: 0})

# Mint an NFT
truffle(rinkeby)> instance.mintNFT(1, {from: accounts[0], value: 60000000000000000})
```