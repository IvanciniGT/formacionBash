#!/bin/bash

# Condicionales

###############################################################################
# CONDICIONAL IF
###############################################################################
# if CONDICION
# then
#      CODIGO
# fi

nombre="Ivan Osuna"

if [[ $nombre == "Ivan Osuna" ]] # El doble corchete es una funcionalidad BASH
then
    # CODIGO QUE SE EJECUTA SI LA CONDICION SE CUMPLE
    echo TU NOMBRE ES IVAN !!!!
fi

if [[ 31 > 4 ]] # Esto no mira si el NUMERO 31 es MAYOR que el NUMERO 4
then
    # CODIGO QUE SE EJECUTA SI LA CONDICION SE CUMPLE
    echo Pues si que 31 es mayor que 4...
fi

if [[ "avion" < "coche" ]] # Esto no mira si el NUMERO 31 es MAYOR que el 
                           #  NUMERO 4
then
    # CODIGO QUE SE EJECUTA SI LA CONDICION SE CUMPLE
    echo "Avión va antes alfabeticamente (segun ASCII) antes que coche"
fi

if [[ "Avion" < "coche" ]] # Esto no mira si el NUMERO 31 es MAYOR que el 
                           # NUMERO 4
then
    # CODIGO QUE SE EJECUTA SI LA CONDICION SE CUMPLE
    echo "Avión va antes alfabeticamente (segun ASCII pero distingue MAYUS/MIN)\
          antes que coche"
fi


if [[ -z "$nombre_completo" ]]   # Miro si la variable nombre esta vacia
then
    echo "La variable nombre_completo está vacia"
fi


if [[ -n "$nombre" ]]   # Miro si la variable nombre tiene contenido
then
    echo "La variable nombre no está vacia"
fi


if [[ -z "vacia" ]]   # Miro si la variable está vacia
then
    echo "La variable está vacia"
fi
if [[ -n "vacia" ]]   # Miro si la variable NO está vacia
then
    echo "La variable NO está vacia"
fi
if [[ -v "vacia" ]]   # Miro si la variable está asignada
then
    echo "La variable esta asignada"
fi

# Operadores dentro del [[ ]]

    # TODOS ESTOS OPERADORES SOLO OPERAN INTERPRETANDO TEXTOS
        # == Compara textos para ver si son iguales
        # != Compara textos para ver si son diferentes
        # >  Compara ordenes ASCII de textos
        # <  Compara ordenes ASCII de textos
        # -z Mira si una variable está VACIA
        # -n Mira si una variable NO está VACIA
        # -v Mira si una variable está ASIGNADA
        # =~ Comprobar si se cumple expresión regular
        
    # OPERADORES SOBRE NUMEROS
        # -eq  Compara si dos NUMEROS son iguales  
        # -ne  Compara si dos NUMEROS son distintos  
        # -gt  Compara si un NUMERO es mayor que otro  
        # -ge  Compara si un NUMERO es mayor o IGUAL que otro  
        # -lt  Compara si un NUMERO es menor que otro  
        # -le  Compara si un NUMERO es menor o IGUAL que otro   
    
    # OPERADORES SOBRE FICHEROS Y DIRECTORIOS
        # Todo

# Operadores dentro del (( ))
# En este caso, BASH interpreta que dentro hay expresiones matemáticas, con 
# sus numeros y operadores
        # == Compara numero para ver si son iguales
        # != Compara numero para ver si son diferentes
        # > >=  Compara ordenes de numero
        # < <=  Compara ordenes de numeros
        # A parte puedo incluir operadores aritmenticos: + - * / %

if [[ 31 -gt 4 ]]
then
    echo Obvio, 31 es mayor 4 donde sea...
fi

if (( 31 > 4+17 ))
then
    echo Obvio, 31 es mayor 4 donde sea...
fi

## Casos alternativos
if [[ $nombre == "Lucas" ]]; then
    echo Tu nombre es Lucas
elif [[ $nombre == "Pato" ]]; then
    echo Pues tu nombre es Pato
else
    echo Pues tu nombre no es Pato ni Lucas
fi

###############################################################################
# CONDICIONAL CASE
###############################################################################
