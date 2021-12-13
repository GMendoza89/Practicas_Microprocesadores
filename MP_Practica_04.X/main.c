/*
 * File:   main.c
 * Author: Ing Gustavo David Mendoza Pinto
 *Control de Motores con entrada analogica y PWM
 * Created on December 9, 2021, 12:14 PM
 */


#include <xc.h>
#include "configurationbits.h"

void configPWM(char pr2_register);
void writeDutyCicle(char dutyCicle);

void main(void) {
    //configuramos el PWM
    configPWM(0xFF);
    //Configuramos el convertidor analogico digital
    ADCON0 = 0b00000001;
    ADCON1 = 0b00001110;
    ADCON2 = 0b00111111;
    
    //Configuramos el puerto D como entradas y salidas digitales
    
    PORTD = 0x00;
    LATD = 0x00;
    TRISD = 0b00001100; // RD3 y RD2 como Salidas RD1,RD0 como entradas 
    //loop
    while(1){
        while(ADCON0bits.ADON); //Esperamos a que terminen la conversion
        writeDutyCicle(ADRESL);
        CCP1CON = ADRESH;
        PORTDbits.RD3 = PORTDbits.RD1; // Controlamos direccion de los motores
        PORTDbits.RD2 = PORTDbits.RD0; // con el puente H
    
    }
    return;
}

void configPWM(char pr2_register){
    //configurar Registro PR2
    PR2 = pr2_register;
    //Configuramos preescalador de 16
    T2CONbits.T2CKPS = 3;
    //Configuramos bits para PWM
    CCP1CONbits.CCP1M0 = 1;
    CCP1CONbits.CCP1M1 = 1;
    CCP1CONbits.CCP1M2 = 1;
    CCP1CONbits.CCP1M3 = 1;
    
    //Limpiamos registro Timer 2
    TMR2 = 0;
    //Activamos el funcionamiento del Timer 2
    T2CONbits.TMR2ON = 1;
    
    //Configuramos inicialmente para mitad de ciclo de trabajo
    CCPR1L = 0x02;
    CCP1CONbits.DC1B0 = 0;
    CCP1CONbits.DC1B1 = 0;
    //Configuramos el pin RC2 como salida del PWM
    TRISCbits.RC2 = 0;
    
}
void writeDutyCicle(char dutyCicle){
    CCPR1L = dutyCicle;
}