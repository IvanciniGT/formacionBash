#!/bin/bash

# < > Ficheros &9 FileDescriptor

# PROCESO 
# Tiene un ID  -> pid
# Tiene un ID del padre -> ppid
# Tiene una entrada estandar    0   <<<<< &0
# Tiene una salida estandar     1   >>>>> &1
# Tiene una salida de error     2   >>>>> &2

echo HOLA &  # GENERA UN PROCESO NUEVO

echo HOLA 1> ./salidaEstandarDelEcho.txt
echo HOLA  > ./salidaEstandarDelEcho.txt

(echo COPIANDO && cp hola hola2) 2> ./salidaError.txt

(echo COPIANDO && cp hola hola2) 1> ./salidaNuevaEstandar.txt 2> ./salidaError.txt 

(echo ESTA ES BUENA && cp hola hola2) 1> ./salidaGeneral.txt 2>> ./salidaGeneral.txt

(echo ESTA ES MEJOR && cp hola hola2) 1> ./salidaGeneral.txt 2>&1

(echo ESTA ES RARA && cp hola hola2) 2>&1 1> ./salidaGeneral.txt 
# 1 Salida estandar
# 1 es lo que hay conectado a la salida estandar: TERMINAL

echo ESTO ES UN FICHERO 1> fichero
echo ESTO ES UN FICHERO > fichero

exec 3<> fichero     # Abriendo el fichero en modo LECTURA Y ESCRITURA

echo HOLA AMIGO >&3
#read -n 4 
#read -n 4 <&0
read -n 4 LEIDO < fichero

echo $LEIDO

read -n 8 LEIDO <&3
echo $LEIDO

exec 3>&-







#coproc PROCESO1 { echo HOLA; } # Es como un &... Lanza el proceso en segundo plano

#sleep 300 &
#echo $!
#echo ${PROCESO1_PID}

# ${PROCESO1[0]}
# ${PROCESO1[1]}


#coproc PROCESO2 { read variable; echo $variable; }

#${PROCESO2[1]}=${PROCESO1[0]}
# 0 Salida Estandar
# 1 Entrada estandar


#coproc PUBLICADOR { echo HOLA; }
#read variable <&"${PUBLICADOR[0]}"
echo ESTE ES EL RESULTADO $variable







coproc E { echo ESTO ES UNA FRASE; }
coproc D { read variable ; echo LEIDO DESDE EL LECTOR: $variable; } <&${E[0]} 