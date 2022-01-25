//SPDX-License-Identifier: MIT

pragma solidity ^0.8.1;
contract guess_number{

    uint secretNumber;
    enum State {ACTIVE, COMPLETE}
    State public currState;
    uint balance;

    constructor(uint _secretNumber) payable {
        require(msg.value >= 10*10**18, "This contract needs to be funded with at least 10 ETH.");
        secretNumber = _secretNumber;
        balance = msg.value; 
    }

    function getBalance() public view returns(uint){
        return balance;
    }

    function play(address payable player, uint _numberGuess) external payable returns(uint){
        require(msg.value >= 1*10**18, "To play you need to pay at least 1 ETH.");
        require(currState == State.ACTIVE, "Too late :X.");
        balance = balance+msg.value;
        if (_numberGuess == secretNumber) {
            player.transfer(address(this).balance);
            currState = State.COMPLETE;
        }
        return balance;
    }

    function refreshContract(uint _secretNumber) external payable {
        require(msg.value >= 10*10**18, "To play you need to pay at least 1 ETH.");
        require(currState == State.COMPLETE, "Contract is currently active :X.");
        secretNumber = _secretNumber;
        balance = msg.value;
    }
}
