#!/bin/bash

# Que es una función?
# Es un trozo de código que puede invocarse posteriormente a su definición.
# Las funciones PUEDEN recibir parametros de entrada, que utilicen en su código
# Las funciones SIEMPRE devuelven UN CODIGO DE ESTADO !!!

# El código de estado puede contener un:
# - 0 : La ejecución ha sido EXITOSA
# - Cualquier valor mayor que 0: HA HABIDO UN ERROR.
#   Los programas / funciones deben explicar que error lleva asociado cada 
#   CODIGO DE ESTADO DIFERENTE

# Ese codigo de estado también lo devuelven los programas... 
#   En general cualquier proceso que se ejecute en el S.O.

# Qué es un proceso?
#   Un programa cargado en RAM para su ejecución
#   Un proceso puede estar en diferentes estados: 
#       - Listo para ejecutarse
#       - Ejecución
#       - Finalizado
#       - Error
#       - Deadlock

# Cómo averiguo el código de salida de un programa / función en la BASH?
#   Utilizando la secuencia de caracteres $? tenemos el CODIGO DE SALIDA del 
#   ULTIMO programa/ función que se haya ejecutado en BASH

# Para crear una función:
function saluda(){
    echo Hola
}

# Para llamar a la función
saluda
saluda
saluda
# Por defecto toda función devuelve un 0 si todo ha ido bien
echo El código de salida anterior es: $?

# Trabajando con Argumentos/Parametros
function saludoPersonalizado(){
    # Para referenciar los argumentos de una función, lo hacemos a través de su 
    # posicion, ordinalidad
    echo Hola $1  # Hago referencia al primer parámetro que paso a la función
}

saludoPersonalizado Ivan
saludoPersonalizado Ivan Osuna
# A la hora de llamar a una función los argumentos se separan mediantes BLANCOS.
# BLANCOS??? 
# - Uno o varios espacios en blanco
# - Un tabulador
# - Un salto de linea
# - Cualquier combinación de ellos
# Para que algo que contiene espacios en blanco s se tome como una unidad lo 
# entrecomillo.
saludoPersonalizado "Ivan Osuna"

function saludoSuperPersonalizado(){
    # Para referenciar los argumentos de una función, lo hacemos a través de su 
    # posicion, ordinalidad
    echo Que hay $1 $2 $3 $4 $5 ? # Hago referencia al primer parámetro que paso
                                  # a la función
    echo Me han pasado: $# argumentos # $# me da el número de parametros 
                                      # suministrados a una función / programa
}
saludoSuperPersonalizado "Ivan Osuna"
saludoSuperPersonalizado Ivan Osuna

# echo $0: Muestra el interprete que se está utilizando
echo El interprete es: $0
