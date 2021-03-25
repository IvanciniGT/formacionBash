#!/bin/bash

function contar(){
    local _MAXIMO=$2
    local _NOMBRE=$1
    local _PAUSA=$3
    local _contador=0
    while (( $_contador <= $_MAXIMO ))
    do
        echo Soy $_NOMBRE y voy por el numero $_contador
        let _contador=$_contador+1
        sleep $_PAUSA
    done
}

contar FUNCION1 3 1 &
pid_funcion1=$!
contar FUNCION2 2 2 &
pid_funcion2=$!

wait $pid_funcion1
wait $pid_funcion2
echo YA HE ACABADO DE CONTAR LOS NUMERITOS


# &         >>> Crear un nuevo proceso en segundo plano: PARALELIZACION
# $!        >>> Recuperar el pid del último proceso lanzado
# wait PID  >>> Esperar a que un proceso termine: SINCRONIZACION

# LINUX // WINDOWS // UNIX
# Tiempo Compartido >>>> CPU

#Proceso p1 >> 100 operaciones en la CPU. LANZO ESTE PRIMERO
#Proceso p2 >> 50 operaciones en la CPU. LANZO ESTE SEGUNDO, EN PARALELO
#PEERO... tengo solo una CPU en mi sistema
#Proceso1... 10 operaciones Proceso 2... 7 operaciones ....Proceso1

################################################################################

clear
(contar FUNCION1 2 1)
(contar FUNCION2 2 2)

# Que hace un parentesis en la bash?
#    Una opcion es crar un array... pero hay más
#    Agrupa operaciones matematicas
#    Crea una subshell donde se ejecuta un código

################################################################################
clear
contar FUNCION1 2 1 | contar FUNCION2 3 2
# |  >> Crear un PIPE
#       Envía la salida estandar del primer comando a la entrada estandar del 
#       segundo, con los trabajos ejecutándose EN PARALELO
################################################################################

function detectar_numero_impar(){
    local _frase="$1"
    local _numero=${_frase#*numero}
    if (( $_numero%2 == 1 ))
    then
        echo $_frase
    fi
}
detectar_numero_impar "Soy FUNCION1 y voy por el numero 3"
detectar_numero_impar "Soy FUNCION1 y voy por el numero 4"
################################################################################
# read -r


function monitorizar_numeros_impares(){
    while read -r _frase
    do
        local _numero=${_frase#*numero}
        if (( $_numero%2 == 1 ))
        then
            echo $_frase
        fi
    done
}
clear

(contar Servidor1 20 1 | monitorizar_numeros_impares) &
pid_servidor1=$!
(contar Servidor2 15 2 | monitorizar_numeros_impares) &
pid_servidor2=$!
(contar Servidor3 7 3 | monitorizar_numeros_impares) &
pid_servidor3=$!

wait $pid_servidor1
wait $pid_servidor2
wait $pid_servidor3
echo YA HEMOS TERMINADO
