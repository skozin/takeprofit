var TPToken = artifacts.require("./TakeProfitToken.sol");
var Presale = artifacts.require("./Presale.sol");
var TimeVault = artifacts.require("./TimeVault.sol");


module.exports = async function(deployer, network, accounts) {
  deployer.deploy(TPToken).then(function(){ return deployer.deploy(Presale, TPToken.address, accounts[0]);}).then(function(){return deployer.deploy(TimeVault, TPToken.address, accounts[0]);});
};
