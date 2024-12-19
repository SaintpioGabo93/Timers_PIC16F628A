; CONFIG
; __config 0xFF59
 __CONFIG _FOSC_INTOSCCLK & _WDTE_OFF & _PWRTE_OFF & _MCLRE_OFF & _BOREN_ON & _LVP_OFF & _CPD_OFF & _CP_OFF

;Configuracion de variables para el codigo
    cblock  0x20    ; El cblock nos permite de manera eficiente, asignar un espacio de memoria consecutivo a partir de la direccion por el numero de variables que asignamos
    ; temp1 esta variable la vamos a poner el el archivo de inclusion
    endc

;Configuracion del pic y todas sus palabras claves
    list p=16f628a
    #include "/opt/microchip/mplabx/v5.20/mpasmx/p16lf628a.inc"

;Iniciamos el programa
    org 0x00

; Iniciamos nuestro programa
    bsf     STATUS, 5   ; vamos al banco 1
    clrf    TRISB      ; Ponemos todos los bits del TRISB en 0, o sea, que están configuradas como salidas.
    movlw   b'00000111' ; Cargamos todos los bits como determinamos en el archivo readme para que el prescaler sea 256 en modo timer
    movwf   OPTION_REG  ; El valor que cargamos en la instrucción anterior, lo escribimos en el OPTION_REG
    bcf     STATUS, 5   ; Regresamos al banco 0

; Encedemos el LED
    bsf     PORTB, 0    ; El bit 0 del PORTB, queda en HIGH
    movlw   .1500        ; Cargamos el número 100 al registro W. Estos son los milisegundos que haremos
    call    delay_ms    ; Llamamos a la función delay_ms para que se tarde la cantidad de tiempo que

; Apagamos el LED
    bcf     PORTB, 0    ; El bit 0 del PORTB, queda en LOW
    movlw   .1500        ; Cargamos el número 100 al registro W
    call    delay_ms    ; Llamamos a la función de retardo
    goto    $-6         ; Regresamos a bsf PORTB, 0, o sea a HIGH

    ; Vamos a utilizar el archivo de inclusion que hicimos al que le pusimos el codigo para el delay
    #include <delay.INC>
    end

    
    