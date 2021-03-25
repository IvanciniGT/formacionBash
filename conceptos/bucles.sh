
function contar1(){
    MAXIMO=10
    while (( $MAXIMO > 0 ))
    do
        echo Voy por el $MAXIMO
        let MAXIMO=$MAXIMO-1
    done
}

function contar2(){
    for numero in 1 2 3 4 5 6 7 8 9 10
    do
        echo Voy por el $numero
    done
}

function contar3(){
    for numero in {1..20..2}
    do
        echo Voy por el $numero
    done
}

function contar4(){
    for numero in $(seq 1 10)
    do
        echo Voy por el $numero
    done
}

function contar5(){
    for (( numero=1; numero < 10; numero++))
    do
        echo Voy por el $numero
    done
}

function contar6(){
    MAXIMO=1
    until (( $MAXIMO >= 10 ))
    do
        echo Voy por el $MAXIMO
        let MAXIMO=$MAXIMO+1
    done
}

contar6