// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol"; 
import "./Libraries.sol";

error NotOwner();

contract Fund2 {

    address public i_contractOwner;
    constructor(){
        i_contractOwner = msg.sender;
    }

    // Librarys
    using PriceConverter for uint256;

    // funders tracking
    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;

    // Minimum USD available to transfer
    uint256 public constant MINIMUM_USD = 5 * 1e18;

    // fund Function
    function fund() public payable{
        require(msg.value.getConversionRate() >= MINIMUM_USD,"Not enough eth send");

        // add funder to the tracker
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = uint256(addressToAmountFunded[msg.sender]) + msg.value;
    }  

    // Retrieve contract ETH Balance
    function getContractBalance () public view returns (uint256){
        return address(this).balance;
    }
                      
    function withdraw() public onlyOwner {
        // delete all fund registries
        for(uint256 i = 0; i < funders.length; i++){
            address funder = funders[i];
            addressToAmountFunded[funder] = 0;
        }

        // Transfer the eth to the contractOwner
        (bool callSuccess,) = payable(i_contractOwner).call{value: address(this).balance}("");
        require(callSuccess,"Ha ocurrido un error al transferir los fondos");
    }

    // Modifiers
    modifier onlyOwner {
        // require(msg.sender == i_contractOwner,"Solo el dueno del contrato puede retirar los fondos");
        if(msg.sender != i_contractOwner){
            revert NotOwner();
        }
        _;
    }
    receive() external payable{
        fund();
    }

    fallback() external payable{
        fund();
    }
}

// CHANGE_LOG
// 1 - Implementando constantes y varaibles immutables para reducir gas fees. Reducción de gas fees 971,543 -> 948,854.
// 2 - Usando Custom Erros para reducir gas fees en el modifier onlyOwner. Reducción de Gas Fees 948,854 -> 910,557.
// 3 - Usando receive y fallback para capturar errores de llamada al contrato y poder aplicar lógica para cuando
// un usuario envie dinero directamente al hascode del contrato.