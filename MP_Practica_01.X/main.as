
; PIC18F4550 Configuration Bit Settings

; Assembly source line config statements

#include <xc.inc>
processor 18f4550
; CONFIG1L
  CONFIG  PLLDIV = 1            ; PLL Prescaler Selection bits (No prescale (4 MHz oscillator input drives PLL directly))
  CONFIG  CPUDIV = OSC1_PLL2    ; System Clock Postscaler Selection bits ([Primary Oscillator Src: /1][96 MHz PLL Src: /2])
  CONFIG  USBDIV = 1            ; USB Clock Selection bit (used in Full-Speed USB mode only; UCFG:FSEN = 1) (USB clock source comes directly from the primary oscillator block with no postscale)
  
  config WDT = OFF
; CONFIG1H
  CONFIG  FOSC = HS             ; Oscillator Selection bits (HS oscillator (HS))
  CONFIG  FCMEN = OFF           ; Fail-Safe Clock Monitor Enable bit (Fail-Safe Clock Monitor disabled)
  CONFIG  IESO = OFF            ; Internal/External Oscillator Switchover bit (Oscillator Switchover mode disabled)


; CONFIG3H
  CONFIG  CCP2MX = ON           ; CCP2 MUX bit (CCP2 input/output is multiplexed with RC1)
  CONFIG  PBADEN = OFF          ; PORTB A/D Enable bit (PORTB<4:0> pins are configured as digital I/O on Reset)
  CONFIG  LPT1OSC = OFF         ; Low-Power Timer 1 Oscillator Enable bit (Timer1 configured for higher power operation)
  CONFIG  MCLRE = ON            ; MCLR Pin Enable bit (MCLR pin enabled; RE3 input pin disabled)

  #define FOSC 40000000

org 0
  
counterOne EQU 0X00
counterTwo EQU 0X01
 
Star:
    clrf PORTD,1
    clrf TRISD,1
    clrf counterOne,1
    clrf counterTwo,1
mainLoop:
    bcf	PORTD,0,1
    bcf	PORTD,1,1
    bcf	PORTD,2,1
    bcf	PORTD,3,1
    bcf	PORTD,4,1
    bcf	PORTD,5,1
    bcf	PORTD,6,1
    bcf	PORTD,7,1
    call delayOne
    bsf	PORTD,0,1
    bsf	PORTD,1,1
    bsf	PORTD,2,1
    bsf	PORTD,3,1
    bsf	PORTD,4,1
    bsf	PORTD,5,1
    bsf	PORTD,6,1
    bsf	PORTD,7,1
    call delayOne
    goto mainLoop
delayOne:
    decfsz counterOne,1,1
    goto delayOne
    decfsz counterTwo,1,1
    goto delayOne
    return 0

END