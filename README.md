# Timers_PIC16F628A
Repositorio para ejercicio de codigo con Timers en ensamblador para el PIC16F628A

256x4 -> Este es porque vamos a multiplicar nuestros 4Mhz por 256, que es poner los bits PS3 = 1. PS2 = 1, PS0 = 1


Vamos a poner el ejemplo con los bits del registro TMR0
Los bits 7 y 6, no nos interesan, por lo que su valor va a ser 0
RBPU = 0
INTEDEG = 0

Recordemos que el bit 5 es para determinar si queremos que sea un timer = 0, o un contador = 1. 
Por lo que, como queremos que sea timer, lo ponemos en 0
TOCS = 0

El bit 4, es cuando lo configuramos como contador, por lo que no nos interesa
TOSE = 0

El bit 3, es para elegir en que timer vamos a usar el prescalar, si en TMR0 = 0, o en WDT = 1
Como lo queremos en el TMR; entonces:
PSA = 0

Y los ultimos tres bits, son los bits escalares. 
PS2 = 1
PS1 = 1
PS0 = 1



RBPU	INTEDEG	TOCS	TOSE	PSA	PS2	PS1	PS0
0	  0	 0	 0	 0	 1	 1	 1

Con esto tenemos que el TMR0 se aumenta cada 256 ciclos de instrucción, o sea 256 x 1 microsegundo	


Vamos a hacer las matemáticas: 

TMR0 

00000000 -> Cuando ponemos el TMR0 a cero
00000001 -> Despues de 256 microsegundos
00000010 -> Despues de otros 256 microsegundos
00000011 -> Despues de otros 256 microsegundos
00000100 -> Este es el bit que vamos a testear hasta que de 4, asi pasa despues de que pasaron 256 microsegundos x 4 veces que hubo ciclos de reloj

Así 256micros + 256micros + 256micros + 256micros = 1024 microsegundo



