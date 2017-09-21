pragma solidity ^0.4.4;

contract BankAccount {
    // The Bank
    address public owner;
    bool _switch;
    event UpdateStatus(string _msg, uint256 _amount);

    // Balances for each account
    mapping(address => uint256) balances;

    // Contructor - called when the contract is added the chain
    function BankAccount() public {
        owner = msg.sender;
    }
    modifier ifOwner(){
        if (owner != msg.sender){
            throw;
        }
        _;
    }
    function deposit(address accountHolder, uint256 amount) returns(bool) {
        balances[accountHolder] += amount;
        UpdateStatus('User has desposited money', msg.value);
        return true;
    }
    function withdraw(address accountHolder, uint256 amount) ifOwner returns(bool){
        if (balances[accountHolder] >= amount) {
            balances[accountHolder] -= amount;
            return true;
        }
         return false;
    }
    function balanceOf(address accountHolder) constant returns (uint256 balance) {
        return balances[accountHolder];
    }
}
