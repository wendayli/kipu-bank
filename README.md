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

## ⚙️ Contrato

```solidity
// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.30;