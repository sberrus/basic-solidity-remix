// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol"; 
import "./Libraries.sol";

contract Fund {
    using PriceConverter for uint256;

    // funders tracking
    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;

    // chainlink data feed
    uint256 public minimumUsd = 5 * 1e18;

    function fund() public payable{
        require(msg.value.getConversionRate() >= minimumUsd,"Not enough eth send");

        // track the wallet who has funded.
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = uint256(addressToAmountFunded[msg.sender]) + msg.value;
    }  

    function getContractBalance () public view returns (uint256){
        return address(this).balance;
    }
}