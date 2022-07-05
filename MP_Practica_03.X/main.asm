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
    MOVLW 00Fh
    MOVWF ADCON1
    MOVLW 007h
    MOVWF CMCON
    MOVLW 03Fh
    MOVWF TRISA,F
    ;configurando Puerto B como entrada digital
    CLRF PORTB
    CLRF LATB
    MOVLW 00Eh
    MOVWF ADCON1
    SETF TRISB
    ;configurando puerto C
    CLRF PORTC
    CLRF LATC
    MOVLW 0F0h
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





