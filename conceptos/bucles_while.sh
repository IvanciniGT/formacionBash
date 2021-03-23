#!/bin/bash

# while CONDICION
# do
#   CODIGO
# done

# Me permite ejecutar un codigo muchas veces (o ninguna), mientras sea que 
# se cumpla la condicion

numero=0
while (( $numero < 10 ))
do
    echo $numero
    let numero=$numero+1
done