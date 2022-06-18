// SPDX-License-Identifier: MIT

pragma solidity ^0.8.8;

contract TransfiriendoFondosAContrato {

    // Esta funcion se va a encargar de recibir dinero desde otras wallets y almacenarlas en este contrato
    function fund() public payable {
        // require es similar a los "if" en los lenguajes de programación convencional. La diferencia es que
        // de no cumplirse la condición, no midifica el estado del contrato en el que se esta ejecutando. 
        // recive dos parámetros: primero la condición que se va a ejecutar y el segundo es el mensaje en 
        // string que va a aparecer en consola al momento de ejecutar el contrato.
        // Hay que tomar en cuenta que así haya un error, va a consumir el gas que haga falta para ejecutar dicha
        // condición.
        require(msg.value > 1e18, "El monto debe ser superior a 1ETH"); 
        //                  ^^^^ este valor es equivalente a 1^10 * 18 == 1000000000000000000 wei.
        //                       Por lo que suele ser utilizado para representar el valor de 1ETH.

        // CONSUMO DE GAS EN EL REQUIRE.
        // Cuando nosotros hacemos uso de un require, uno de los aspectos más imprtantes es el del revert.
        // Cuando el require no es true al momento de ejecutar la condición, el require aplica un rever.
        // Ese revert lo que hace es que en el caso de que el contrato haya modificado su estado previo al 
        // require, este volverá todos los estados previamente modificados a su estado anterior antes de ser
        // ejecutado. pongamos por ejemplo lo siguinte.
        // Tenemos una variable:
        // uint256 public number;
        // ....
        // ....
        // number == number + 1
        // require() => revert
        // ^^^^^^^^^^^^^^^^^^^ Ejecutamos una condición que hace un revert.
        // El cambio de estado "number == number + 1";
        // pasa de nuevo al estado que tenia antes de haberse ejecutado la función donde esta el revert.
        // Por lo que ese cambio de estado cuesta gas.

        // IGUALMENTE ESTO SE VERÁ MÁS EN DETALLE LUEGO
        // ............................................    
    }
}