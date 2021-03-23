#!/bin/bash

# Intro de la función

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

# Ejemplos
#   Dame la IP del servidor donde operar: 
#      read -p "Dame la IP del servidor donde operar " -v IP -d "localhost"

#   Estás seguro [s]?
#     read -p "Estás seguro (s/n) [s]? " -v segurisimo

source ./formatos.sh

function show_help(){
    echo AQUI IRIA LA AYUDA
}

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
            -d|--default|-d=*|--default=*)
                if [[ "$1" != *=* ]]; then # Miro que no haya igual
                    _default=$2
                    shift
                else
                    _default=${1#*=}   # Me como del primer argumento lo que haya hasta el igual
                fi
            ;;
            -m|--max-attemps|-m=*|--max-attemps=*)
                if [[ "$1" != *=* ]]; then # Miro que no haya igual
                    _max_attemps=$2
                    shift
                else
                    _max_attemps=${1#*=}   # Me como del primer argumento lo que haya hasta el igual
                fi
            ;;
            -r|--value-pattern|-r=*|--value-pattern=*)
                if [[ "$1" != *=* ]]; then # Miro que no haya igual
                    _value_pattern=$2
                    shift
                else
                    _value_pattern=${1#*=}   # Me como del primer argumento lo que haya hasta el igual
                fi
            ;;
            -a|--allowed-values|-a=*|--allowed-values=*)
                if [[ "$1" != *=* ]]; then # Miro que no haya igual
                    _allowed_values=$2
                    shift
                else
                    _allowed_values=${1#*=}   # Me como del primer argumento lo que haya hasta el igual
                fi
            ;;
            -f|--failure-message|-f=*|--failure-message=*)
                if [[ "$1" != *=* ]]; then # Miro que no haya igual
                    _failure_message=$2
                    shift
                else
                    _failure_message=${1#*=}   # Me como del primer argumento lo que haya hasta el igual
                fi
            ;;
            -e|--error-message|-e=*|--error-message=*)
                if [[ "$1" != *=* ]]; then # Miro que no haya igual
                    _error_message=$2
                    shift
                else
                    _error_message=${1#*=}   # Me como del primer argumento lo que haya hasta el igual
                fi
            ;;
            -v|--var-name|-v=*|--var-name=*)
                if [[ "$1" != *=* ]]; then # Miro que no haya igual
                    _var_name=$2
                    shift
                else
                    _var_name=${1#*=}   # Me como del primer argumento lo que haya hasta el igual
                fi
            ;;
            
            -h|--help)
                show_help
                exit 0
            ;;
            
            *)
                error "Uso incorrecto de la función super_read"
                show_help
                exit 1
            ;;
        esac

        shift

    done
    
    # Validar los parametros
    #  -m, --max-attemps     >>>>> numero  
    PATRON_NUMERO_ENTERO_POSITIVO=^[0-9]+$
    if [[ ! ( "$_max_attemps" =~ $PATRON_NUMERO_ENTERO_POSITIVO ) ]]
    then
        error "Uso incorrecto de la función super_read."
        error "  Valor del parametro --max-attemps inválido: $_max_attemps"
        error "  Debe ser un número positivo."
        show_help
        exit 2
    fi
    #  -v, --var             >>>>> Aqui no puede haber espacios en blanco
    PATRON_NOMBRE_VARIABLE="^[a-zA-Z0-9_]{2,50}$"
    if [[ ! ( "$_var_name" =~ $PATRON_NOMBRE_VARIABLE ) ]]
    then
        error "Uso incorrecto de la función super_read."
        error "  Valor del parametro --var-name inválido: $_var_name"
        error "  Debe ser un nombre de variable válido."
        show_help
        exit 3
    fi

    # Ya monto el código de mi programa
    echo -n $_prompt
    if [[ -n $_default ]] # Si me han pasado un valor por defecto
    then
        verde " [$_default]"
    fi
    echo -n ": "
}

#           1          2                              3      4       5  6
super_read -p "Dame la IP del servidor donde operar" -d "localhost" -v ip

#super_read -p "Estás seguro" -d "s" -o "s n" esta_seguro

# Dame la IP del servidor donde operar [localhost]: 