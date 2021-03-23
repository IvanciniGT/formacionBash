#!/bin/bash

# Dame la IP del servidor donde operar: 
#read -p "Dame la IP del servidor donde operar [localhost]:" IP

# Estás seguro [s]?
#read -p "Estás seguro (s/n) [s]? " segurisimo

# Argumentos:
#  -p, --prompt          texto   Permite especificar el mensaje que se pregunta al usuario
#  -d, --default         texto   Permite especificar el valor por defecto
#  -h, --help                    Muestra la ayuda
#  -m, --max-attemps     numero  Maximos intentos en caso de no validación del valor. Por defecto 3.
#  -r, --value-pattern   texto   Patrón para validar el valor del usuario
#  -a, --allowed-values  texto   Lista con los valores posibles separados por espacios
#  -f, --failure-message texto   Mensaje que se muestra cuando no se supera la validación
#  -e, --error-message   texto   Mensaje que se muestra tras superara los intentos maximos de validacion
#  -v, --var             texto   Nombre de la variable donde se almacenará el valor introducido por el usuario


function super_read(){
    # Renombrar parametros locales
    local _prompt
    local _default
    local _max_attemps=3
    local _value_pattern
    local _allowed_values
    local _failure_message="El valor introducido no es correcto."
    local _error_message="Demasiados intentos. Abortando."
    local _var_name
    
    # Tengo que darle valor a esas variables, según lo que indique el usuario
    while (( $# > 0 ))
    do
        case "$1" in
            -p|--prompt|-p=*|--prompt=*)
                if [[ "$1" != *=* ]]; then # Miro que no haya igual
                    _prompt=$2
                    shift
                else
                    _prompt=${1#*=}   # Me como del primer argumento lo que haya hasta el igual
                fi
            ;;
        esac

        shift

    done
    
    
    # Ya monto el código de mi programa
}

#           1          2                              3      4       5  6
super_read -p "Dame la IP del servidor donde operar" -d "localhost" -v ip

#super_read -p "Estás seguro" -d "s" -o "s n" esta_seguro
