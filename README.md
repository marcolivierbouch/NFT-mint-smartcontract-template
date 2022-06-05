# smartcontract


How to build
```
truffle build
```


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

## Mint phases

If you put the mint phase at 0 it means that the mint is closed for everyone.
If the mint phase is 1 it means that only the users that are allowed listed can mint
If the mint phase is 2 it means that everyone can mint


## How to make this work?

1. Deploy the smart contract
2. Deploy in ipfs your layers and the hidden metadata (https://app.pinata.cloud/)
3. You can call the function `setPreRevealTokenURI` and put the ipfs url of the hidden metadata
4. You can call the function `setBaseTokenURI` and put the ipfs url of the hidden metadata
5. Change the mint phase with `setMintPhase` with 1 or 2
6. Then people can mint
7. Call `setReveal` to reveal all nfts
