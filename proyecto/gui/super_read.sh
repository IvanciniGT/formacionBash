#!/bin/bash

# Dame la IP del servidor donde operar: 
#read -p "Dame la IP del servidor donde operar [localhost]:" IP

# Estás seguro [s]?
#read -p "Estás seguro (s/n) [s]? " segurisimo

# Argumentos:
#  Prompt
#  Default
#  Help
#  Max attemps
#  Value Pattern
#  Array de opciones
#  failure message   (mientras le queden intentos)
#  error message     (cuando le saco de la función, por haber superado los intentos)
#  nombre variable


function super_read(){
    
}


super_read -p "Dame la IP del servidor donde operar" -d "localhost" ip
super_read -p "Estás seguro" -d "s" -o "s n" esta_seguro
