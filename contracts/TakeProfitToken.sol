pragma solidity ^0.4.8;

import "./Token.sol";
import "./Haltable.sol";

contract TakeProfitToken is Token, Haltable {


    string constant public name = "t";//"TakeProfit";
    uint8 constant public decimals = 8;
    string constant public symbol = "3";//"TP";       
    string constant public version = "1.0";


    uint256 constant private UNIT = uint256(10)**decimals;
    uint256 public totalSupply = 10**7 * UNIT;

    uint256 constant MAX_UINT256 = 2**256 - 1; // Used for allowance: this value mean infinite allowance

    function TakeProfitToken() public {
        balances[owner] = totalSupply;
    }


    function transfer(address _to, uint256 _value) public stopInEmergency returns (bool success) {
        require(balances[msg.sender] >= _value);
        balances[msg.sender] -= _value;
        balances[_to] += _value;
        Transfer(msg.sender, _to, _value);
        return true;
    }

    function transferFrom(address _from, address _to, uint256 _value) public stopInEmergency returns (bool success) {
        uint256 allowance = allowed[_from][msg.sender];
        require(balances[_from] >= _value && allowance >= _value);
        balances[_to] += _value;
        balances[_from] -= _value;
        if (allowance < MAX_UINT256) {
            allowed[_from][msg.sender] -= _value;
        }
        Transfer(_from, _to, _value);
        return true;
    }

    function balanceOf(address _owner) constant public returns (uint256 balance) {
        return balances[_owner];
    }

    function approve(address _spender, uint256 _value) public stopInEmergency returns (bool success) {
        allowed[msg.sender][_spender] = _value;
        Approval(msg.sender, _spender, _value);
        return true;
    }

    function allowance(address _owner, address _spender) public constant returns (uint256 remaining) {
      return allowed[_owner][_spender];
    }

    mapping (address => uint256) balances;
    mapping (address => mapping (address => uint256)) allowed;
}
