// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/*
    En solidity tenemos ciertos trucos que nos permiten ahorrar en gas al realizar los deploys en la blockchain.
    En este caso uno de esos trucos es usar las KW constant e inmutable.

    Ambas nos permiten declarar una variable que va a ser constante en la vida del contrato. Esto además de ayudarnos
    semanticamente, es más eficiente a la hora de realizar los deploys al consumir menos gas.


    constant: 
    
        -   Las variables constantes deben declararse e inicializarse. 
        -   Como convensión deben escribirse en mayúsculas separados por guiones bajos NOMBRE_CONSTANTE.

    immutable:
        -   Las variables immutable deben ser declaradas vacias y solo pueden modificarse una unica vez. 
        -   Como convensión deben escribirse con un prefix "i_" indicando que es una variable immutable. 
*/

contract ConstInmutable {

    address public immutable i_owner;
    // non-immutable: 235,340 gas
    // immutable: 209,610 gas

    constructor(){
        i_owner = msg.sender;
    }

    string public constant VARIABLE_CONSTANTE = "Hola Mundo - Este contrato gastara menos gas que si lo declaramos sin el const";
    // non-constant: 308,364 gas
    // constant: 166,768 gas
}
