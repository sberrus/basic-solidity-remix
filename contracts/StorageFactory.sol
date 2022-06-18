//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "./SimpleStorage.sol";

/**
    HERENCIAS EN SOLIDITY:

    Las herencias en solidity funcionan parecidas a las herencias que puedes usar en otros lenguajes
    orientados a objetos. 

    Usando la kw "is" al lado del "namespace" del contrato copiamos todas las funcionalidades dentro 
    de otro contrato que herede dichas funciones.  
*/

contract StorageFactoryInherit is SimpleStorage{
    //                         ^^^^^^^^^^^^^^^^
    // De esta forma podemos heredar todo lo que contiene SimpleStorage y encima de este agregar nuevas
    // funciones.

    SimpleStorage[] public simpleStorageArray;
    function createSimpleStorageContract() public {
        SimpleStorage simpleStorage = new SimpleStorage(); 
        simpleStorageArray.push(simpleStorage);
    }
    function sfStore(uint256 _simpleStorageIndex,uint256 _simpleStorageNumber)public{
            SimpleStorage(address(simpleStorageArray[_simpleStorageIndex])).store(_simpleStorageNumber);
    }

    function sfGet (uint256 _simpleStorageIndex) public view returns (uint256){
        return SimpleStorage(address(simpleStorageArray[_simpleStorageIndex])).retrieves();
    }

}