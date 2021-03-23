#!/bin/bash

# Esto no es un array... es un texto, con espacios en medio
enumeracion="item1 item2    item3"
echo $enumeracion

# Bucles for
for valor in $enumeracion
do
    echo $valor
done

# Array
#lista=( item1 item2 item3 )
lista=( $enumeracion )       # Convertir un texto en una lista


echo $lista
echo ${lista[@]}             # Convertir la lista en un texto
for valor in ${lista[@]}
do
    echo $valor
done

unset lista[1]
echo ${lista[@]}
lista[0]="Ivan"
echo ${lista[@]}
lista[2]="Ayuste"
echo ${lista[@]}
lista[3]="es guay !!!!"
echo ${lista[@]}


