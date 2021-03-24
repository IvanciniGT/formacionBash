#!/bin/bash

# Genera un numero aleatorio hast el 0 - 32.XXX
echo $RANDOM  

# Generar un número aleatorio entre 0 y 10
echo $(( $RANDOM%11 ))



# 22/11 = 2 -> Resto? 0
# 32/11 = 2 -> Resto? 10
# 33/11 = 3 -> Resto? 0


echo El archivo dl script actual es: $BASH_SOURCE
echo La carpeta actual es: $PWD
