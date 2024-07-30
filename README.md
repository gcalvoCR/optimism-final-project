# Optimism Final Project

### Desarrolladores

* **Gabriel Calvo Vargas** - [gCalvoCR](https://github.com/gcalvoCR)
* **Kun Zheng** - [kunZhen](https://github.com/kunZhen)
* **Andrey Melendez** - [4ndreyMS](https://github.com/4ndreyMS)


## Estructura
El proyecto tiene 2 partes:
- Un backend con el contrato
- Un frontend con la interfaz gráfica que eventualmente consumira el contrato creado.


### Funcionalidad 

1. Emitir Credencial con fecha de expiración:
Los validadores pueden emitir una credencial usando la función `issueCredential` con una fecha de emisión y una fecha de expiración .

2. Obtener credenciales por usuario:
Esta funcionalidad recupera la lista de credenciales por "usuario" usando la funcion `getUserCredentials`.

3. Verificar validez de la credencial:
Cualquier usuario puede verificar si una credencial en particular aún es válida utilizando la función `isCredentialValid`.

4. Transferir el "Ownership" del contrato:
El propietario actual puede llamar a la función `transferOwnership` para transferir el dueño a una nueva dirección.

