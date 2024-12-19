; Aqui vamos a 

cblock		; Aqui nos va a traer del codigo principal, ya no ponemos la direccion de la memoria
temp1		; Determinamos la variable
endc		; Usamos este para mandar al archivo principal

; Parte de la función para que el bucle del milisegundo se ejecute 100 veces
delay_ms:
    movwf   temp1      ; Movemos la información que teníamos cargada en movlw a la variable temp1
    call    delay_1ms  ; Vamos a la función de 1 milisegundo
    decfsz  temp1, 1   ; Si el destino (1) vale 0, el valor se asigna a W, si el destino(1) vale 1, entonces temp1 = temp1 - 1, y si temp1 - 1 = 0 entonces salta una instrucción
    goto    $-2        ; Si la instrucción anterior no fue 0, llega a esta instrucción para regresar a la función delay_1ms 
    return

; Creamos el bucle para contar el milisegundo
delay_1ms:
    clrf    TMR0      ; Ponemos el TMR0, todo a cero
    btfss   TMR0, 2   ; Testeamos el bit 2 hasta que dé 1, recordemos que como ya configuramos el OPTION_REG en sus últimos 3 bits a uno, ya se va a tardar 256 microsegundos
    goto    $-1       ; En caso de que no sea 1 el bit anterior, llegará a esta instrucción y regresará a la instrucción anterior hasta que se cumpla la condición
    return            ; Esto ocurre cuando llega al valor, porque se salta una instrucción con la instrucción btfss
