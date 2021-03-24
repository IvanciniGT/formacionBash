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


##### Definición de arrays

colores=( rojo verde azul )
#           0    1     2

echo ${colores[1]}
colores[2]=morado
echo ${colores[@]}

####
declare -a superheroes

superheroes[0]="Ironman"
superheroes[1]="Thor"
superheroes[2]="Hulk"

echo ${superheroes[*]}
echo ${superheroes[@]}

###### Arrays asociativos
declare -A superheroes_dc

superheroes_dc[rojo]="Flash"
superheroes_dc[verde]="Green lantern"
superheroes_dc[azul]="Superman"

echo ${superheroes_dc[*]}     # Me da los valores del array
echo ${superheroes_dc[@]}
echo ${!superheroes_dc[@]}    # Obtengo las claves

for superheroe in ${superheroes_dc[*]}
do
    echo $superheroe
done

for color in ${!superheroes_dc[*]}
do
    echo $color ---- ${superheroes_dc[$color]}
done

declare -A villanos_marvel
villanos_marvel=( [grandioso]="Thanos" [oscurito]="Venom" [implacable]="Mephisto" )

echo ${!villanos_marvel[*]}
echo ${villanos_marvel[*]}
for color in ${!villanos_marvel[*]}
do
    echo $color ---- ${villanos_marvel[$color]}
done

echo ${villanos_marvel[1]} # RUINA !!!

#### Arrays en 2D
# No existen en BASH
declare -A matriz
matriz[1,1]=1
matriz[1,2]=2
matriz[2,1]=3
matriz["2,2"]=4

echo ${matriz[2,2]}


