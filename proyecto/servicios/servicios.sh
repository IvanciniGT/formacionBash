#!/bin/bash
source ../gui/menu.sh

#Argumentos:
#  fichero de servicios <<< obligatorio
#  descripcion > Comentario
#  nombre   
#  puerto
# NOMBRE=puerto

FICHERO_POR_DEFECTO="./servicios.txt"
PATRON_SERVIDOR=^[a-z0-9_.]{5,}$
PATRON_PUERTO=^[1-9][0-9]{0,4}$

function servicios_help(){
    echo AQUI IRIA LA AYUDA: Todo
}

# Si no nos dan el nombre, descripcion? y puerto
# Los solicitamos por consola <<<< super_read
function alta_servicio(){
    local _fichero
    local _descripcion
    local _no_descripcion=0
    local _servidor
    local _puerto

    # Tengo que darle valor a esas variables, según lo que indique el usuario
    while (( $# > 0 ))
    do
        case "$1" in
            -f|--file|-f=*|--file=*)
                if [[ "$1" != *=* ]]; then # Miro que no haya igual
                    _fichero=$2
                    shift
                else
                    _fichero=${1#*=}   # Me como del primer argumento lo que haya hasta el igual
                fi
            ;;
            -h|--host|-h=*|--host=*)
                if [[ "$1" != *=* ]]; then # Miro que no haya igual
                    _servidor=$2
                    shift
                else
                    _servidor=${1#*=}   # Me como del primer argumento lo que haya hasta el igual
                fi
            ;;
            -p|--port|-p=*|--port=*)
                if [[ "$1" != *=* ]]; then # Miro que no haya igual
                    _puerto=$2
                    shift
                else
                    _puerto=${1#*=}   # Me como del primer argumento lo que haya hasta el igual
                fi
            ;;
            -d|--description|-d=*|--description=*)
                if [[ "$1" != *=* ]]; then # Miro que no haya igual
                    _descripcion=$2
                    shift
                else
                    _descripcion=${1#*=}   # Me como del primer argumento lo que haya hasta el igual
                fi
            ;;
            -nd|--no-description|-nd=*|--no-description=*)
                _no_descripcion=1
            ;;
            *)
                error "Parametro no detectado: $1"
                servicios_help
                return 1
            ;;
        esac
        shift
    done
    
    # Validar los parametros
    if [[ -z $_fichero ]]
    then
        if [[ -f $FICHERO_POR_DEFECTO ]]
        then
            _fichero=$FICHERO_POR_DEFECTO
        else
            error "Fichero de servidores no suministrado."
            servicios_help
            return 2
        fi
    fi

    # Proceso el servidor
    if [[ -n $_servidor ]]
    then
        if [[ ! ( $_servidor =~ $PATRON_SERVIDOR ) ]]
        then
            error "Nombre de servidor invalido. Solo puede contener minúsculas, dígitos, y los caracter '.' y '_'"
            servicios_help
            return 3
        fi
    else
        super_read  -p "Nombre del servidor" \
                    -v _servidor \
                    -r $PATRON_SERVIDOR \
                    -f "Nombre de servidor invalido. Solo puede contener minúsculas, dígitos, y los caracter '.' y '_'" \
                    -e "Abortando..." 
        (( $? > 0 )) && servicios_help && return 4 
    fi
    
    # Proceso el puerto
    if [[ -n $_puerto ]]
    then
        if [[ ! ( $_puerto =~ $PATRON_PUERTO ) ]]
        then
            error "Puerto invalido. Solo puede contener numeros entre el 0-32000"
            servicios_help
            return 5
        fi
    else
        super_read  -p "Puerto" \
                    -v _puerto \
                    -r $PATRON_PUERTO \
                    -f "Puerto invalido. Solo puede contener numeros entre el 0-32000" \
                    -e "Abortando..."
        (( $? > 0 )) && servicios_help && return 6 
    fi

    # Procesamos descripcion
    if [[ $_no_descripcion == 0 && -z $_descripcion ]]
    then
        super_read  -p "Descripcion del servicio" \
                    -v _descripcion
    fi

    # Añadir el servidor en el fichero
    
    # Todo: Comprobar que el servicio no esté ya dado de alta
    # Añadir al final del fichero con el >>
    echo "" >> $_fichero
    if [[ -z "$_descripcion" ]]
    then
        echo "# Host: $_servidor. Port: $_puerto" >> $_fichero
    else
        echo "# $_descripcion" >> $_fichero
    fi
    echo "$_servidor=$_puerto" >> $_fichero

}

