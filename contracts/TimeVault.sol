pragma solidity ^0.4.8;

import "./Token.sol";
import "./Ownable.sol";

contract TimeVault is Ownable {


  Token public token;

  uint256 public unlockedAt;

  function TimeVault(address _token, uint256 _unlockedAt) public {
    require(_token != 0x0);
    require(_unlockedAt > now);
    token = Token(_token);
    unlockedAt = _unlockedAt;
  }

  function getBalance() public constant returns (uint256 balance) {
    return token.balanceOf(this);
  }

  function claim() public onlyOwner returns (bool success){
    require(now > unlockedAt);
    token.transfer(owner, getBalance());
    if(this.balance > 0.01 ether)
      owner.transfer(this.balance);
    return true;
  }

  function () public { }

}
