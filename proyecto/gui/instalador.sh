#!/bin/bash

source ./super_read.sh



super_read -p "Que sistema operativo quieres instalar" -v sistema -a="ubuntu redhat debian" -d ubuntu

super_read -p "Dame el paquete a instalar" -v paquete -r ^[a-z-]+$ -d nginx

super_read -p "Estas seguro de querer instalarlo" -v confirmacion -a="s n" -d n

# Estas seguro de querer instalarlo (s/n) [n]:
# Y que valide que el valor esta en esa lista

# Que sistema operativo quieres instalar (ubuntu/redhat/debian): rojo >>> ERROR

sudo apt install $paquete -y