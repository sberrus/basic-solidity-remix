// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/*
    Los errores personalizados son una incorporación que nos ofrece solidity desde la versión 0.8.4 permitiendonos
    crear revert() de manera más eficiente en gas.

    -   Se declara con la kw error y debe ser declarada fuera del cuerpo del contrato.
    -   El nombre del error debe estar bien declarado debido a que este es el Error que aparecerá en la block a la hora
    de hacer el revert.

*/

error NotOwner();

contract CustomError {
    address private immutable i_owner;
    string private hiddenText = "Texto solo visible para el owner del contrato";
    constructor(){
        i_owner = msg.sender;
    }

    function getHiddenText () public view onlyOwner returns(string memory) {
        return hiddenText;
    }

    modifier onlyOwner{
        if(msg.sender != i_owner){  
            revert NotOwner();  
        //  ^^^^^^ La kw revert o la función revert() realizan el revert de manera declarativa. Podemos crear
        // funciones que se dediquen exclusivamente a crear reverts.
        }
        _;
    }
}