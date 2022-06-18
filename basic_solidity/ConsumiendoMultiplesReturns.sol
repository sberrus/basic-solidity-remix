// SPDX-Licence-Identifier: MIT
pragma solidity ^0.8.8;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract ConsumiendoMultiplesReturns{
	// Contrato para consumir el data feed de chainlink.
	AggregatorV3Interface priceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);

	// Usando Funciones de un contrato externo - consumiendo contrato chainlink data feed.
	function getVersion() public view returns (uint256) {
		return priceFeed.version();
	}
	function getDescription() public view returns (string memory){
		return priceFeed.description();
	}

	/*
		CONSUMIENDO MULTIPLES RETURNS:

			- En solidity las funciones pueden retornar mas de un valor, a diferencia de otros lenguajes como
			javascript en el que solo podemos retornar un solo valor en las funciones.

			Para verlo mejor vamos a consumir la interface de chainlink que tiene la siguiente funcion: 

			``````````````````````````````````
			function latestRoundData()
			external
			view
			returns (
				uint80 roundId,
				int256 answer,
				uint256 startedAt,
				uint256 updatedAt,
				uint80 answeredInRound
			);
			```````````````````````````````````	

			Como podemos observar esa funcion retornar varios datos. y a continuación veremos como consumirlos todos o alguno de ellos.	
	*/

	// consumiendo datos de una función externa con multiples returns
	function getPrice() public view returns (int256){
		/*
			Para consumirlos multiples returns debemos hacer una especie de destructuración la cual nos permitirá acceder
			a los datos que nosotros indiquemos que queremos obtener.
			
			``````````````````````````````````````````````````````
			(uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound)= priceFeed.latestRoundData();
			``````````````````````````````````````````````````````

			Hya varias cosas que debemos tener en cuenta:
				- 1: El orden de las variables que vamos a "destructurar" debe ser el mismo al que aparece en el return que queremos consumir.
				- 2: Si queremos acceder a una sola variable o simplemente queremos excluir algunas que no vayamos a utilizar, puedes dejar el
				espacio en blanco y poner las comas en los elementos que quieras descartar e indicar los que si quieres consumir 
				como veremos a continuación.
		*/

		// Consumiremos el contrato de chainlink y obtendremos unicamente el precio actual descartando el resto.
		(,int256 answer,,,) = priceFeed.latestRoundData();
		//^^^^^^^^^^^^^^^^
		// Como se indicaba, si queremos acceder solo a un elemento del return, debemos respetar los espacios de los demás elementos del return que
		// queremos consumir, como en este caso solo queremos acceder al precio actual, dejamos el resto de elementos vacios pero respetamos su posición
		// dentro de la destructuración.

		return answer;
		// 	   ^^^^^^
		// Answer va a devolver un número parecido a este => "193731184338". El cual representa el valor actual del cambio eth/usd.
		// este valor es un int sin decimales pero el valor en si es este = "1937.31184338". Pero ya veremos como volver este valor util para nuestro
	}
}