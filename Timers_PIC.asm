; CONFIG
; __config 0xFF59
 __CONFIG _FOSC_INTOSCCLK & _WDTE_OFF & _PWRTE_OFF & _MCLRE_OFF & _BOREN_ON & _LVP_OFF & _CPD_OFF & _CP_OFF
    
    list p=16f628a
    #include "/opt/microchip/mplabx/v5.20/mpasmx/p16lf628a.inc"
    org 0x00
    
    ; Iniciamos nuestro programa
    bsf		status, 5   ; vamos al banco 1
    clrf	trisb	    ; Ponemos todos los bits del trisb en 0, o sea, que estan configuradas como salidas. 
    bcf		status, 5   ; Regresamos al banco 0
    
    ; Encedemos el LED
    bsf		portb, 0    ; El bit 0 del PORTB, queda en HIGH
    movlw	.100	    ; Cargamos el numero 100 al registro w
    call	delay_ms    ; Llamamos a la funcion delay_ms para que se tarde la cantidad de tiempo que 
    
    ; Apagamos el LED
    bcf		portb, 0    ; El bit 0 del PORTB, queda en LOW
    movlw	.100	    ; Cargamos el numero 100 al registro w
    call	delay_ms    ; Llamamos a la funcion de retardo
    goto	$-6	    ; Regregamos a bsf portb, 0, o sea a hig :v
    
    end