# Programa que recibe un puerto de un host
# Va a mirar si el puerto está funcionando... cada X seg
# Cada monitorización, dibuja algo en la salida estandar:
# Si esta guay: CUADRADITO
# Si no esta guay, genera una X
# Va a generar un fichero llamado errores.log
# Para cada vez que no está el puerto operativo, queremos que lo anote
# en el log, con la fecha de la peticion en la que no estaba funcionando

# Para chequear un puerto : NetCat: nc
# nc -z host port

__LOGS_DIR=logs/
#[[ ! -d $__LOGS_DIR ]] && mkdir $__LOGS_DIR
mkdir -p $__LOGS_DIR

function chequear_puerto(){
    local _host=$1
    local _puerto=$2
    nc -z $_host $_puerto
    echo $(( $? == 0 ))
}

function identificar_alertas(){
    local _numero_fallos_consecutivos=0
    local _host=$1
    local _puerto=$2
    local _umbral=$3                    # tras 5 veces que no conteste genero alerta
    local _umbral_repeticion=$4         # Una vez generada la alerta... no repetir hasta 20 veces
    while read -r _estado
    do
        if (( $_estado == 0 ))
        then
            # Si hay error incremento
            let _numero_fallos_consecutivos=$_numero_fallos_consecutivos+1
            
            if (( ($_numero_fallos_consecutivos-$_umbral)%$_umbral_repeticion == 0 )) 
            then
                echo "$(date +"%d/%m/%y %H:%M") - $_host $_puerto" >> ${__LOGS_DIR}alertas.log
            fi
        else
            _numero_fallos_consecutivos=0
        fi
        # Esto no hagria nunca... ES MUY FRIKI
        # Si hay error           incremento el contador                                           si no lo reseteo
        #(( $_estado == 0 )) && let _numero_fallos_consecutivos=$_numero_fallos_consecutivos+1 || _numero_fallos_consecutivos=0

    done
}

function monitorizar_puerto(){
    local _host=$1
    local _puerto=$2
    local _periodo_tiempo=$3
    local _ICONOS=( ❌  ✅ )
    local _hora=-1
    local _fichero_monitoreo=${__LOGS_DIR}monitoreo_${_host}_$_puerto.log
    
    echo "" > $_fichero_monitoreo
    
    while true
    do
        local _esta_funcionando=$(chequear_puerto $_host $_puerto)
        echo $_esta_funcionando
        
        if [[ "$(date +"%H:%M")" == "$_hora" ]]
        then
            ## No he cambiado de hora
            echo -n ${_ICONOS[$_esta_funcionando]} >> $_fichero_monitoreo
        else
            ## He cambiado de hora
            _hora=$(date +"%H:%M")
            echo "">> $_fichero_monitoreo
            echo -n $_hora: ${_ICONOS[$_esta_funcionando]} >> $_fichero_monitoreo
        fi
        [[ $_esta_funcionando == 0 ]] && echo $(date +"%d/%m/%y %H:%M") - $_host:$_puerto  >> ${__LOGS_DIR}errores.log
        sleep $_periodo_tiempo
    done
}

#monitorizar_puerto localhost 8080 2

################
#Leer un fichero con:
#    Servidores y puertos que quiero monitorizar
#    SINTAXIS DEL FICHERO
# servidor:PUERTO1 PUERTO2
# servidor:PUERTO1

function monitorizar_servicios(){
    local _fichero_servicios=$1
    local _cada_cuanto=$2
    local _umbral_alerta=$3
    local _umbral_repeticion_alerta=$4
    local _pids_monitorizadores=()
    while read linea
    do
        # Si es un Comentario       >> Salta a la siguiente iteración de un bucle
        [[ "$linea" =~ ^\s*[#] ]] && continue 
        # Si es una linea en blanco >> Salta a la siguiente iteración de un bucle
        [[ "$linea" =~ ^\s*$ ]]   && continue 

        local _servidor="${linea%=*}" # Elimina todo lo que hay despues del igual
        local _puertos="${linea#*=}"  # Elimina lo que hay hasta el igual
        
        for _puerto in $_puertos
        do
#            monitorizar_puerto $_servidor $_puerto $_cada_cuanto > /dev/null &
            ( monitorizar_puerto $_servidor $_puerto $_cada_cuanto | identificar_alertas $_servidor $_puerto $_umbral_alerta $_umbral_repeticion_alerta ) &
            _pids_monitorizadores+=( $! )
        done
        
    done < $_fichero_servicios
    
    read -N 1
    for _pid in ${_pids_monitorizadores[@]}
    do
        pkill -9 -P $_pid
        #kill -9 $_pid
    done
}


echo Iniciando la monitorizacion
echo Pulsa cualquier tecla para finalizar
monitorizar_servicios servicios.txt 5 5 10
