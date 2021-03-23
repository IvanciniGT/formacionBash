#!/bin/bash

mi_texto="En un lugar de la mancha de cuyo nombre no quiero acordarme, vivía un hidalgo caballero..."

echo $mi_texto

echo ${mi_texto}
echo ${mi_texto:3:4}    # Extraer un determinado subtexto
#                 ^ Cuantos coger
#               ^Desde cual coger
echo ${mi_texto: -10:4}    # Extraer un determinado subtexto
#               ^ OJO AL ESPACIO EN BLANCO

# Quitar prefijos
echo ${mi_texto#En}     # Sacar el texto desde lo que le pida.
echo ${mi_texto#*mancha}

# Quitar sufijos
echo ${mi_texto%no*}

# Ofrecer un valor por defecto si la variable está vacia o no asignada
echo ${mi_texto2:-"Aqui no hay nada"}

# Cuantos caracteres tiene un texto
echo ${#mi_texto}


## EXPRESIONES REGULARES
# El concepto base es el de PATRON
# Un PATRON es una estructura (secuencia) de caracteres FLEXIBLE
# Podemos comprobar si un texto cumple o no con un PATRON.

# Ejemplo: Hola Ivan, tienes 43 palos.
# Cumple con el patrón: Que sean todos los caracteres DIGITOS? NO
# Cumple con el patrón: Que todo sean dígito o minúsculas? NO
# Cumple con el patrón: Contiene dígitos? SI

# Estructura de un PATRON:
# Un patron es una secuencia de:
    # Bloques que contienen:
        # Un conjunto de caracteres
            # A
            # si
            # no
            # (si|no)     si o no
            # [sn]         s o n
            # [a-z]         De la a a la z, en minúscula
            # [a-zA-Z]      De la a a la z, en minúscula y mayñuscula
            # [0-9]
        # Un factor de repetición de esos caracteres
            # No poner nada: Significa 1 vez
            # ?: Significa 1 vez o ninguna (OPCIONAL)
            # +: Significa 1 vez o muchas
            # *: Significa NINGUNA o MUCHAS
            # {4}: 4 veces
            # {2,4}: De 2 a 4
            # {,8}: Hasta 8
            # {3,}: Más de 3
        # ^ Comienzo de texto
        # $ Fin de texto
#EJEMPLOS
PATRON_NUMERO_NATURAL_POSITIVO=^[1-9][0-9]*$

if [[ "12" =~ $PATRON_NUMERO_NATURAL_POSITIVO ]]
then
    echo CUMPLE!
fi
