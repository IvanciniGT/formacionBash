#!/bin/bash

# Documentar: Explicar qué hace el programa
# Comentar:   Explicar cómo lo hace

################################################################################
# VARIABLES
################################################################################
# Definir una variable:
mi_texto="HOLA Bash"
set mi_texto="ADIOS Bash!!!"

# La bash admite distintos tipos de variables:
# Números (enteros y decimales), Textos, Listas....
# Por defecto la BASH siempre interpreta los valores como TEXTOS a no ser que se
# especifique lo contrario.

# Formas de definir y asignar valores a variables adicionales:
mi_numero=17
set mi_numero=17
let mi_numero=17 # Permite interpretar lo que escribo como valor
# Las tres opcionas son iguales en este caso

mi_numero=17+3      # >>> "17+3" como texto
set mi_numero=17+3  # >>> "17+3" como texto
let mi_numero=17+3  # >>> "20"   como texto

# Otras copciones a la hora de definir variables:
# local, export....

# Cómo recupero el valor asociado a un avariable:
# Utilizando ${NOMBRE_VARIABLE}
# Opcionalmente puedo utilizar la forma abreviada de la bash: $NOMBRE_VARIABLE.
#    Si bien, con la forma abreviada pierdo TODAS las funcionalidades extra que 
#    da bash

################################################################################
# Control de ENTRADA / SALIDA
################################################################################
# Salida
echo Repite el mensaje que ponga detrás 
# El comando echo, su salida (que va a ser lo que pase detrás ... ya que solo 
# hace eco)
# la redireccionamos a algún sitio.
# Por defecto en la bash, cuando no redirecciono una salida, se utiliza 
# LA SALIDA ESTANDAR-stdout (en una shell es la propia shell, la terminal, su 
# pantalla, lo que veo...)

# Entrada
read nombre_de_variable
# El comando read, lee de un canal / buffer (si no digo nada, del canal de 
# entrada por defecto, que es stdin)

##### Ejemploo sencillo:
echo Dime tu nombre:
read nombre
echo   Tu nombre es: $nombre