# Convertidor A/D

## Laboratori
- [Source code previ](#source-code-previ)
- [Source code sobre](#source-code-sobre)
- [Schematic capture sobre](#schematic-capture)

### Source code previ

```
#include <xc.h>
#define _XTAL_FREQ 8000000  

#include <string.h>
#include "config.h"
#include "GLCD.h"

const char * s1 = "AN0: \0";
const char * s2 = "AN1: \0";
const char * s3 = "AD \0";
const char * s4 = "mV \0";

void configGLCD(){
      PORTD=0; 		   //Donem uns valors inicials als ports
      PORTB=0;  
      TRISD=0x00;		   //Configurem D i B de sortida
      TRISB=0x00;
      GLCDinit();		   //Inicialitzem la pantalla	
      clearGLCD(0,7,0,127);      //Esborrem pantalla
      setStartLine(0);           //Definim linia d'inici
}

void configPIC() {
   TRISA = 0xFF; // PORTA entrada
   ADON = 1;	// Mòdul de conversió activat
   VCFG1 = 0;	// Vref = Vss
   VCFG0 = 0;	// Vref = Vdd
   PCFG3 = 1 ; PCFG2 = 1; PCFG1 = 0; PCFG0 = 1;	//AN1 y AN0 Analogicas
   ADFM = 0;	// Justificat a la esquerra
   ACQT2 = 1; ACQT1 = 0; ACQT0 = 1;	// TAD = 12
   ADCS2 = 0; ADCS1 = 0; ADCS0 = 1;	// Fosc/8
}

void writeTxt(byte page, byte y, char * s) {
	int i=0;
	while (*s!='\n' && *s!='\0') { 
		putchGLCD(page, y+i, *(s++));
		i++;
	};
}	
   
double udist = 26.0/1023.0; 
double uangle = 300.0/1023.0; 
int angle;
int distancia;
double vdist;
double vangle;


   void calculaDistancia(){
      ADCON0bits.CHS3 = 0; ADCON0bits.CHS2 = 0; ADCON0bits.CHS1 = 0; ADCON0bits.CHS0 = 1; //LECTURA DEL CANAL 1 -> AN1
      GO = 1;
      while(GO);//Es baixarà quan s'hagi fet l'adquisició
      int n = ADRESH & 0x03; //ignorem els bits de menys pes
      n =  n<< 8; //shift a la izquierda
      n = n | ADRESL; //concatenar n y ADRESL
      distancia =  n;
      vdist = (distancia/1023.)*5000;
      }
   void calculaAngle(){
      ADCON0bits.CHS3 = 0; ADCON0bits.CHS2 = 0; ADCON0bits.CHS1 = 0; ADCON0bits.CHS0 = 0; //LECTURA DEL CANAL 0 -> AN0
      GO = 1;
      while(GO);//Es baixarà quan s'hagi fet l'adquisició
      int n = ADRESH;	//ignorem els bits de menys pes
      n = n << 2;
      n= n | (ADRESL & 0xC0);	//concatenar n y ADRESL
      angle =  n;
      vangle = (angle/1023.)*5000;
   }

   
void main(void){
      configPIC();
      configGLCD();
      while(1){
	 calculaDistancia();
	 calculaAngle();
	 clearGLCD(0,7,0,127); 
	 writeTxt(1,4, s1);
	 if (angle != 0){
	    writeNum(1,10,angle);
	    writeNum(3,10,vangle);
	 }
	 else {
	    putchGLCD(1,10,48);
	    putchGLCD(3,10,48);
	 }
	 writeTxt(1,15, s3);
	 writeTxt(3,15, s4);
	 writeTxt(5,4, s2);
	 if (distancia != 0){
	    writeNum(5, 10, distancia);
	    writeNum(7, 10, vdist);
	 }
	 else{
	    putchGLCD(5,10,48);
	    putchGLCD(7,10,48);
	 }  
	 writeTxt(5,15, s3);
	 writeTxt(7,15, s4);
	 for(int i = 0; i < 100; ++i) __delay_ms(5);
      }
}

/* TAULA DE VALORS
Angulo:

	Minimo: 0 grados - 557mV
	
	Int1: 50 grados - 1334mv
	Int2: 90 grados - 1901mV
	Int3: 140 grados - 2756mv

	Maximo: 180 grados - 3616mv

Dist:

	Minimo: 4 cm - 2605mV
	
	Int1: 8 cm - 1412mV
	Int2: 12 cm - 943mv
	Int3: 16 cm - 698mv

	Maximo: 20 cm - 532mV
	*/

### Source code sobre

```
#include <xc.h>
#define _XTAL_FREQ 8000000  

#include <string.h>
#include "config.h"
#include "GLCD.h"

const char * s1 = "AN0: \0";
const char * s2 = "AN1: \0";
const char * s3 = "AD \0";
const char * s4 = "mV \0";

void configGLCD(){
      PORTD=0; 		   //Donem uns valors inicials als ports
      PORTB=0;  
      TRISD=0x00;		   //Configurem D i B de sortida
      TRISB=0x00;
      GLCDinit();		   //Inicialitzem la pantalla	
      clearGLCD(0,7,0,127);      //Esborrem pantalla
      setStartLine(0);           //Definim linia d'inici
}

void configPIC() {
   TRISA = 0xFF; // PORTA entrada
   ADON = 1;	// Mòdul de conversió activat
   VCFG1 = 0;	// Vref = Vss
   VCFG0 = 0;	// Vref = Vdd
   PCFG3 = 1 ; PCFG2 = 1; PCFG1 = 0; PCFG0 = 1;	//AN1 y AN0 Analogicas
   ADFM = 0;	// Justificat a la esquerra
   ACQT2 = 1; ACQT1 = 0; ACQT0 = 1;	// TAD = 12
   ADCS2 = 0; ADCS1 = 0; ADCS0 = 1;	// Fosc/8
}

void writeTxt(byte page, byte y, char * s) {
	int i=0;
	while (*s!='\n' && *s!='\0') { 
		putchGLCD(page, y+i, *(s++));
		i++;
	};
}	
   
double udist = 26.0/1023.0; 
double uangle = 300.0/1023.0; 
int angle;
int distancia;
double vdist;
double vangle;


   void calculaDistancia(){
      ADCON0bits.CHS3 = 0; ADCON0bits.CHS2 = 0; ADCON0bits.CHS1 = 0; ADCON0bits.CHS0 = 1; //LECTURA DEL CANAL 1 -> AN1
      GO = 1;
      while(GO);//Es baixarà quan s'hagi fet l'adquisició
      int n = ADRESH & 0x03; //ignorem els bits de menys pes
      n =  n<< 8; //shift a la izquierda
      n = n | ADRESL; //concatenar n y ADRESL
      distancia =  n;
      vdist = (distancia/1023.)*5000;
      }
   void calculaAngle(){
      ADCON0bits.CHS3 = 0; ADCON0bits.CHS2 = 0; ADCON0bits.CHS1 = 0; ADCON0bits.CHS0 = 0; //LECTURA DEL CANAL 0 -> AN0
      GO = 1;
      while(GO);//Es baixarà quan s'hagi fet l'adquisició
      int n = ADRESH;	//ignorem els bits de menys pes
      n = n << 2;
      n= n | (ADRESL & 0xC0);	//concatenar n y ADRESL
      angle =  n;
      // angle = -33.65671845963192 + 0.05608431295420129n + 0.00000828527377937765n2 - 2.06462252978e-9n3
      vangle = (angle/1023.)*5000;
   }

   
void main(void){
      configPIC();
      configGLCD();
      while(1){
	 calculaDistancia();
	 calculaAngle();
	 clearGLCD(0,7,0,127); 
	 writeTxt(1,4, s1);
	 if (angle != 0){
	    writeNum(1,10,angle);
	    writeNum(3,10,vangle);
	 }
	 else {
	    putchGLCD(1,10,48);
	    putchGLCD(3,10,48);
	 }
	 writeTxt(1,15, s3);
	 writeTxt(3,15, s4);
	 writeTxt(5,4, s2);
	 if (distancia != 0){
	    writeNum(5, 10, distancia);
	    writeNum(7, 10, vdist);
	 }
	 else{
	    putchGLCD(5,10,48);
	    putchGLCD(7,10,48);
	 }  
	 writeTxt(5,15, s3);
	 writeTxt(7,15, s4);
	 for(int i = 0; i < 100; ++i) __delay_ms(5);
      }
}

/* TAULA DE VALORS
Angulo:

	Minimo: 0 grados - 557mV
	
	Int1: 50 grados - 1334mv
	Int2: 90 grados - 1901mV
	Int3: 140 grados - 2756mv

	Maximo: 180 grados - 3616mv

Dist:

	Minimo: 4 cm - 2605mV
	
	Int1: 8 cm - 1412mV
	Int2: 12 cm - 943mv
	Int3: 16 cm - 698mv

	Maximo: 20 cm - 532mV
*/

```
