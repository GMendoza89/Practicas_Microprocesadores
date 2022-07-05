
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
    goto STARTMAIN
    
  PSECT CODE
STARTMAIN:
    ;Configurando Pines A0 a A5 como entradas digitales
    CLRF PORTA
    CLRF LATA
    MOVLW 0x0F
    MOVWF 0x07
    MOVWF CMCON
    MOVLW 0x3F
    MOVWF TRISA
    ;configurando Puerto B como entrada digital
    CLRF PORTB
    CLRF LATB
    MOVLW 0x0E
    MOVWF ADCON1
    MOVLW 0xFF
    MOVWF TRISB,F
    ;configurando puerto C
    CLRF PORTC
    CLRF LATC
    MOVLW 0xF0
    MOVWF TRISC,F
    ;configurando puerto D
    CLRF PORTD
    CLRF LATC
    CLRF LATD
    CLRF TRISD
    
LOOP:    
    BTFSC PORTC,4
    GOTO add
    BTFSC PORTC,3
    GOTO andAB
    GOTO LOOP
delay:
    decfsz counterOne
    goto delay
    decfsz counterTwo
    goto delay
    goto LOOP
add:
    MOVF PORTA,W
    ADDWF PORTB,W
    MOVWF PORTD
    goto LOOP
andAB:
    MOVF PORTA,W
    ANDWF PORTB,W
    MOVWF PORTD
    goto LOOP
     
END _main








