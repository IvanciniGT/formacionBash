#!/bin/bash

source .super_read.sh




PATRON_IP="^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$"
PATRON_SI_NO=^[sn]$
PATRON_NOMBRE_SERVIDOR=^[a-z._-]+$
PATRON_NUMERO_ENTERO_POSITIVO=^[0-9]+$

super_read -p "Dame la IP del servidor donde operar" -d "127.0.0.1" -v ip -r $PATRON_IP
echo La IP del servidor que has escrito es: $ip
    
super_read -p "Estas seguro" -d "s" -v confirmacion -r $PATRON_SI_NO
echo Has contestado: $confirmacion

super_read -p "Reiniciar en cuantos segundos" -d "10" -v reinicio_en -r $PATRON_NUMERO_ENTERO_POSITIVO
echo Voy a reiniciar en $reinicio_en segundos

super_read -p "Dame el nombre del servidor" -v "nombre_servidor" -r $PATRON_NOMBRE_SERVIDOR -f "Nombre de servidor incorrecto"
echo El nombre del servidor es $nombre_servidor
