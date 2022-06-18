// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/*
    En el contrato Fund.sol tenemos una función payable fund() que se encarga de recivir los fondos de los donantes y 
    además se encarga de hacer un tracking de los donantes para saber que wallets han donado y cuanto es el monto total que
    han donado.

    Pero los contratos en sí también son wallets. Por lo que con su hashcode puedes ser capaz de enviar fondos al contrato sin
    que esta transacción pase por la función payable fund() y registre el address de quien ha enviado los fondos. Como hacemos en 
    este caso para poder registrar el address de quien ha neviado los fondos fuera de la función fund()? 

    Solidity nos ofrece 2 funciones especiales para poder realizar dicha operación.

    receive():

        -   El método especial receive es un método que no hay que declararlo con la KW function al principio, al igual que con la función  constructor()
        esta no tiene que tener la kw declarandola al principio.
        Esta función se ejecuta siempre que le contrato reciva dinero o alguien interactue de alguna manera con este pero sin enviar ningún dato.

    fallback():

        -   Funciona parecido que receive() con la diferencia de que este se encarga de escuchar los datos que se envian en la llamada la contrato.
    
*/

contract ReceiveFallback{

    string public mensaje;

    receive() external payable{
        mensaje = "Metodo usado => receive()";
    }

    fallback() external payable{
        mensaje = "Metodo usado => falback()";
    }

}