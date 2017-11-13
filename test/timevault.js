const expectThrow = require('./helpers/expectThrow');
require('babel-polyfill');

var TimeVault = artifacts.require("./TimeVault.sol");
var TPToken = artifacts.require("./TakeProfitToken.sol");


contract('TimeVault', function(accounts) {
  let token_owner=accounts[0];
  let withdrawer = accounts[1];
  let owner = accounts[2];
  let nonowner1 = accounts[3];
  let nonowner2 = accounts[4];
  let nonowner3 = accounts[5];

});