# borrar_servicio
function borrar_servicio(){
    local _fichero
    local _servidor
    local _puerto


    # Tengo que darle valor a esas variables, según lo que indique el usuario
    while (( $# > 0 ))
    do
        case "$1" in
            -f|--file|-f=*|--file=*)
                if [[ "$1" != *=* ]]; then # Miro que no haya igual
                    _fichero=$2
                    shift
                else
                    _fichero=${1#*=}   # Me como del primer argumento lo que haya hasta el igual
                fi
            ;;
            -h|--host|-h=*|--host=*)
                if [[ "$1" != *=* ]]; then # Miro que no haya igual
                    _servidor=$2
                    shift
                else
                    _servidor=${1#*=}   # Me como del primer argumento lo que haya hasta el igual
                fi
            ;;
            -p|--port|-p=*|--port=*)
                if [[ "$1" != *=* ]]; then # Miro que no haya igual
                    _puerto=$2
                    shift
                else
                    _puerto=${1#*=}   # Me como del primer argumento lo que haya hasta el igual
                fi
            ;;
            *)
                error "Parametro no detectado: $1"
                servicios_help
                return 1
            ;;
        esac
        shift
    done
    
    # Validar los parametros
    if [[ -z $_fichero ]]
    then
        if [[ -f $FICHERO_POR_DEFECTO ]]
        then
            _fichero=$FICHERO_POR_DEFECTO
        else
            error "Fichero de servidores no suministrado."
            servicios_help
            return 2
        fi
    fi

    # Proceso el servidor
    if [[ -n $_servidor ]]
    then
        if [[ ! ( $_servidor =~ $PATRON_SERVIDOR ) ]]
        then
            error "Nombre de servidor invalido. Solo puede contener minúsculas, dígitos, y los caracter '.' y '_'"
            servicios_help
            return 3
        fi
    else
        super_read  -p "Nombre del servidor" \
                    -v _servidor \
                    -r $PATRON_SERVIDOR \
                    -f "Nombre de servidor invalido. Solo puede contener minúsculas, dígitos, y los caracter '.' y '_'" \
                    -e "Abortando..." 
        (( $? > 0 )) && servicios_help && return 4 
    fi
    
    # Proceso el puerto
    if [[ -n $_puerto ]]
    then
        if [[ ! ( $_puerto =~ $PATRON_PUERTO ) ]]
        then
            error "Puerto invalido. Solo puede contener numeros entre el 0-32000"
            servicios_help
            return 5
        fi
    else
        super_read  -p "Puerto" \
                    -v _puerto \
                    -r $PATRON_PUERTO \
                    -f "Puerto invalido. Solo puede contener numeros entre el 0-32000" \
                    -e "Abortando..."
        (( $? > 0 )) && servicios_help && return 6 
    fi

    comentarios_daniel=()
    nuevo_fichero=$_fichero.nuevo
    
    while read linea 
    do
        if [[ $linea =~ ^\s*# ]]
        then
            comentarios_daniel+=( "$linea" )
        elif [[ $linea =~ ^\s*$ ]]
        then
            continue
        else
            #if [[ $linea =~ $_servidor=$_puerto ]]
            if [[ ! $linea =~ ^\s*$_servidor\s*=\s*$_puerto\s*(#.*)?$ ]]
            then
                echo "" >> $nuevo_fichero
                for comentario_daniel in "${comentarios_daniel[@]}"
                do
                    echo "$comentario_daniel" >> $nuevo_fichero
                done
                echo $linea >> $nuevo_fichero
            fi
            comentarios_daniel=() # Los comentario que tuviera los tiro... los descarto
        fi
    done < $_fichero
    mv $_fichero $_fichero.bak
    mv $_fichero.nuevo $_fichero
    

# Voy leyendo linea a linea
# Voy reservando descripciones que encuentre
# Cuando encuentre un servidor:
# Si es el mio, descarto las descripciones y el servidor
# Si no es el mio: Vuelco en un nuevo fichero: 
#   las descripcione que haya acumulado y el servidor
# Reemplazo el viejo archivo por el nuevo archivo
}

# alta_servicio "$@"
borrar_servicio "$@"
