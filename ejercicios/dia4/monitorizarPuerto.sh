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

function chequear_puerto(){
    local _host=$1
    local _puerto=$2
    nc -z $_host $_puerto
    echo $(( $? == 0 ))
}

function monitorizar_puerto(){
    local _host=$1
    local _puerto=$2
    local _periodo_tiempo=$3
    local _ICONOS=( ❌  ✅ )
    local _hora=-1
    local _fichero_monitoreo=monitoreo_$_host_$_puerto.log
    
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
        [[ $_esta_funcionando == 0 ]] && echo $(date +"%d/%m/%y %H:%M") - $_host:$_puerto  >> errores.log
        sleep $_periodo_tiempo
    done
}

monitorizar_puerto localhost 8080 2



