# PWM (Modulació per amplada de pols)

## Laboratori

- [Source code previ](#source-code-previ)
- [Source code sessió](#source-code-sessió)
- [Source code sobre](#source-code-sobre)
- [Schematic capture](#schematic-capture)

### Source code previ

```
#include <xc.h>
#include "config.h"

#define RC2 PORTCbits.PINC2
#define _XTAL_FREQ 8000000

int contador = 0; //indica cuando han pasado 4 ms
int i = 0; //indica numero de incrementos de CCPR1L

void config_PIC(void){
   TRISC = 0x00;
   INTCONbits.GIE = 1;    
   PIE1bits.TMR2IE = 1;
   INTCONbits.PEIE = 1;       
   T2CONbits.T2CKPS1 = 1;   
   PR2 = 124; // PWM period = (PR2+1) * prescaler * TI = 1ms
   CCP1CONbits.CCP1M3 = 1;
   CCP1CONbits.CCP1M2 = 1;  
   CCPR1L = 0;
   CCP1CONbits.DC1B1 = 0;
   CCP1CONbits.DC1B0 = 0; 
   T2CONbits.TMR2ON = 1; 
}


void interrupt timer2(void) {
   if (PIR1bits.TMR2IF) { //1 ms
      ++contador;
      if (contador == 6) { //4 ms
	 contador = 0;
	 ++i;
	 if (i <= 124) ++CCPR1L; // duty-cycle oscil·la entre 0 i 100%
	    if (i > 125) --CCPR1L; // duty-cycle oscil·lant entre 100 i 0%
	       if (i >= 249) { // ha pasado un segundo
		  i = 0;
		  CCPR1L = 0;
	 }               
      }
      PIR1bits.TMR2IF = 0;
   }
}

int main(void)
{
   config_PIC();
   while(1);
}
```

### Source code sessió

```
#include <xc.h>
#include "config.h"

#define RC2 PORTCbits.PINC2
#define _XTAL_FREQ 8000000

int contador = 0; //indica cuando han pasado 4 ms
int i = 0; //indica numero de incrementos de CCPR1L

void config_PIC(void){
   TRISC = 0x00;
   INTCONbits.GIE = 1;    
   PIE1bits.TMR2IE = 1;
   INTCONbits.PEIE = 1;       
   T2CONbits.T2CKPS1 = 1;   // Enable TMR2 with prescaler = 16
   PR2 = 124; // PWM period = (PR2+1) * prescaler * TI = 1ms
   CCP1CONbits.CCP1M3 = 1; // Enable PWM on CCP1
   CCP1CONbits.CCP1M2 = 1;  
   CCPR1L = 0;
   CCP1CONbits.DC1B1 = 0;
   CCP1CONbits.DC1B0 = 0; 
   T2CONbits.TMR2ON = 1; 
}

void interrupt timer2(void) {
   if (PIR1bits.TMR2IF) { //1 ms
      ++contador;
      if (contador == 6) { //6 ms
	 contador = 0;
	 ++i;
	 if (i <= 124) CCPR1L++; // duty-cycle oscil·la entre 0 i 100%
	 if (i > 125) CCPR1L--; // duty-cycle oscil·lant entre 100 i 0%
	 if (i >= 249) { // ha pasado 1,6s
		  i = 0;
		  CCPR1L = 0;
	 }               
      }
      PIR1bits.TMR2IF = 0;
   }
}

int main(void)
{
   config_PIC();
   while(1);
}
```
### Source code sobre

```
#include <xc.h>
#include "config.h"

#define RC2 PORTCbits.PINC2
#define _XTAL_FREQ 8000000
#define RA1 PORTAbits.PINA1
#define RA0 PORTAbits.PINA0

#define RD0 PORTDbits.PIND0
#define RD1 PORTDbits.PIND1
#define RD2 PORTDbits.PIND2
#define RD3 PORTDbits.PIND3
#define RD4 PORTDbits.PIND4
#define RD5 PORTDbits.PIND5
#define RD6 PORTDbits.PIND6

#define DO 479
#define RE 451
#define MI 426
#define FA 401
#define SOL 379
#define LA 358
#define SI 339

int contador = 0; //indica cuando han pasado 4 ms
int i = 0; //indica numero de incrementos de CCPR1L

void config_PIC(void){
   TRISD = 0xFF;
   TRISA = 0xFF;
   INTCONbits.GIE = 1;    
   PIE1bits.TMR2IE = 1;
   INTCONbits.PEIE = 1;       
   T2CONbits.T2CKPS1 = 1;   // Enable TMR2 with prescaler = 16
   PR2 = 124; // PWM period = (PR2+1) * prescaler * TI = 1ms
   CCP1CONbits.CCP1M3 = 1; // Enable PWM on CCP1
   CCP1CONbits.CCP1M2 = 1;  
   CCPR1L = 31;
   CCP1CONbits.DC1B1 = 0;
   CCP1CONbits.DC1B0 = 0; 
   T2CONbits.TMR2ON = 1; 
}

void interrupt timer2(void) {
   if (PIR1bits.TMR2IF) {
      if(RA1 && CCPR1L<61)CCPR1L +=10;
      if(RA0 && CCPR1L>1)CCPR1L -=10;
      PIR1bits.TMR2IF = 0;
   }
}

int main(void)
{
   config_PIC();
   if(RD6) PR2 = DO;
   if(RD5) PR2 = RE;
   if(RD4) PR2 = MI;
   if(RD3) PR2 = FA;
   if(RD2) PR2 = SOL;
   if(RD1) PR2 = LA;
   if(RD0) PR2 = SI;   
   while(1);
}
```

### Schematic capture previ and sessió

![Screenshot](https://github.com/dumitrux/CI-FIB/blob/master/L8/L8.JPG)
