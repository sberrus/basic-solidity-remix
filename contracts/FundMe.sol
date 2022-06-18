// SPDX-Licence-Identifier: MIT
pragma solidity >= 0.6.6 < 0.9.0;

/**
En este contrato buscamos a que podamos recibir algún tipo de pago
por una transacción.
*/
// Este es el contrato que nos permite interactuar con la chain link.

// ANTES DE SEGUIR TENEMOS QUE ACLARAR QUE ES UNA INTERFACE Y QUE SON LOS ABI.

// Antes que nada hay que saber que las interfaces compilan a un ABI.

// Los ABI Aplicarion Binari Interface, le dicen a solidity y a otros lenguajes
// como pueden interactuar con este y/u otros contratos.

interface AggregatorV3Interface {

  function decimals()
    external
    view
    returns (
      uint8
    );

  function description()
    external
    view
    returns (
      string memory
    );

  function version()
    external
    view
    returns (
      uint256
    );

  // getRoundData and latestRoundData should both raise "No data present"
  // if they do not have data to report, instead of returning unset values
  // which could be misinterpreted as actual reported values.
  function getRoundData(
    uint80 _roundId
  )
    external
    view
    returns (
      uint80 roundId,
      int256 answer,
      uint256 startedAt,
      uint256 updatedAt,
      uint80 answeredInRound
    );

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

}

contract FundMe {

    // Creamos un mapping para tener un registro de las wallets que han realizado
    // transacciones con este contrato.
    mapping(address => uint256) public addressToAmountFunded;

    function fund() public payable {
                        // ^^^^^^^
                        // Esta kw es la que indica que la función es capaz de 
                        // Recibir algun tipo de pago al momento de ejecutarla.

    // Los Ethers son el token que permite realizar transacciones en ethereum. Estos
    // Tienen una conversión que es más fácil de visualizar mediante la siguiente 
    // Página web: https://eth-converter.com/
    // Siendo la unidad más pequeña de ethers 1 Wei. 1 Wei equivale a 0,000000000000000001 eth.

    // msg.sender: el objeto msg es un objeto que representa la información del wallet que
    // ha ejecutado el contrato. En este objeto podremos encontrar información como:
    //      msg.sender: address del ejecutor.
    //      msg.value: cantidad de wei que se ha enviado con la ejecución.
    // Existe otra información que contiene msg pero se verá más adelante.

    addressToAmountFunded[msg.sender] += msg.value;
    // ^^^^^^^ En esta linea estamos indicando que almacenemos en el mapping addressToAmmountFunded
    // en el index msg.sender la cantidad de wei que ha enviado.



    // CONVERSIÓN DE ETH A DIVISAS|CRYPTODIVISAS
    // En ciertos escenarios vamos a querer hacer transacciones sabiendo como realizar ciertos 
    // cambios de divisas.

    // Tomemos como ejemplo que queremos aceptar un pago que sean 20USD. Como hacemos para que 
    // el contrato sepa cuanto es la conversión de 20USD a ETH para poder realizar toda la transacción?

    // La blockchain actualmente tiene un problema, esta no puede comunicarse directamente con otras redes.
    // Nosotros no podemos pedir datos mediante http para poder usar dentro de nuestros smartcontracts. Esto
    // debido a que la blockchain es determinista. Esto significa que para que los nodos dentro de la blockchain
    // puedan llegar a un consenso, estos deben tener datos que puedan ser determinados.

    // Que ocurre por ejemplo con las llamadas http. Si por alguna razón la llamada devuelve otro valor que no sea
    // el valor obtenido en alguno de los nodos previos, no ahbrá consenso, por el contrario, si en el contrato 
    // determinamos que key = 1 + 1. Indiferentemente de los nodos que haya, todos al momento de calcular
    // "1+1" siempre el resultado dará "2".

    // Pero para solucionar este problema hay solciones como la oracle chain link.
    // oracle chain link es una solución que ha creado oracle que nos permite acceder
    // a información que esta en la blockchain y que ha sido válidada por otros nodos en la red
    // esto nos permite acceder a información off-chain de forma segura y descentralizada, de manera
    // que podamos usarla para tener mayor confianza en la red y en los datos que vayamos a usar.
    // La información disponible para ser accedida se encuentra en https://data.chain.link

    // En palabras sencillas lo que hace la oracle chain link es obtener datos de recursos off-chain
    // y subirlos a la red periodicamente de manera que esta pueda ser accedida y además siga siendo 
    // persistente. 

    // Para interactuar con la chain link tenemos que importar el contrato que nos permite acceder a ella. 
    // Esto lo veras al inicio del documento.


    }
}