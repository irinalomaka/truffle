var LCoin = artifacts.require("./LCoin.sol")

module.exports = function(deployer, network, accounts) {
  deployer.deploy(LCoin)
};