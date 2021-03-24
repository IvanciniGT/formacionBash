#!/bin/bash

source ../../proyecto/gui/super_read.sh

#               JUGADOR
#  ORDENADOR   Pi    Pa    Tj
#    Pi         0    1     2
#    Pa         2    0     1
#    Tj         1    2     0
#
declare -A RESULTADO
#  Player   0       1        2
#          JUG     ORD      EMPATE
RESULTADO[piedra,piedra]=2
RESULTADO[piedra,papel]=1
RESULTADO[piedra,tijera]=0
RESULTADO[papel,piedra]=0
RESULTADO[papel,papel]=2
RESULTADO[papel,tijera]=1
RESULTADO[tijera,piedra]=1
RESULTADO[tijera,papel]=0
RESULTADO[tijera,tijera]=2

# Ganador es el que gana 2 turnos
#                 V Jugador
#                   V Ordenador
#                     V Empates
resultado_turnos=( 0 0 0 )

# Array opciones
opciones=( piedra papel tijera )
GANADOR=( "El ganador eres tu" "El ganador soy yo" "Hemos quedado empate" )

# Funcion JugarUnTurno
function jugar_un_turno(){
    clear
    amarillo "Juego PIEDRA, PAPEL o TIJERA"
    echo
    echo
    verde "Vamos: TU (${resultado_turnos[0]})  |  YO (${resultado_turnos[1]})  |  EMPATES (${resultado_turnos[2]})"
    echo 
    echo
    
    # Ordenador piensa en piedra papel o tijera
    ORDENADOR=$RANDOM%3
    ORDENADOR=${opciones[$ORDENADOR]}
    # Super_read: Usuario piense su piedra/papel/tijera
    super_read  -p "Elige" \
                -v jugador \
                -a "piedra papel tijera" \
                -m 3 \
                -f "Tienes que escribir 'piedra', 'papel' o 'tijera'" \
                -e "A esto saben jugar hasta los niños de 2 años... "
                
    # Revisar que usuario no ha puesto "thanos" >>> ERROR y me piro!
    if (( $? > 0 ))
    then
        error_fatal "A la escuela !!!"
        echo
        exit 1
    fi
    # Averiguar quien gana
    ganador=${RESULTADO[$jugador,$ORDENADOR]}
    
    # Al ganador le sumo 1 partida ganada
    let resultado_turnos[$ganador]=${resultado_turnos[$ganador]}+1
    
    # Mostrar resultados
    echo
    echo ----------------------------------
    echo "Has elegido:   $( amarillo $jugador)"
#    cat $jugador.txt
    echo Yo he elegido: $( amarillo $ORDENADOR)
#    cat $ORDENADOR.txt
    morado "$(negrita "${GANADOR[$ganador]}")"
    echo 
    pausa
}

# Hasta que uno gane 2 turno
while [[ ${resultado_turnos[0]} != 2 &&  ${resultado_turnos[1]} != 2 ]]
do
    # JugarUnTurno 
    jugar_un_turno
done

echo EL RESULTADO FINAL ES..........
resultado_ordenador=${resultado_turnos[1]}
ha_ganado_ordenador=$(( resultado_ordenador == 2 ))  # Si ha ganado el ordenador >>> VALE 1 - True
                                                     # Si ha ganado el jugador   >>> VALE 0 - False
echo ${GANADOR[$ha_ganado_ordenador]}