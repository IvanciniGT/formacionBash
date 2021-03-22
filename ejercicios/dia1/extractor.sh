log_apache="10.185.248.71 - - [09/Jan/2015:19:12:06 +0000] 808840\
    \"GET /inventoryService/inventory/purchaseItem?userId=20253471&itemId=23434300 HTTP/1.1\" 
    500 17 \"-\" \"Apache-HttpClient/4.2.6 (java 1.5)\""

# Extraer la IP
ip=${log_apache%" - -"*}

# Extraer la fecha
todo_hasta_la_fecha=${log_apache%"]"*}
la_fecha=${todo_hasta_la_fecha#*"["}
echo La fecha es: ${la_fecha}


echo La IP es: ${ip}