#!/bin/bash

function partirTextos(){
    local _fichero=$1
    local _ancho_linea_maximo=$2

    while read linea
    do
        partirLinea "$linea" $_ancho_linea_maximo
        echo ""
    done < $_fichero
}

function partirLinea(){
    local _linea=$1
    local _ancho_linea_maximo=$2

    local _ancho_palabra
    local _ancho_linea_actual=0
    
    for palabra in $_linea
    do
        _ancho_palabra=${#palabra}
        #       77 caracteres      +  10 caracteres  >   80 caracteres
        if (( $_ancho_linea_actual + $_ancho_palabra > $_ancho_linea_maximo ))
        then
            # Como con esa palabra nueva, me pararia del ancho maximo, la 
            # palabra la pongo en una linuea nueva... y empiezo a contar
            echo ""
            echo -n "$palabra "
            let _ancho_linea_actual=0+$_ancho_palabra+1
        else 
            # La palabra entra en la linea actual. La escribo y sumo
            echo -n "$palabra "
            let _ancho_linea_actual=$_ancho_linea_actual+$_ancho_palabra+1
        fi
    done
}

fichero=texto.txt
ancho=50

partirTextos $fichero $ancho

