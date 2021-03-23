#!/bin/bash

#read -p "dame un codigo" variable_con_codigo
#variable_con_codigo="echo hola amigo"
#eval $variable_con_codigo


variable="numero"
valor=17


echo $variable=$valor
eval "$variable=$valor"

echo El valor de numero es: $numero