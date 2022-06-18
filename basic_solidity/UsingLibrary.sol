// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

import "./Libraries.sol";

contract UsingLibrary {
    /*
        Con esta declaración estamos introduciendo las funciones de la "library" PriceConverter en las
        variables uint256. Lo cual todos los valores uint256 ya tienen dentro esta variable.

        Es parecido a utilizar los prototypes de js
    */
    using PriceConverter for uint256;


    // funders tracking
    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;

    // chainlink data feed
    uint256 public minimumUsd = 5 * 1e18;

    function fund() public payable{ 
        /*
            Como sabemos la variable global msg.value devuelve un valor unit256 el cual al haber usado la libraria también obtiene
            el método getConversionRate().

            La función getConversionRate() recibe argumento pero al usarse la library, el argumento enviado es el valor que tenga
            la variable al momento de hacer la llamada a la función. En el caso de que reciba más argumentos, esos ya deben ser pasados 
            como usualmente se hace, pero siempre tomando en cuenta que el primer argumento se envia en la llamada a la función.  
        */
        require(msg.value.getConversionRate() >= minimumUsd,"Not enough eth send");
        //      ^^^^^^^^^^^^^^^^^^^^^^^^^^^ Como se puede ver, el valor que contenga msg.value se envia como argumento 
        //                                  a la funcion getConversionRate para que la use internamente.

        // track the wallet who has funded.
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = uint256(addressToAmountFunded[msg.sender]) + msg.value;
    }

    function getContractBalance () public view returns (uint256){
        return address(this).balance;
    }
}