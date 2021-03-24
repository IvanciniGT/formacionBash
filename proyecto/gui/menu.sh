#|/bin/bash

#    TITULO_MENU
#------------------------------------------
#    1  Gestión de Servidores
#    2  Monitorización
#    3  Otra cosaque ahorano se me ocurre
#    
#    0  Salir
#------------------------------------------
#    Elija una opción [1]: 
#            >>> Si me equivoco... directamente que me muestre de nuevo el menu
#            >>> Si no me equivoco... quiero invocar una funcion

# Argumentos:
#   -f fichero de menu
#
# LINEA1: TITULO    >>> VARIABLE
# LINEA2: Mensaje de error   >>> VARIABLE
# RESTO LINEAS   >>>> 2 arrays (Opciones, Funciones)
# Titulo de opcion=funcion

source $(dirname $BASH_SOURCE)/super_read.sh

function generar_menu(){
    
    # Declaración de variables
    local _fichero=$1.menu
    local _titulo
    local _error
    declare -a _opciones
    declare -a _funciones
    local _numero_linea=0
    
    
    # Lectura del fichero del menu
    while read linea
    do
        case $_numero_linea in
            0)
                _titulo=$linea
            ;;            
            1)
                _error=$linea
            ;;
            *)
                opcion=${linea%=*}
                funcion=${linea#*=}
                #opciones["${#opciones[@]}"]=$opcion
                _opciones+=( "$opcion" )
                _funciones+=( $funcion )
            ;;
        esac
        let _numero_linea=$_numero_linea+1
    done < $_fichero
    
    # Mostrar Menu
    while true
    do
        clear
        titulo "$_titulo"
        echo
        echo
        local _numero_de_opcion=0
        for opcion in ${!_opciones[@]}
        do
            if (( $opcion != 0 ))
            then
                echo "    $(amarillo $opcion)  ${_opciones[$opcion]}"
            fi
        done
        echo
        echo "    $(morado "0  ${_opciones[0]}" )"
        echo
        azul $(linea)
        super_read -p "    Elija una opción" \
                   -v opcion_usuario \
                   -r "^[0-${#_opciones[@]}]$" \
                   -f "" \
                   -m 1 \
                   -e "$_error"
        
        if (( $? == 0 ))
        then
            ${_funciones[$opcion_usuario]} ## Llamamos a la funcion
        fi
    done
    
}
