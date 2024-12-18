; CONFIG
; __config 0xFF59
 __CONFIG _FOSC_INTOSCCLK & _WDTE_OFF & _PWRTE_OFF & _MCLRE_OFF & _BOREN_ON & _LVP_OFF & _CPD_OFF & _CP_OFF

;Configuracion de variables para el codigo
    temp1 equ 0x20 ; Creamos una variable de nombre temp1 en la direccion 0x20 de la memoria de datos

;Configuracion del pic y todas sus palabras claves
    list p=16f628a
    #include "/opt/microchip/mplabx/v5.20/mpasmx/p16lf628a.inc"

;Iniciamos el programa
    org 0x00

; Iniciamos nuestro programa
    bsf     STATUS, 5   ; vamos al banco 1
    clrf    TRISB      ; Ponemos todos los bits del TRISB en 0, o sea, que est�n configuradas como salidas.
    movlw   b'00000111' ; Cargamos todos los bits como determinamos en el archivo readme para que el prescaler sea 256 en modo timer
    movwf   OPTION_REG  ; El valor que cargamos en la instrucci�n anterior, lo escribimos en el OPTION_REG
    bcf     STATUS, 5   ; Regresamos al banco 0

; Encedemos el LED
    bsf     PORTB, 0    ; El bit 0 del PORTB, queda en HIGH
    movlw   .100        ; Cargamos el n�mero 100 al registro W
    call    delay_ms    ; Llamamos a la funci�n delay_ms para que se tarde la cantidad de tiempo que

; Apagamos el LED
    bcf     PORTB, 0    ; El bit 0 del PORTB, queda en LOW
    movlw   .100        ; Cargamos el n�mero 100 al registro W
    call    delay_ms    ; Llamamos a la funci�n de retardo
    goto    $-6         ; Regresamos a bsf PORTB, 0, o sea a HIGH

; Parte de la funci�n para que el bucle del milisegundo se ejecute 100 veces
delay_ms:
    movwf   temp1      ; Movemos la informaci�n que ten�amos cargada en movlw a la variable temp1
    call    delay_1ms  ; Vamos a la funci�n de 1 milisegundo
    decfsz  temp1, 1   ; Si el destino (1) vale 0, el valor se asigna a W, si el destino(1) vale 1, entonces temp1 = temp1 - 1, y si temp1 - 1 = 0 entonces salta una instrucci�n
    goto    $-2        ; Si la instrucci�n anterior no fue 0, llega a esta instrucci�n para regresar a la funci�n delay_1ms 
    return

; Creamos el bucle para contar el milisegundo
delay_1ms:
    clrf    TMR0      ; Ponemos el TMR0, todo a cero
    btfss   TMR0, 2   ; Testeamos el bit 2 hasta que d� 1, recordemos que como ya configuramos el OPTION_REG en sus �ltimos 3 bits a uno, ya se va a tardar 256 microsegundos
    goto    $-1       ; En caso de que no sea 1 el bit anterior, llegar� a esta instrucci�n y regresar� a la instrucci�n anterior hasta que se cumpla la condici�n
    return            ; Esto ocurre cuando llega al valor, porque se salta una instrucci�n con la instrucci�n btfss
    end

    
    