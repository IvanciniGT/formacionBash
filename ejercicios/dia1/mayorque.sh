#!/bin/bash

# Una funcion llamada mayor, que recibiendo 2 numeros, muestre por pantalla el 
# mayor.
# Si son iguales, que muestre cualquiera de ellos.


function mayor(){
    local _numero1=$1
    local _numero2=$2
    
    if [[ $_numero1 -gt $_numero2 ]]
    then
        echo $_numero1
    else
        echo $_numero2
    fi
}

numero1=14
numero2=27
mayor $numero1 $numero2

# Quiero una funcion llamada mayorDeTres, que recibe tres numero y muestra el 
# mayor de ellos.

function mayorDeTres(){
    # ESTO SERIA HACER EL CAPULLO
    # if #numero1 > numero2
    #    if numero1 > numero3 => numero1
    #    else si no > 
    #        if si numero2>numero3 => numero2
    #        else sino numero3
    #else Si no...
    #    if si numero2>numero3 = > numero2
    #    else si no >
    #        if numero3 > numero1 => numero3
    #        else sino numero1
    
    # mayor(mayor(numero1,numero2),numero3)
    local _numero1=$1
    local _numero2=$2
    local _numero3=$3
    local _mayor_1_2=$(mayor $_numero1 $_numero2)
    echo $( mayor $_mayor_1_2 $_numero3 )
    #echo $( mayor $(mayor $_numero1 $_numero2) $_numero3 )
}
numero1=14
numero2=67
numero3=54
mayorDeTres $numero1 $numero2 $numero3