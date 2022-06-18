// SPDX-Licence-Identifier: MIT
pragma solidity ^0.8.8;


/*
    Este contrato se va a encargar de realizar la conversión de 50USD que es el minimo
    de USD que se puede pasar para completar la función.
    
    Para este debemos saber convertir  50USD a ETH y luego utilizar es valor para realizar el 
    require() correspondiente.

    Aquí entra en juego oracle chain link y su conexión de la offchain con onchain;

    CHAINLINK DATA FEED:
    ^^^^^^^^^^^^^^^^^^^
    Para resumir, oracle se encarga de constantemente registrar esos cambios y introducirlos en la web3.0
    de manera que al momento de consumir estos datos, en vez de consumirlos a traves de fuentes offchain que puedan
    romper la determinación de la blockchain, oracle chain link se encarga de registrar esos valores en la blockchain
    para que estos puedan ser usados sin romper con la determinación de los datos correspondientes.

    CHAINLINK RAMDOMNESS:
    ^^^^^^^^^^^^^^^^^^^^
    CHAINLINK también nos ofrece ciertas herramientas que nos pueden ayudar a incorporar ciertas caracteristicas como datos
    aleatorios sin romper la determinación de la cadena.

    CHAINLINK KEEPERS:
    ^^^^^^^^^^^^^^^^^
    Otra de las caracteristicas que nos ofrece chainlink es la de programar tareas tomando en cuenta factores de tiempo. 
    Por ejemplo: si queremos que se dispare una función en un contrato cada cierto tiempo puedes utilizar el servicio de 
    chainlink keepers.

    CHAINLINK USE ANY API:
    ^^^^^^^^^^^^^^^^^^^^^
    Como su nombre lo indica, es un servicio de chainlink que nos ofrece la posibilidad de consumir cualquier dato offchain 
    y poderlo utilizar dentro de nuestros contratos inteligentes.
*/
contract ChainLinkIntroduccion{
    uint256 public minimumUsd = 50;

    function fund() public payable {
        require(msg.value >= minimumUsd , "Didn't send enough!");
    }

    function getPrice()public{
        /*
            Consumir un contrato dentro de otro contrato:

                - Para consumir un contrato dentro de otro contrato debemos tener 2 cosas: ABI  y el address del contrato 
                que queremos consumir. 
                
                - En este caso consumiremos un contrato de Chain Link para poder acceder al DATA FEED.

                Address: 0xaEA2808407B7319A31A383B6F8B60f04BCa23cE2
                ABI: 
                
        */
    }


    function getConversionRate()public{}
}