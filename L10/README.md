# Adquisició i Transmissió de dades (A/D i línia sèrie)

## Laboratori

- [Source code previ](#source-code-previ)
- [Source code sobre](#source-code-sobre)
- [Schematic capture](#schematic-capture)

### Source code previ

```
#include <xc.h>
#define _XTAL_FREQ 8000000 

#define mask 1

#include <string.h>
#include <stdio.h>
#include "config.h"
#include "GLCD.h"

float dist, ang;
int res, i = 0;
char new_data;
char *packet;

const char * s1 = "DISTANCE:";
const char * s2 = "ANGLE:";
const char * s3 = ".";


void interrupt ISR_H () {
   if(INTCONbits.TMR0IE && INTCONbits.TMR0IF){
      INTCONbits.TMR0IF = 0;
      new_data= 1; // Read ADC. New data is avalaible
      TMR0 = 65504;
      T0CONbits.TMR0ON = 0;
   }
}

void InitPic(){
   // Configure ADCON
   ADCON0 = 0x03; //Canal 0
   ADCON1 = 0x0D;
   ADCON2 = 0x91;
   
   // Configure timer 0
   T0CONbits.PSA = 1;		// Timer0 prescaler assigned
   T0CONbits.T0CS = 0;		// Instruction cycle clock
   T0CONbits.T08BIT = 0;	// 8-bit timer
   INTCONbits.TMR0IF = 0;
   INTCONbits.TMR0IE = 1;
   INTCON2bits.TMR0IP = 1;
   
   INTCONbits.GIE = 1;
   
   PORTD=0; 		// Donem uns valors inicials als ports
   PORTB=0;  
   TRISD=0x00;		//Configurem D i B de sortida
   TRISB=0x00;
   
   TRISCbits.RC6 = 0;	// Configurem RC6 de sortida (transmissió)
   TRISCbits.RC7 = 1;	// Configurem RC7 d'entrada (recepció)

   
   // Configuració per transmissió/recepció en sèrie asíncrona 8 bits dades
   TXSTA1 = 0x24;
   SPBRG1 = 0x08;
   PIE1bits.TXIE = 1;	// Enables USART transmit interrupt
   PIE1bits.RCIE = 1;	// Enables USART receive interrupt
   RCSTA1bits.CREN = 1;	// Enables receiver
   RCSTA1bits.SPEN = 1;	// Serial port enabled (configures RX/DT and TX/CK pins as serial port pins)
   
   //BAUDCON (default configuration)  
   
   TXREG = 0;
}

void writeTxt(byte page, byte y, char * s) {
   int i=0;
   while (*s!='\n' && *s!='\0') { 
      putchGLCD(page, y+i, *(s++));
      i++;
   }
}

void InitGLCD (){
   GLCDinit();		   	//Inicialitzem la pantalla
   clearGLCD(0,7,0,127);      	//Esborrem pantalla
   setStartLine(0);           	//Definim linia d'inici
   
   writeTxt(3, 1, s1);
   writeTxt(5, 1, s2);
}

char* INIT_PACKET(){
   sprintf(packet, "INIT\n");
   return packet;
}

char* DATA_PACKET(float angle, float distance){
   sprintf(packet, "DATA,%f,%f\n", angle, distance);

   return packet;
}

void SEND_PACKET() {
   for (int k = 0; k < strlen(packet); k++){ 
      PORTCbits.RC6 = 0;		//Bit start
      __delay_ms(1);
      while(!PIR1bits.TXIF);
      TXREG = packet[k];
      PIR1bits.TXIF = 0;
      /*for (int j = 0; j < 8; j++){
	 if(packet[k] & 0b00000001 == 0) PORTCbits.RC6 = 0;
	 else PORTCbits.RC6 = 1;
	 __delay_ms(1);
	 packet[k] = packet[k] >> 1;
      }*/
      
      PORTCbits.RC6 = 1;		// Bit stop
      __delay_ms(1);
   }
}


void write(int i){
   char buff[8];
   if (i == 0){
      dist = 25.78 - 0.081*res + 0.000075*res*res;
      sprintf(buff, "%f", dist);
      writeTxt(3, 80, buff); 
   }
   else {
     ang = -58.05 + 0.337*res + 0.00002*res*res;
     sprintf(buff, "%f", ang);
     writeTxt(5, 80, buff);
   }
}

void m2d(){
   if(ADCON0bits.GO == 0) {
      __delay_ms(50);
      res = ADRESH*256 + ADRESL;
      write(i);
      ADCON0bits.GO = 1;
      PIR1bits.ADIF = 0;
      ADCON0bits.CHS0 = ~ADCON0bits.CHS0;
      i = ~i;
   }
      if(ADCON0bits.GO == 0) {
      __delay_ms(50);
      res = ADRESH*256 + ADRESL;
      write(i);
      ADCON0bits.GO = 1;
      PIR1bits.ADIF = 0;
      ADCON0bits.CHS0 = ~ADCON0bits.CHS0;
      i = ~i;
   }
}


void main(){
   // Configure system: CAD, Timers, USART
   InitPic();
   InitGLCD();
   
   packet = INIT_PACKET();
   SEND_PACKET(packet);
   
   TMR0 = 65504;
   
   while (1) {
      T0CONbits.TMR0ON = 1;
      if (new_data) {
	  m2d(); 				// Convert current ADC values to data. Calibration process
	  packet= DATA_PACKET(ang, dist); 	// Build the packet
	  SEND_PACKET(packet); 			// send packet
	  new_data= 0; 				// Current data processed. Wait for new data
      }
   } 
}

```

### Source code sobre

```
#include <xc.h>
#define _XTAL_FREQ 8000000 

#define mask 1

#include <string.h>
#include <stdio.h>
#include "config.h"
#include "GLCD.h"

float dist, ang;
int res, i = 0;
char new_data;
char packet[128];

const char * s1 = "DISTANCE:";
const char * s2 = "ANGLE:";
const char * s3 = ".";


void interrupt ISR_H () {
   if(INTCONbits.TMR0IE && INTCONbits.TMR0IF){
      INTCONbits.TMR0IF = 0;
      new_data= 1; // Read ADC. New data is avalaible
      TMR0 = 65504;
      T0CONbits.TMR0ON = 0;
   }
}

void InitPic(){
   // Configure ADCON
   ADCON0 = 0x03; //Canal 0
   ADCON1 = 0x0D;
   ADCON2 = 0x91;
   
   // Configure timer 0
   T0CONbits.PSA = 1;		// Timer0 prescaler assigned
   T0CONbits.T0CS = 0;		// Instruction cycle clock
   T0CONbits.T08BIT = 0;	// 8-bit timer
   INTCONbits.TMR0IF = 0;
   INTCONbits.TMR0IE = 1;
   INTCON2bits.TMR0IP = 1;
   
   INTCONbits.GIE = 1;
   
   PORTD=0; 		// Donem uns valors inicials als ports
   PORTB=0;  
   TRISD=0x00;		//Configurem D i B de sortida
   TRISB=0x00;
   
   TRISCbits.RC6 = 0;	// Configurem RC6 de sortida (transmissió)
   TRISCbits.RC7 = 1;	// Configurem RC7 d'entrada (recepció)

   
   // Configuració per transmissió/recepció en sèrie asíncrona 8 bits dades
   TXSTA1 = 0x24;
   SPBRG1 = 0x08;
   PIE1bits.TXIE = 1;	// Enables USART transmit interrupt
   PIE1bits.RCIE = 1;	// Enables USART receive interrupt
   RCSTA1bits.CREN = 1;	// Enables receiver
   RCSTA1bits.SPEN = 1;	// Serial port enabled (configures RX/DT and TX/CK pins as serial port pins)
   
   //BAUDCON (default configuration)  
   
   TXREG = 0;
}

void writeTxt(byte page, byte y, char * s) {
   int i=0;
   while (*s!='\n' && *s!='\0') { 
      putchGLCD(page, y+i, *(s++));
      i++;
   }
}

void InitGLCD (){
   GLCDinit();		   	//Inicialitzem la pantalla
   clearGLCD(0,7,0,127);      	//Esborrem pantalla
   setStartLine(0);           	//Definim linia d'inici
   
   writeTxt(3, 1, s1);
   writeTxt(5, 1, s2);
}

void INIT_PACKET(){
   sprintf(packet, "INIT\n");
}

void DATA_PACKET(float angle, float distance){
   sprintf(packet, "DATA,%f,%f\n", angle, distance);
}

void SEND_PACKET() {
   for (int k = 0; k < strlen(packet); k++){ 
      PORTCbits.RC6 = 0;		//Bit start
      __delay_ms(1);
      while(!PIR1bits.TXIF);
      TXREG = packet[k];
      PIR1bits.TXIF = 0;
      /*for (int j = 0; j < 8; j++){
	 if(packet[k] & 0b00000001 == 0) PORTCbits.RC6 = 0;
	 else PORTCbits.RC6 = 1;
	 __delay_ms(1);
	 packet[k] = packet[k] >> 1;
      }*/
      
      PORTCbits.RC6 = 1;		// Bit stop
      __delay_ms(1);
   }
}



char compare(char rx){
   if(rx == 'G' || rx == 'g') return 1;
   else if(rx == 'R' || rx == 'r') return 2;
   else return 0;
}

char Rxdata(){
   char action;
      PORTCbits.RC7 = 0;		//Bit start
      __delay_ms(1);
      while(!PIR1bits.RCIF);
      RCSTA1bits.CREN = 0;	// Enables receiver
      action = compare(RCREG);
      RCSTA1bits.CREN = 1;	// Enables receiver
      PIR1bits.RCIF = 0;
      PORTCbits.RC7 = 1;		// Bit stop
      __delay_ms(1);

   return action;
}

void write(int i){
   char buff[8];
   if (i == 0){
      dist = 25.78 - 0.081*res + 0.000075*res*res;
      sprintf(buff, "%f", dist);
      writeTxt(3, 80, buff); 
   }
   else {
     ang = -58.05 + 0.337*res + 0.00002*res*res;
     sprintf(buff, "%f", ang);
     writeTxt(5, 80, buff);
   }
}

void m2d(){
   if(ADCON0bits.GO == 0) {
      __delay_ms(50);
      res = ADRESH*256 + ADRESL;
      write(i);
      ADCON0bits.GO = 1;
      PIR1bits.ADIF = 0;
      ADCON0bits.CHS0 = ~ADCON0bits.CHS0;
      i = ~i;
   }
      if(ADCON0bits.GO == 0) {
      __delay_ms(50);
      res = ADRESH*256 + ADRESL;
      write(i);
      ADCON0bits.GO = 1;
      PIR1bits.ADIF = 0;
      ADCON0bits.CHS0 = ~ADCON0bits.CHS0;
      i = ~i;
   }
}


void main(){
   // Configure system: CAD, Timers, USART
   InitPic();
   InitGLCD();
   
   INIT_PACKET();
   SEND_PACKET();
   
   TMR0 = 65504;
   char algo;
   while (1) {
      T0CONbits.TMR0ON = 1;
      if (new_data) {
	  algo = Rxdata();
	  if(algo == 1){
	     m2d(); 				// Convert current ADC values to data. Calibration process
	     DATA_PACKET(ang, dist); 		// Build the packet
	     SEND_PACKET(); 			// send packet
	     new_data= 0; 				// Current data processed. Wait for new data
	  }
	  if(algo == 2){
	       INIT_PACKET();
	       SEND_PACKET();
	       new_data = 0;
	  }
      }
   } 
}

```

### Schematic capture

![Screenshot](https://github.com/dumitrux/CI-FIB/blob/master/L10/L10.JPG)
