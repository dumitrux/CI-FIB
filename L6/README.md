# Interrupcions

## Laboratori

- [Source code previ](#source-code-previ)
- [Schematic capture previ and sessió](#schematic-capture-previ-and-sessió)
- [Source code sessió](#source-code-sessió)
- [Source code sobre](#source-code-sobre)
- [Schematic capture sobre](#schematic-capture-sobre)

### Source code previ

```
#include <xc.h>
#include "config.h"

//#define _XTAL_FREQ 8000000 

int cont=0x0;

void configPIC(){
   
 	 ADCON1 = 0x0F; // All ports are digital
	 GIEH = 1;	// Global high priority interrupt enable
	 GIEL = 1;	// Global low priority interrupt enable
	 INT2IF = 0;	// Deshabilitar int2if (IF Flag)
	 INT1IF = 0;	// Deshabilitar int1if
	 INT2IE = 1;	// habilitar int2. Permite señales de interrupcion por pin
	 INT1IE = 1;
	 INT2IP = 0;	// low priority int2
	 INT1IP = 1;	// high priority int1
	 IPEN = 1;
	 TRISD = 0x00;  // D salida
}

void incrementar(void);
void decrementar(void);

void interrupt service_routine_HP(void){// INT1 routine
   if (INT1IF) {
      INT1IF = 0;
      ++cont;
      PORTD = cont;
      }
}

void interrupt low_priority service_routine_LP(void){// INT2 routine
   if (INT2IF) {	
      INT2IF = 0;
      --cont;
      while(INT2);
      PORTD = cont;
      }
}

void main(void){
      configPIC();
      while (1);
 }
```

### Schematic capture previ and sessió

![Screenshot](https://github.com/dumitrux/CI-FIB/blob/master/L6/L6-previ%26sessio.JPG)

### Source code sessió

```
#include <xc.h>
#include "config.h"

#define _XTAL_FREQ 8000000 

//#define _XTAL_FREQ 8000000 

int cont=0x0;

void configPIC(){
   
 	 ADCON1 = 0x0F; // All ports are digital
	 GIEH = 1;	// Global high priority interrupt enable
	 GIEL = 1;	// Global low priority interrupt enable
	 INT2IF = 0;	// Deshabilitar int2if (IF Flag)
	 INT1IF = 0;	// Deshabilitar int1if
	 INT2IE = 1;	// habilitar int2. Permite señales de interrupcion por pin
	 INT1IE = 1;
	 INT2IP = 0;	// low priority int2
	 INT1IP = 1;	// high priority int1
	 IPEN = 1;
	 TRISD = 0x00;  // D salida
	 INTEDG2 = 0;
}

void interrupt rsiHigh(void){// INT1 routine
   if (INT1IE && INT1IF) {
      __delay_ms(20);
      if(INT1){
	 INT1IF = 0;
	 ++cont;
	 PORTD = cont;
      }
   }
}

void interrupt low_priority rsiLow(void){// INT2 routine
   if (INT2IE && INT2IF) {
     __delay_ms(20);
      if(INT2){ 
      INT2IF = 0;
      --cont;
      PORTD = cont;
      }
   }
}

void main(void){
      configPIC();
      while (1);
 }
```

### Source code sobre

```
#include <xc.h>
#include "config.h"

#define _XTAL_FREQ 8000000  

int cont=0x0;
int b4 = 0, b5 = 0;

void configPIC(){
   
 	 ADCON1 = 0x0F; // All ports are digital
	 GIEH = 1;	// Global high priority interrupt enable
	 GIEL = 1;	// Global low priority interrupt enable
	 INT2IF = 0;	// Deshabilitar int2if (IF Flag)
	 INT1IF = 0;	// Deshabilitar int1if
	 INT2IE = 1;	// habilitar int2. Permite señales de interrupcion por pin
	 INT1IE = 1;
	 INT2IP = 0;	// low priority int2
	 INT1IP = 1;	// high priority int1
	 IPEN = 1;
	 TRISD = 0x00;  // D salida
	 INTEDG2 = 0;
	 RBIE = 1;
	 RBIP = 0;
}

void interrupt rsiHigh(void){// rutina d'alta prioritat
   if (INT1IE && INT1IF) {
      __delay_ms(20);
      INT1IF = 0;
      if(INT1){
	 ++cont;
	 PORTD = cont;
      }
   }
}

void interrupt low_priority rsiLow(void){//rutina de baixa prioritat
   if (INT2IE && INT2IF) {
     __delay_ms(20);
     INT2IF = 0;
      if(!INT2){ 
      --cont;
      PORTD = cont;
      }
   }
   if (RBIF && RBIE) {
      __delay_ms(20);
      if(PORTBbits.RB4 && !b4){
	 b4 = 1;
	 cont = 0x00;
	 PORTD = cont;
      }
      if(PORTBbits.RB5 && !b5){
	 b5 = 1;
	 cont = 0xFF;
	 PORTD = cont;
      }
      if(PORTBbits.RB5 && b5) b5= 0;
      if(PORTBbits.RB4 && b4) b4= 0;
      RBIF = 0;
   }
}

void main(void){
      configPIC();
      while (1);
 }
```

### Schematic capture sobre

![Screenshot](https://github.com/dumitrux/CI-FIB/blob/master/L6/L6-sobre.JPG)
