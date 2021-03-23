#!/bin/bash
#
# Genera dinamicamente las funciones:
# rojo
# verde
# amarillo
# azul
# morado
# turquesa
# gris
# fondo_rojo
# fondo_verde
# fondo_amarillo
# fondo_azul
# fondo_morado
# fondo_turquesa
# fondo_gris
#
__subrayado=$(tput sgr 0 1)
__negrita=$(tput bold)
__reset_formato=$(tput sgr0)

function definiciones(){
   declare -g -A __colores=([rojo]=1 [verde]=2 [amarillo]=3 [azul]=4 [morado]=5 [turquesa]=6 [gris]=0)
   for color in ${!__colores[@]}
   do
      local __numero=${__colores[$color]}
      local __definicion="declare -g __$color=\$(tput setaf $__numero)"
      eval $__definicion
      local __definicion="declare -g __fondo_$color=\$(tput setab $__numero)"
      eval $__definicion
      
      local __funcion="function $color(){ echo \"\${__$color}\$1\${__reset_formato}\";	}"
      eval $__funcion
      __funcion="function fondo_$color(){ echo \"\${__fondo_$color}\$1\${__reset_formato}\";	}"
      eval $__funcion
   done
}
definiciones

function negrita(){
   echo "${__negrita}$1${__reset_formato}"	
}

function subrayado(){
   echo "${__subrayado}$1${__reset_formato}"	
}

function pausa(){
      local __msg=$1
      [[ -z "$__msg" ]] && __msg="Pulsa cualquier tecla para continuar..."
		echo
		read -p "${__verde}$__msg${__reset_formato}" -N 1 
}

function titulo(){
   azul "$(linea)"
   echo "  ${__negrita}${__azul}$1${__reset_formato}"	
   azul "$(linea)"
}
function linea(){
   ancho=$( tput cols )
   let ancho-=1
   ancho="{0..$ancho}"
   eval "printf -- '-%.0s' $ancho; echo \"\""
}
function error(){
   echo "${__rojo}$1${__reset_formato}"	
}

function error_fatal(){
   echo "${__negrita}${__rojo}$1${__reset_formato}"	
}