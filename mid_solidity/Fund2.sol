// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol"; 
import "./Libraries.sol";

contract Fund2 {
    address public contractOwner;
    constructor(){
        contractOwner = msg.sender;
    }
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
                        ////////////////////////////////////////////
                        // PART 2 LOOPS - TRANSACTIONS - SAFEMATH //
                        ////////////////////////////////////////////


/*
     Esta función va a borrar todos los datos de registro de los donantes.
     Esta función va a retirar los fondos de este contrato y los depositará en el address del 
     dueño del contrato. 
*/
    function withdraw() public onlyOwner {
        // BORRANDO REGISTRO DE LOS DONANTES
        for(uint256 i = 0; i < funders.length; i++){
            // Obtenemos el address del funder dado su posición en el array
            address funder = funders[i];
            // Usamos el address del funder dado su index y mappeamos ese address 
            // para eliminar el recuento de sus ingresos. 
            addressToAmountFunded[funder] = 0;
        }

        // Transfer the eth to the contractOwner
        (bool callSuccess,) = payable(contractOwner).call{value: address(this).balance}("");
        require(callSuccess,"Ha ocurrido un error al transferir los fondos");
    }
    modifier onlyOwner {
        require(msg.sender == contractOwner,"Solo el dueno del contrato puede retirar los fondos");
        _;
    }
}

// Current 5:05:00