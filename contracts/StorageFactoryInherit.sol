//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Al importar otro archivo lo que hacemos es el equivalente a copiar todo el archivo y
// ponerlo de primero para poder acceder a todo lo que contenga este.

import "./SimpleStorage.sol";
// ^^^^^^^^^^^^^^^^^^^^^^^^^
// De manera que en al importar SimpleStorage estamos trayendo a todo el archivo y copiando todo sus
// componentes dentro de este.


/**
    Este contrato será capaz de crear nuevos contratos SimpleStorage.
*/
contract StorageFactory{
    // Este array almacenará la dirección de los contratos que este contrato vaya creando. 
    SimpleStorage[] public simpleStorageArray;

    // Crear un contrato dentro de otro contrato que lo hereda es parecido a como instanciamos una clase 
    // en lenguajes de tipado estático como Java.
    function createSimpleStorageContract() public {

        SimpleStorage simpleStorage = new SimpleStorage(); 
        // Y asi de esta forma estamos creando nuevos contratos a partir de otro contrato.
        // Esto es muy útil para cuando queremos crear fabricas de contratos como este.

        // **Imaginandonos que queremos crear un contrato para crear tickets para un evento. Tendriamos un
        // contrato Ticket que se encargaría de almacenar las credenciales de la persona que ha adquirido
        // dicho ticket y otro contrato TicketFactory que se encargaría de crear los tickets que sean necesarios
        // y enviar la información que sea necesaria para la lógica del mismo.
        
        // Cada vez que el "factory" cree nuevos contratos, almacenará su address en el array de los contratos.
        simpleStorageArray.push(simpleStorage);
    }

    // Esta función se va a encargar de modificar el estado del favoriteNumber de un contrato almacenado en el array
    // de contratos pasando como argumentos el index del contrato que deseamos acceder y el número que deseamos almacenar.
    function sfStore(uint256 _simpleStorageIndex,uint256 _simpleStorageNumber)public{
        //  Address 
        
        //  ABI
        
        // Para interactuar con un contrato inteligente que este dentro del factory necesitamos acceder al address del contrato
        // que queremos modificar. Para hacer eso haremos lo siguiente.
        SimpleStorage simpleStorage = SimpleStorage(address(simpleStorageArray[_simpleStorageIndex])); 
        // En palabras sencillas, estamos almacenando en "simpleStorage" un contrato "SimpleStorage" que se encuentra en el array
        // "simpleStorageArray" con el indice indicado en "_simpleStorageIndex" pasado como argumento en la función.

        // Ya obtenido el contrato que queremos modificar, hacemos uso de sus funciones.
        simpleStorage.store(_simpleStorageNumber);
        // Asi modificamos el estado de ese contrato en especifico.

        /**
            Forma más optima: 

            SimpleStorage(address(simpleStorageArray[_simpleStorageIndex])).store(_simpleStorageNumber)

        */
    }

    function sfGet (uint256 _simpleStorageIndex) public view returns (uint256){
        // Instanciamos el contrato al cual queremos acceder a su valor. 
        SimpleStorage simpleStorage = SimpleStorage(address(simpleStorageArray[_simpleStorageIndex]));
        
        return simpleStorage.retrieves();
        /**
            Hay que recordar que la blockchain cobra fees por el tamaño de nuestro archivo. Si es cierto que el código superior es
            más legible, la forma más optima de realizar esta operación es la siguiente:
            
            return SimpleStorage(address(simpleStorageArray[_simpleStorageIndex])).retrieves();

            De esta forma estamos evitando generar más código del necesario para completar esta ejecución.
        */
    }

}