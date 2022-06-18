// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

/*
    Antes de la version 0.8.0 de solidity se comporta algo raro con algunos números y variables.

    Una de las cosas que hace es lo siguiente: Siguiendo el siguiente contrato tenemos una variable que al pasarse de 
    su límite númerico esta se resetea y vuelve a 0.
*/

contract SafeMathTester {
    // Al momento de inicializar este contrato la variable es 255 siendo este el máximo de capacidad para una variable de 8 bits uint8
    uint8 public bigNumber = 255;

    // Al llamar a esta función, como el valor más alto de la variable uint8 es 255 este se resetea a 0 y empieza a sugir desde allí. 
    // En muchos casos esto puede un problema.
    function add() public {
        bigNumber = bigNumber +1;        
    }

    /*
        SOLIDITY O.8.0:
        En la versión 0.8.0 de solidity al repetir lo mismo la operación se revierte debido a que se llego al máximo permitido. En el caso
        de que se quiera replicar intenciponalmente el comportamiento de la versión 0.6.0 tenemos que hacer uso de la kw unchecked y
        arropar dentro de corchetes {} la instrucción que deseamos replicar

        ----------------------------------------  
        // unchecked {bigNumber = bigNumber +1;}
        ----------------------------------------

        ^ Cabe destacar que el usar el unchecked en las versiones superiores a 0.8.x las hace más eficientes a la hora de consumir gas.
    */
}