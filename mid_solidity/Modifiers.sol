// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/*
    Los modifiers son parecidos a los middlewares de frameworks como express en Nodejs
    permiten que puedas definir una especie de keyword que se declara en las funciones
    y ejecutan código antes de que llegue al cuerpo de dicha función.

    Esto nos ayuda mucho a la hora de no tener que reescribir código que ya hemos escrito o
    que un fragmento de código pueda ser utilizado en multiples sitios en nuestro contrato.

    El guión bajo "_;":
        En el cuerpo del modifier hay un "_;" que es muy importante para los modifiers.
        Los modifiers permiten que podamos ejecutar código antes o despues del cuerpo de la función. 
        En los modifiers el "_;" indica cuando se ejecuta el código de la función a la cual se lo estamos aplicando,
        por lo que si se pone el "_;" abajo de el código del modifier estamos indicando al modifier que ejecute el código
        primero y luego ejecute el resto del código.
        Lo mismo pasa si ponemos el "_;" arriba, indicando que primero ejecute el cuerpo de la función y luego 
        ejecute el código del modifier.  
*/

contract Modifiers {
    address internal owner;
    constructor(){
        owner = msg.sender;
    }

    function getOwnerContract () public view onlyOwner returns(string memory){
        // Solo podrá ejecutar 
        return "Texto oculto O.o";       
    }

    modifier onlyOwner {
        require(msg.sender == owner,"Solo el owner puede ver el texto oculto O.o");
        _;
    }
}