//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "hardhat/console.sol";

//Almacena el número favorito.
contract SimpleStorage {

    uint256 private favoriteNumber;
    bool favoriteBool;

    struct People {
        uint256 favoriteNumber;
        string name;
    }

    People[] public people;

    // Los mappings son como los dictionaries convencionales que solo almacenan un valor por llave.
    mapping(string => uint256) public nameToFavoriteNumber;


    People public person = People({favoriteNumber: 2, name: "Patrick"});

    function store(uint256 _favoriteNumber) public {
        favoriteNumber = _favoriteNumber;
    }

    function retrieves() public view returns (uint256) {
        return favoriteNumber;
    }

    // En las funciones tenemos también un comportamiento especial con la keyword de almacenamiento teniendo
    // el siguiente comportamiento:
    // 
    //      - memory: Sigue funcionando de la misma manera.
    // 
    //      - storage: Esta kw indica al compilador que la información debe mantenerse persistente lo cual
    //      mantendra el estado que recibe de la blockchain y no debe ser modificada durante la ejecución del código.
    // 
    //      - calldata: Esta kw indica que el dato solo existe durante la ejecución del código (parecido a como
    //      funciona en memory) pero inmutable.

    // Como norma general los strings deben almacenarse en memory para evitar errores con el compilador.
    function addPerson(string memory _name, uint256 _favoriteNumber) public {
        // Añadiendo un struct People al array de structs People[]
        people.push(People({name: _name, favoriteNumber: _favoriteNumber}));

        // Añadiendo un número favorito al map
        nameToFavoriteNumber[_name] = _favoriteNumber;
    }
}
