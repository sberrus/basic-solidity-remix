// SPDX-Licence-Identifier: MIT
pragma solidity ^0.8.8;

// Importando código de github o npm

/*
	Para importar código de otro contrato utilizabamos la kw import "./ruta/sub_ruta" la cual básicamente nos permite acceder a
	todo el código del contrato que queremos acceder. Pero esto es válido si el contrato se encuentra dentro de nuestro directorio.

	IMPORTANDO CODIGO DE FUENTES EXTERNAS:
	Para importar códgio de fuentes externas debemos utilizar las rutas que empiezan por @ de npm
	Por ejemplo para traer la interface que utilizabamos para acceder al datafeed de chainlink, chainlink nos provee
	la siguiente ruta de npm: @chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol la cual utilizamos tal cual para poder
	utilizarla dentro de nuestros smartcontracts.

	En este caso, remix IDE se encarga de descargar e importar dicho paquete directamente de npm. Cuando estemos en otros editores de texto
	en un futuro como vscode, debemos usar el comando npm i @chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol ||
	yarn add @chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol para poder descargar el contrato y poder usarlo dentro
	de nuestros smartcontracts.  
*/

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
// ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ importando la interface directamente de npm



contract UsandoInterfaceImportadasGithub{
	// Contrato para consumir el data feed de chainlink.
	AggregatorV3Interface priceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);

	// Usando Funciones de un contrato externo - consumiendo contrato chainlink data feed.
	function getVersion() public view returns (uint256) {
		return priceFeed.version();
	}
	function getDescription() public view returns (string memory){
		return priceFeed.description();
	}
}