#!/bin/bash

# Quiero un juego que me pregunte por un número, entre 0 y 10 a ver si lo adivino.
# Me da 3 intentos.

# Cargar el superread
source ../../proyecto/gui/super_read.sh

clear
cat cortinilla.txt
azul "Bienvenido al juego de la adivinanza..."
echo
echo

# Calcular un número aleatorio entre 0 y 20
let NUMERO_A_ADIVINAR=$RANDOM%21

# Inicializo las vidas del jugador
vidas=3

# Mientras le queden vidas
while (( $vidas > 0 ))
do
    # Preguntarle al usuario por un número
        # Que el valor esté entre 0 y 10 <<<<  Superread
    super_read  -p "Adivina un número entre 0 y 20" \
                -v numero_del_usuario \
                -r "^(1?[0-9]|20)$" \
                -m 3 \
                -f "Eso no vale... tienes que poner un número entre 0 y 20" \
                -e "No vales ni pa' poner un número... "
        
    # Ver si el usuario ha dado un valor aceptable... Sino
    codigo_salida_super_read=$?
    if (( $codigo_salida_super_read > 0 ))
    then
        # Paso y me piro !
        error_fatal "Gañán. Chao!"
        exit $codigo_salida_super_read
    fi
        
    # Verificar que el número del usuario es el correcto

    let diferencia=$numero_del_usuario-$NUMERO_A_ADIVINAR
    diferencia=${diferencia/-/}
    #diferencia=${diferencia#-}
    
    case $diferencia in
        0)
             # EUREKA !!!!
            verde "Eres un campeón ! Máquina !!!"
            echo
            exit 0
        ;;
        1|2)
            amarillo "Que te quemas!!!!! "
        ;;
        3|4)
            amarillo "Caliente, caliente !"
        ;;
        5|6)
            amarillo "Templadito..."
        ;;
        7|8|9)
            azul "Buah... ni te arrimas."
        ;;
        *)
            azul "Vamos yaa!!!! "
        ;;
    esac
    
    # Muy frio      (>=10)
    # Frio          (7-9)
    # Templado      (5-6)
    # Caliente      (3-4)
    # Que te quemas (1-2 cerca)

    # Sino... le quito una vida
    let vidas=$vidas-1
    echo
done

# Cuando no le quedan vidas
# PUF !!!!
echo "El número era: $NUMERO_A_ADIVINAR"
amarillo "Uiii.... casi casi... En otra ocasión será."
echo
exit 0