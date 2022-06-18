// SPDX-Licence-Identifier: MIT
pragma solidity ^0.8.8;
// Imports
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

/*
	Parseando los datos de chainlink para poder trabajarlos y hacer conversiones usd/eht dentro de los contratos.
*/
contract ParseandoUsdEth{
	// Contrato para consumir el data feed de chainlink.
	AggregatorV3Interface priceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);

	/*
		Chainlink nos devuelve un valor parecido a este "193731184338" estamos hablando de un número sin signo "int" de 12 digitos.
		Pero en el contrato queremos saber cuantos wei se deben mandar para que minimo se puedan mandar 50usd. Pero para ello tenemos que hacer lo siguiente:

		- 1: parsear primero int256 a uint256 y poder manejar los datos mejor.
		- 2: tenemos que saber cuanto equivale 1wei partiendo de que el valor que nos devuelve chainlink es para 1eth/usd hay que saber el cambio 1wei/usd
		- 3: Relizar los calculos para el require(msg.value >= [50usd en wei], "mensaje de error").
	*/
	function getPrice() public view returns (uint256){
		(,int256 answer,,,) = priceFeed.latestRoundData();

		/*
			Data feed devuelve el valor de la cotización que le pidamos en un número entero sin signo.
			Pero con una caracteristica particular, el formato que sigue es el siguiente:

				- Como la blockchain por diversas razones no puede almacenar decimales, lo que hace chainlink es
				devolver el valor de la cotizacion en decimales en un formato de 8 decimales máximo ej:

					- Suponiendo que devuelve la cotización ETH/USD 1535.35, Lo que hace chainlink es usar el numero
					entero "1535" y lo junta con sus 8 respectivos decimales. "35000000" y te devuelve un valor parecido a
					153535000000 		

		*/		
		return uint256(answer * 1e10); // 1**10 == 10000000000
	}

	function getConversionRate(uint256 ethAmmount) public view returns (uint256){

		uint256 ethPrice = getPrice();
		uint256 ethAmmountInUsd = (ethPrice * ethAmmount) / 1e18;

		return ethAmmountInUsd;
	}
}