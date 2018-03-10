# Ports d'entrada/sortida

## Laboratori
- [Source code previ](#source-code-previ)
- [Schematic capture previ](#schematic-capture-previ)
- [Source code sessió](#source-code-sessió)
- [Schematic capture sessió](#schematic-capture-sessió)
- [Source code sobre](#source-code-sobre)
- [Schematic capture sobre](#schematic-capture-sobre)

### Source code previ

```
#include <xc.h>
#include "config.h"

#define PINA0 PORTAbits.RA0
#define PINB0 PORTBbits.RB0

void configPIC(){
   ADCON1=0x0F;  // All PORTs are digital
   TRISA=0x00;
   TRISB=0xFF;
}

void main (void) {
   configPIC();
   while(1) {
      PORTA = PORTB;
   }
}
```

### Schematic capture previ

![Screenshot](https://github.com/dumitrux/CI-FIB/blob/master/L5/L5-previ.jpg)

### Source code sessió

```
#include <xc.h>
#include "config.h"
#define _XTAL_FREQ 8000000 
#define PINA0 PORTAbits.RA0
#define PINB0 PORTBbits.RB0

void configPIC(){
   ADCON1=0x0F;  // All PORTs are digital
   TRISA=0x00;
   TRISB=0xFF;
}

void main (void) {
   configPIC();
   while(1) {
      __delay_ms(20);
      if(PORTB == 1) {
	 while (PORTB == 1) __delay_ms(20);
	 if(PORTA == 1) {
	    LATA = 0;
	 }
	 else if (PORTA == 0) {
	    LATA = 1;
	 }
      }
   }
}
```

### Schematic capture sessió

![Screenshot](https://github.com/dumitrux/CI-FIB/blob/master/L5/L5-sessio.JPG)

### Source code sobre

```
#include <xc.h>
#include "config.h"
#include "GLCD.h"
#include <string.h>
#define _XTAL_FREQ 8000000 
#define PINA0 PORTAbits.RA0
#define PINA1 PORTAbits.RA1
#define PINA2 PORTAbits.RA2
#define PINA3 PORTAbits.RA3

#define PINE0 PORTEbits.RE0
#define PINE1 PORTEbits.RE1

void configPIC(){
   ADCON1=0x0F;  // All PORTs are digital
   TRISA=0x00;
   TRISE=0xFF;
   PORTD=0; 		   //Donem uns valors inicials als ports
   PORTB=0;  
   TRISD = 0x00;		   //Configurem D i B de sortida
   TRISB = 0x00;
}

const char * n0 = "Nivell 0\n";
const char * n1 = "Nivell 1\n";
const char * n2 = "Nivell 2\n";
const char * n3 = "Nivell 3\n";
const char * n4 = "Nivell 4\n";


void writeTxt(byte page, byte y, char * s) {
	int i=0;
	while (*s!='\n') { 
		putch(page, y+i, *(s++));
		i++;
	};
}	

void main (void) {
   configPIC();
   GLCDinit();		   //Inicialitzem la pantalla
   clearGLCD(0,7,0,127);      //Borrem pantalla
   setStartLine(0);           //Definim inici
   while(1) {
      __delay_ms(20);
      if(PINE0==1){
	 if(PINA3==1) PINA3=0;
	 else if (PINA2==1) PINA2=0;
	 else if (PINA1==1) PINA1=0;
	 else if (PINA0==1) PINA0=0;
	 __delay_ms(20);   
      }
      if(PINE1==1){
	 if(PINA0==0) PINA0=1;
	 else if (PINA1==0) PINA1=1;
	 else if (PINA2==0) PINA2=1;
	 else if (PINA3==0) PINA3=1;
	 __delay_ms(20);
      }
      	 if(PINA3==1) writeTxt(6, 1, n4);
	 else if (PINA2==1) writeTxt(6, 1, n3);
	 else if (PINA1==1) writeTxt(6, 1, n2);
	 else if (PINA0==1) writeTxt(6, 1, n1);
	 else if (PINA0==0) writeTxt(6, 1, n0);
      while(PINE0==1 || PINE1==1);
   }
}
```

### Schematic capture sobre

![Screenshot](https://github.com/dumitrux/CI-FIB/blob/master/L5/L5-sobre.JPG)

