// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/*
    LIBRARY:

    Los libraries son parecidos a los contratos con la diferencia de que no pueden modificar el estado de la red 
    y tampoco puedes realizar transacciones dentro de ellas.

    Una de las cosas que debemos tener en cuenta es que las funciones deben ser "internal".
*/
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

library PriceConverter {
    function getPrice () internal view returns(uint256){
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
        (,int256 answer,,,)= priceFeed.latestRoundData();
        return uint256(answer * 1e10); 
    }

    function getConversionRate(uint256 ethAmmount) internal view returns (uint256){
        uint256 ethPrice = getPrice();
        uint256 ethAmmountInUsd = (ethPrice * ethAmmount) / 1e18;
        return ethAmmountInUsd;
    }
}