// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.30;

//BANCO SEGURO DESENTRALIZADO PARA DEPOSITOS Y RETIROS ETH
//@AUTOR Wensdy Pamela Sanchez Carranza. 

contract KipuBank {

     // === CONSTANTES E INMUTABLES ===

    /// @notice Limite por transaccion de retiro 1 ETH
    uint256 public immutable withdrawal_Limit = 1 ether;

    /// @notice capital maximo del banco- despliegue en 1000 ETH a WEI
    uint256 public constant bank_Cap =1000 ether;
    
    // === MAPPINGS ===
    /// @notice  Declaracion de un mapping asociado a direcciones con balance por cada usuario (almacenado en wei)
    mapping (address => uint256 ) public _balances;

     // === VARIABLES DE STORAGE ===

    // total de depositos realizados
    uint256 public totalDeposits;

    // total de retiros realizados
    uint256 public totalWithdrawals;

    // === ERRORES PERSONALIZADOS ===

    // Error cuando retiro se exede el limite permitido
    error WithdrawalExceedsLimit(uint256 requested, uint256 limit);

    // Error cuando no hay suficiente balance para retirar
    error InsufficientBalance(uint256 available, uint256 requested);

    // Error cuando deposito exede el limite permitido del banco
    error DepositExceedCap(uint256 currentTotal, uint256 requested,uint256 cap);
    
    // error cuando se intenta retirar sin fondo
    error NoBalanceToWithdraw();

    // === EVENTOS ===

     // Cuando el usuario deposita ETh
    event Deposit (address indexed user, uint256 amountInWei);

    event Withdrawal(address indexed user, uint256 amountInWei);

    //                      MODIFICADOR

     /// @notice Mientras el valor a depositar es mayor que cero
    modifier nonZeroValue (){
        require(msg.value > 0,"Debe depositar una cantidad mayor a cero");
        _;
    }

    // === FUNCIONES ===

    /// @notice El usuario deposita de ETH en su boveda personal se envia por (msg.value) 
    function deposit() external payable nonZeroValue {
        uint256 newTotal = address (this).balance;
            if(newTotal > bank_Cap){//Si el nuevo balance supera al limite del banco 
            revert DepositExceedCap ({
                currentTotal: newTotal - msg.value,//el nuevo balance del contrato
                requested : msg.value,   //valor enviado por el usuario
                cap : bank_Cap
                }) ;//revertamos con la palabra clave revert que nos permite lanzar un error personalizado 
            }

            _balances[msg.sender] += msg.value ;
            totalDeposits++;     
        emit Deposit(msg.sender, msg.value);  //emitir event de deposito con el usuario y la cantidad en wei
    }


    //El usuario retira ETH a su cuenta boveda se envia por (amount)
    function withdraw(uint256 amount) external {
         // Obtener el balance del usuario desde el mapping _balances
        uint256 userBalance = _balances[msg.sender];

        // Verificar si el usuario no tiene fondos en su bóveda
        if(userBalance == 0){
            //Revierte error cuando se intenta retirar sin fondo
            revert NoBalanceToWithdraw() ;
        }
        // Verificar si el monto solicitado excede el límite permitido por transacción  
        if(amount > withdrawal_Limit){  
            // Revertir con error personalizado incluyendo lo solicitado y el límite
            revert WithdrawalExceedsLimit({  
                requested: amount, 
                limit : withdrawal_Limit
                });
        }
        // Verificar si el usuario tiene suficiente balance para retirar el monto deseado
        if (amount > userBalance) {  
            // Revertir con error personalizado indicando cuánto tiene disponible y cuánto pidió
            revert InsufficientBalance({
                available: userBalance,
                requested: amount
            });
        }
        // Ejecutar el retiro
        executeWithdrawal(msg.sender, amount);
    } 


    // @notice Ejecuta la transferencia de ETH al usuario y actualiza el estado interno
     function executeWithdrawal ( address user, uint256 amount)private{

        // Rebaja el balance interno del usuario
        _balances[user] -= amount;
         // Incrementar el contador total de retiros
        totalWithdrawals++;

         // Realizar la transferencia segura de ETH al usuario usando call
        (bool success,) = payable(user).call{value:amount}("");

          // Verificar que la transferencia fue exitosa
        require(success , "No se pudo enviar el valor de retiro a la cuenta del usuario");

        // Emitir evento indicando que el retiro se completó
        emit Withdrawal(user, amount);
     } 

    /// @notice Consulta el balance actual de un usuario
     function getBalance(address user) external view returns (uint256) {
        return _balances[user]; //devolver el balance de un usuario por medio del mapping balances
     }

     /// @notice Retorna estadísticas del banco
    function getStats() external view returns (uint256 deposits, uint256 Withdrawals){
        return (totalDeposits , totalWithdrawals);
    }
}