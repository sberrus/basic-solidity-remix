// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ForLoop{
    // Loop básico de todo lenguaje de programación.
    // Estructura ciclica tradicional.

    int256[5] public persons;

    function asignValueToEachPerson (int256 _num) public {
        // estructura básica de los loops
        for(uint256 i = 0; i < persons.length; i++){
            persons[i] = _num;
        }
    }
    function asignValueToSinglePerson (uint256 _index,int256 _num) public {
        persons[_index] = _num;
    }
    function resetFundersArray () public {
        // Habría que investigar que es preferible si usar 
        // persons = new persons[](0); || delete persons
        delete persons;
    }
}