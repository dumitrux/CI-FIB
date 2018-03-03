# Gestió de Timers (Aplicació: Croòmetre resetejable)

## Laboratori previ

- [Source code](#source-code-previ)
- [Schematic capture](#schematic-capture-previ)

### Source code

```
#include <xc.h>
#include "config.h"
#include "GLCD.h"
#define PINA0 PORTAbits.RA0
#define _XTAL_FREQ 8000000

int estat = 0, mins = 0, segs = 0, decs = 0;
const char * s1 = "Cronometre \n";
const char * s2 = "mm:ss.d \n";

void configPIC () {
   
   PORTD=0; 		//Donem uns valors inicials als ports
   PORTB=0;  		
   PORTA = 0;
   TRISD = 0x00;	//Configurem D i B de sortida
   TRISB = 0x00;	
   TRISA = 0xFF;	// A entrada
   ADCON1=0x0F;		// Ports digitals
   INTCON = 0xA0; 	// Interrupciones activadas, TMR0IE = 1. Activa las interrupciones por overflow de Timer0
   RCON = 0;		// IPEN = 0
   T0CON = 0x04;	// Configuracion Timer0 (Prescaler 1:32)
   TMR0H = 0xE7;	// Contador inicializado a 59285 
   TMR0L = 0x95;
}
void writeTxt(byte page, byte y, char * s) {
	int i=0;
	while (*s!='\n' && *s!='\0') { 
		putchGLCD(page, y+i+1, *(s++));
		i++;
	}
}	
void Cabecera()
{
	writeTxt(2,5, s1);
	writeTxt(4,6, s2);
}
void tic () {
   if (mins == 0) {
      putchGLCD(6,7,'0');
      putchGLCD(6,8,'0');
   }
   else if (mins < 10) {
      putchGLCD(6,7,'0');
      writeNum (6,8,mins);
   }
   else writeNum(6,7,mins);
   putchGLCD(6,9,':');
   if (segs == 0) {
      putchGLCD(6,10,'0');
      putchGLCD(6,11,'0');
   }
   else if (segs < 10) {
      putchGLCD(6,10,'0');
      writeNum (6,11,segs);
   }
   else 
      writeNum (6,10,segs);
   putchGLCD(6,12,'.');
   if (decs == 0) putchGLCD(6,13,'0');
   else writeNum (6,13,decs);
}

void interrupt timer(void){
   if(TMR0IE && TMR0IF){
      TMR0H = 0xE7;
      TMR0L = 0x95;
      TMR0IF = 0;
      decs++;
      if (decs == 10) {
	 decs = 0;
	 segs++;
	 if (segs == 60) {
	    segs = 0;
	    mins ++;
	 }
      }
   }
}

void main(void){       
   configPIC();
   GLCDinit();		    
   clearGLCD(0,7,0,127);      
   setStartLine(0);
   Cabecera();
   while (1) {
      tic();
      if (PINA0) {
	 __delay_ms(10);
	 if (PINA0) {
	    if (estat == 0) {
	    estat++;
	    TMR0ON = 1;
	    }
	    else if (estat == 1) {
	       estat++;
	       TMR0ON = 0;
	    }
	    else {
	       estat = 0;
	       decs = segs = mins = 0;
	    }
	    while (PINA0) tic();
	  }
      }
   }   
 }
```
### Schematic capture
