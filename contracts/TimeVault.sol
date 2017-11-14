pragma solidity ^0.4.8;

import "./Token.sol";
import "./Ownable.sol";


// This contract cannot accept Ether. Is this per design? If this contract
// is used as withdrawAddress in Presale.sol contract, it won't work.
//
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
    // need to check for transfer() result, as it may be false, which means failed transfer per ERC20
    token.transfer(owner, getBalance());
    // this contract cannot obtain non-zero balance under normal circumstances,
    // as there are no payable functions in this contract
    if(this.balance > 0.01 ether)
      owner.transfer(this.balance);
    return true;
  }

  // Unnecessary function? Was it supposed to be payable?
  function () public { }

}
