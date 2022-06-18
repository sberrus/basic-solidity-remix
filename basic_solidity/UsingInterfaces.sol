// SPDX-Licence-Identifier: MIT
pragma solidity ^0.8.8;

// Una interfaz nos permite acceder fácilmente al ABI de un smartcontrat para poder interactuar con el pasandole en el constructor el
// contrato correspondiente.
// En este ejemplo vermeos como acceder a la ABI de la siguiente interface de chain link y poder usarlo dentro de nuestro contrato.

interface AggregatorV3Interface {
  function decimals() external view returns (uint8);

  function description() external view returns (string memory);

  function version() external view returns (uint256);

  // getRoundData and latestRoundData should both raise "No data present"
  // if they do not have data to report, instead of returning unset values
  // which could be misinterpreted as actual reported values.
  function getRoundData(uint80 _roundId)
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

contract UsingInterfaces{
        /*
            En este ejemplo podemos ver como utilizando la interfaz AggregatorV3Interface, 
            pudimos acceder al contrato 0x8A753747A1Fa494EC906cE90E9f37563A8AF630e y interactuar con este en la red rinkeby.

            Hay ciertas cosas que debemos tomar en cuenta:
                - 1: Esto solo puede ejecutarse en una testnet debido a que el contrato al cual la interface accede 
                debe existir en la blockchain. En este caso el contrato que hemos utilizado esta en la testnet de 
                rinkeby y podemos acceder. En una localchain no va a funcionar.

                - 2: El contrato debe estar en la testnet que estemos usando en el injected Web3. En la página de 
                chainlink podemos acceder a distintos contratos que han sido deployados en sus respectivas testnet,
                por lo que debemos asegurarnos de que si vamos a usar la testnet de rinkeby o kovan, el contrato
                debe ser también de dicha red o la transacción revertira.
        */

        /* 
          Para poder interactuar con un contrato externo a travez de su interface creamos una variable de tipo del mismo contrato
          al que queremos acceder como en el siguiente ejemplo:
        */
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);

    function getVersion() public view returns (uint256) {
      /* 
        Como podemos observar en la interfaz arriba, esta contiene diversas funciones que son internas del contrato
        que pasamos como argumento al constructor de la interfaz. dichas funciones aunque parecen vacias estan presentes dentro
        del contrato que hemos pasado como argumento por lo que si tienen ejecución interna.
      */

      // en este caso podemos acceder a la función version() del contrato. 
        return priceFeed.version();
    }

    function getDescription() public view returns (string memory){
      return priceFeed.description();
    }

}