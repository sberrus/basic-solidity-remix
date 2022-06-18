// SPDX-Licence-Identifier: MIT
pragma solidity ^0.8.8;


/*
    ARRAYS AND MAPPINGS: Nada nuevo que no sepa.

*/

contract ArraysAndMapping {

    uint256 public minimumFund = 5 * 1e15; // 0.05 eth

    address[] public funders; //array de los donantes
    mapping(address => uint256) public addressToAmountFunded;
 
    function fund() public payable{ 
        require(msg.value >= minimumFund,"No has enviado suficiente eth - min 0.05ETH");

        // mismo método de arrays para insertar un nuevo elemento al array
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = uint256(addressToAmountFunded[msg.sender]) + msg.value;
    }

    function getContractBalance () public view returns (uint256){
        return address(this).balance;
    }
}