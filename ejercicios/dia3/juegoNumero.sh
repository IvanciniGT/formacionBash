#!/bin/bash

# Quiero un juego que me pregunte por un número, entre 0 y 10 a ver si lo adivino.
# Me da 3 intentos.

# Cargar el superread
source ../../proyecto/gui/super_read.sh

# Calcular un número aleatorio entre 0 y 10
let NUMERO_A_ADIVINAR=$RANDOM%11

# Inicializo las vidas del jugador
vidas=3

# Mientras le queden vidas
while (( $vidas > 0 ))
do
    # Preguntarle al usuario por un número
        # Que el valor esté entre 0 y 10 <<<<  Superread
    super_read  -p "Adivina un número entre 0 y 10" \
                -v numero_del_usuario \
                -r "^[0-9]|10$" \
                -m 3 \
                -f "Eso no vale... tienes que poner un número entre 0 y 10" \
                -e "No vales ni pa' poner un número... "
        
    # Ver si el usuario ha dado un valor aceptable... Sino
    codigo_salida_super_read=$?
    if (( $codigo_salida_super_read > 0 ))
    then
        # Paso y me piro !
        error_fatal "Gañán. Chao!"
        exit $codigo_salida_super_read
    fi
        
    # Verificar que el número del usuario es el correcto:
    #if (( $numero_del_usuario == $NUMERO_A_ADIVINAR ))
    #if [[ $numero_del_usuario -eq $NUMERO_A_ADIVINAR ]]
    if [[ $numero_del_usuario == $NUMERO_A_ADIVINAR ]]
    then
        # EUREKA !!!!
        verde "Eres un campeón ! Máquina !!!"
        exit 0
    fi
    
    # Sino... le quito una vida
    let vidas=$vidas-1
done

# Cuando no le quedan vidas
# PUF !!!!
amarillo "Uiii.... casi casi... En otra ocasión será."
exit 0