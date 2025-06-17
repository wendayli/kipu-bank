# kipu-bank
 Smart contract KipuBank
# 🏦 KipuBank

> Un banco descentralizado seguro construido en Solidity para depósitos y retiros de ETH.  
> Autor: **Wensdy Pamela Sanchez Carranza**  
> Licencia: GPL-3.0

---

## 🚀 Descripción

**KipuBank** es un contrato inteligente que simula un banco de custodia en Ethereum. Los usuarios pueden depositar y retirar ETH de forma segura, con límites establecidos por transacción y un tope máximo de capital.

---

## 🔐 Funcionalidades

- Depósito de ETH con validación de cero.
- Retiros con límite de 1 ETH por transacción.
- Control de balance individual por usuario.
- Límite total de capital bancario: `1000 ETH`.
- Uso de errores personalizados y eventos para trazabilidad.
- Funciones de consulta: balance por usuario y estadísticas globales.

---
## 🔐 Pasos Importantes

🧰 Tecnologías Usadas
Solidity : Lenguaje de programación para contratos inteligentes.
Remix IDE : Entorno recomendado para desarrollo rápido y pruebas.
MetaMask : Para interactuar con redes reales como Sepolia.
Ethers.js / Web3.js (opcional): Para integración web.
Requisitos Previos
Antes de comenzar, asegúrate de tener instalado:

                Node.js (si usas Hardhat o scripts locales)
                MetaMask (para redes reales)
                Conocimiento básico de Solidity
                Acceso a una red de prueba (ej: Sepolia)

🧪 Cómo Desplegar el Contrato
1. En Remix IDE (Recomendado para principiantes)

Ve a Remix IDE
Crea un nuevo archivo llamado KipuBank.sol y pega el código del contrato.
Ve a la pestaña "Solidity Compiler"
Selecciona versión: ^0.8.24
Haz clic en Compile KipuBank.sol
Ve a la pestaña "Deploy & Run Transactions"
Selecciona:
Injected Provider - MetaMask para redes reales
Haz clic en Deploy - Cómo Interactuar con el Contrato


    Después del despliegue, puedes usar las siguientes funciones:

deposit() - 
Deposita ETH en la bóveda del usuario. Usa el campo "Value" en Remix.

withdraw(uint256 amount) - 
Retira ETH, hasta el límite permitido (máximo 1 ether).

getBalance(address user) - 
Devuelve el balance almacenado del usuario (en wei).

getStats() - 
Devuelve estadísticas globales: número de depósitos y retiros.

🧪 Ejemplo Paso a Paso
1. Depósito inicial
    Función: deposit()
    Campo Value: 1 ETH
    Haz clic en transact
2. Verificar balance
    Función: getBalance(<tu-direccion>)
    Resultado esperado: 1000000000000000000
3. Retirar parte del saldo
    Función: withdraw(500000000000000000)
    Esto retira 0.5 ETH
4. Volver a verificar balance
    Debería mostrar: 500000000000000000

    ⚠️ Errores Personalizados

El contrato lanza mensajes claros si no se cumplen condiciones:

WithdrawalExceedsLimit(...): 
Si intentas retirar más de 1 ETH.
InsufficientBalance(...): 
Si no tienes suficiente balance.
DepositExceedCap(...): 
Si el banco ya alcanzó su límite de 1000 ETH.
NoBalanceToWithdraw():
Si intentas retirar sin haber depositado antes.


## ⚙️ Contrato

```solidity
// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.24;