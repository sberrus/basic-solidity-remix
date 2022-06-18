// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TransferEth {
    address public contractOwner;
    constructor(){
        contractOwner = msg.sender;
    }
    /*
        Hay tres formas de transferir eth entre contratos inteligentes: transfer | send | call
        Los tres métodos tienen comportamientos diferentes.

        transfer:
            Con transfer se realiza la transferencia, en caso de haber algun error esta hace un "revert" y 
            quedaría el state tal cual.

        send:
            Send tiene un comportamiento algo diferente. En caso de haber algún error, send no hace un "revert",
            sino que devuelve un booleano que debemos capturar, y luego usar este dentro de un require() para que ejecute el revert
        
        call:
            call es un método basante poderoso pero este lo veremos más en detalle más adelante. Pero en resumen nos permite llamar a cualquier función
            de la blockchain sin tener que llamar a la ABI.

            Este tiene una sintaxis algo diferente que se puede ver en los snippets a continuación y retorna 2 variables,
            bool callSuccess y byte dataReturned.

            callSuccess como su nombre indica, nos devuelve un booleano indicando si la transacción ha sido realizada correctamente.
            dataReturned por otro lado nos devuelve la información de la ejecución de dicha transacción. 

        LA MANERA MÁS EFICIENTE DE REALIZAR TRANSFERENCIAS EN ETH O CUALQUIER CRYPTODIVISA NATIVA DENTRO DE LOS SMARTCONTRACTS ES CON

        >>>CALL<<<
    */
    
    function transferWeiToContract() public payable{
    }  

    function getBalance() public view returns(uint256){
        return uint256(address(this).balance);
    }  

    // DEJAMOS LA VERSIÓN DE CALL PORQUE ES LA MÁS EFICIENTE PARA LO QUE QUEREMOS HACER.
    // // transfer
    // function transferWithTransferKW() public {
        
    //     payable(contractOwner).transfer(address(this).balance);
    // }

    // // send
    // function transferWithSendKW() public {
    //     bool transferRes = payable(contractOwner).send(address(this).balance);
    //     require(transferRes,"Ha ocurrido algun error");
    // }

    // call
    function transferWithCallKW() public {
        (bool callSuccess,) = payable(contractOwner).call{value: address(this).balance}("");
        require(callSuccess,"Ha ocurrido algun error");
    }


}

// VIDEO 4:50:00