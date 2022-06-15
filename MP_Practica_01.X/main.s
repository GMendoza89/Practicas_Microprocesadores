
 ;PIC18F4550 Configuration Bit Settings

; Assembly source line config statements
;PROCESSOR 18F4550

; PIC18F4550 Configuration Bit Settings

; Assembly source line config statements

#include <xc.inc>
; CONFIG1H
  CONFIG  FOSC = HS             ; Oscillator Selection bits (HS oscillator (HS))
; CONFIG2L
  CONFIG  PWRT = ON            ; Power-up Timer Enable bit (PWRT disabled)
; CONFIG2H
  CONFIG  WDT = OFF             ; Watchdog Timer Enable bit (WDT disabled (control is placed on the SWDTEN bit))
; CONFIG3H
  CONFIG  PBADEN = OFF          ; PORTB A/D Enable bit (PORTB<4:0> pins are configured as digital I/O on Reset)
  CONFIG  MCLRE = ON            ; MCLR Pin Enable bit (MCLR pin enabled; RE3 input pin disabled)
; CONFIG4L
  CONFIG  LVP = OFF             ; Single-Supply ICSP Enable bit (Single-Supply ICSP disabled)



PSECT _main, CLASS = CODE, reloc=2
 

 _main:
    goto INICIO
    
  PSECT CODE
  INICIO:
    counterOne EQU 020h
    counterTwo EQU 021h
    CLRF PORTD
    CLRF LATD
    clrf TRISD
LOOP:    
    movlw 00fh
    decf LATD
    goto delay
delay:
    decfsz counterOne
    goto delay
    decfsz counterTwo
    goto delay
    goto LOOP
    
    
END _main
    