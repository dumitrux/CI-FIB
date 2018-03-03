# Projecte Computadors encastats a l'automòbil

## Laboratori
- [Source code previ](#source-code)
- [Schematic capture previ](#schematic-capture)

```
#include <xc.h>
#define _XTAL_FREQ 8000000

#include <string.h>
#include "config.h"
#include "GLCD.h"

#define PINA2 PORTAbits.RA2
#define PINA3 PORTAbits.RA3
#define PINA4 PORTAbits.RA4
#define PINA5 PORTAbits.RA5
#define PINC1 PORTCbits.RC1

float tempS;
int tempC;

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
   // A/D
   TRISA = 0xFF; // PORTA entrada
   ADON = 1;	// Mòdul de conversió activat
   VCFG1 = 0;	// Vref = Vss
   VCFG0 = 0;	// Vref = Vdd
   PCFG3 = 1 ; PCFG2 = 1; PCFG1 = 0; PCFG0 = 1;	//AN1 Analogica
   ADFM = 0;	// Justificat a la esquerra
   ACQT2 = 1; ACQT1 = 0; ACQT0 = 1;	// TAD = 12
   ADCS2 = 0; ADCS1 = 0; ADCS0 = 1;	// Fosc/8
   
   // CCP Compare
   CCP2CONbits.CCP2M3 = 0; CCP2CONbits.CCP2M2 = 0; CCP2CONbits.CCP2M1 = 1; CCP2CONbits.CCP2M0 = 0;

   CCPR2H = 0x04;
   CCPR2L = 0xE2;
   
   TMR3ON = 1;
   T3CONbits.RD16 = 1;
   T3CCP2 = 1; T3CCP1 = 0;
   T3CKPS0 = 0; T3CKPS1 = 0; 
   TMR3CS = 0;
   TMR3H = 0x00; TMR3L = 0x00;
   
   //TMR0
   T08BIT = 0;
   T0PS2 = 0; T0PS1 = 1; T0PS0 = 1;
   TMR0L = 0xE4;
   TMR0H = 0x48; 
   T0CS = 0;
   T0CONbits.PSA = 0;
   
   
   //Interrupts
   GIE = 1;    
   PEIE = 1;
   IPEN = 1;
   TMR0IE = 1;
   TMR0IP = 0;
   TMR0IF = 0;
   CCP2IP = 1;
   CCP2IE = 1;
   
  //PWM
   TRISCbits.TRISC2 = 0;    
   PIE1bits.TMR2IE = 0;      
   T2CONbits.T2CKPS1 = 1;   	// Enable TMR2 with prescaler = 16
   PR2 = 124; 			// PWM period = (PR2+1) * prescaler * TI = 1ms
   CCP1CONbits.CCP1M3 = 1; 	// Enable PWM on CCP1
   CCP1CONbits.CCP1M2 = 1;  
   CCPR1L = 70;
   CCP1CONbits.DC1B1 = 0;
   CCP1CONbits.DC1B0 = 0; 
   T2CONbits.TMR2ON = 1;
}
   
double distancia;

void calculaDistancia(){
      ADCON0bits.CHS3 = 0; ADCON0bits.CHS2 = 0; ADCON0bits.CHS1 = 0; ADCON0bits.CHS0 = 1; //LECTURA DEL CANAL 1 -> AN1
      GO = 1;
      while(GO);//Es baixarà quan s'hagi fet l'adquisició
      int n = ADRESH;
      n =  n<< 2;
      n= n | (ADRESL>>6);
      distancia= 36.18812987839666 - 0.1743512347097224*n + 0.0003486390853760499*n*n - 0.00000025086752008655*n*n*n;
}

void interrupt low_priority timer(void){
   if(TMR0IE && TMR0IF){
      TMR0IF = 0;
      if(TRISCbits.TRISC1 == 1) TRISCbits.TRISC1 = 0;
      else TRISCbits.TRISC1 = 1;
      TMR0H = distancia*(-128/13) + (3496/13); TMR0L = 0xE4;
   }
   if (TMR2IF && TMR2IE) { //1 ms
      int dif = (int)((tempS - tempC) *25); //INT
      if(dif <= 0) CCPR1L = 0;
      else if (dif >= 100) CCPR1L = 124;
      else CCPR1L = (124*dif)/100;             
      PIR1bits.TMR2IF = 0;
   }
}

void interrupt high_priority ccp(void){
      if(CCP2IE && CCP2IF){
      CCP2IF = 0;
      TMR3H = 0x00; TMR3L = 0x00;
   }
}


void actualizaTimerZeroConfig(void){
      if(!TMR0ON) TMR0ON = 1;
      if(distancia <= 6){
	 TMR0ON = 0;
	 TRISCbits.TRISC1 = 0;
      } 
      else if(distancia > 20){
	 TMR0ON = 0;
	 TRISCbits.TRISC1 = 1;
      }
      else TMR0ON = 1;
}

unsigned char OneWireReset(void){
   unsigned char tmp;
   PINA5 = 0;
   __delay_us(480);
   PINA5 = 1;
   __delay_us(70);
   tmp = PINA5;
   __delay_us(410);
   return tmp;
}

void OneWireWriteByte (unsigned char b){// Envia el byte b bitt a bitt pel pin RA5 segons el protocol 1wire.
   unsigned char cnt;
   unsigned char bitt;
   for (cnt=0;cnt!=8;cnt++){
      bitt = (b&(1<<cnt));
      PINA5 = 0;	
      if (bitt==0) {
	    __delay_us(60);
	    PINA5 = 1;
	    __delay_us(10);
	 }
      else{
	    __delay_us(6);
	    PINA5 = 1;
	    __delay_us(64);
	}
     }
}

unsigned char OneWireReadByte(void){// Rep un byte del dispositiu pel pin RA5 segons el protocol 1wire. 
   unsigned char bitt=0;
   unsigned char cnt, tmp;
   for (cnt=0;cnt!=8;cnt++){
      if (bitt!=0) tmp|=(1<<cnt);       
      PINA5 = 0;
      __delay_us(6);
      PINA5 = 1;
      __delay_us(9);
      if (PINA5!=0) bitt = 1;
      else bitt = 0;
      __delay_us(55);
   }
   return tmp;
}

float Read_Temperature_DS1820(void) {
   int temp;
   GIE = 0;
   OneWireReset(); // master resets bus //IF
   OneWireWriteByte(0xCC); // skip ROM
   OneWireWriteByte(0x44); // convert temperature
   OneWireReset(); // master resets bus
   OneWireWriteByte(0xCC); // skip ROM(nomes un dispositiu)
   OneWireWriteByte(0xBE); // read scratch pad
		    // read 2 bytes from scratchpad
   temp= OneWireReadByte();
   temp = (OneWireReadByte() << 8) + temp; // sign bitt set, temp is negative
   GIE = 1;
   return (((float)temp)/2);
}

void main(void){
      configPIC();
      configGLCD();
      clearGLCD(5,5,0,127);
      tempC = 25;
      while(1){
	 tempS = Read_Temperature_DS1820();
	 //sprintf()
	 //putchGLCD(5, 7, temp);
	 if(PINA2) {
	    __delay_ms(10);
	    if(PINA2) ++tempC;
	 }
	 while(PINA2);
	 if(PINA3) {
	    __delay_ms(10);
	    if(PINA3) --tempC;
	 }
	 while(PINA3);
	 while(PINA4){
	    __delay_ms(10);
	    calculaDistancia();
	    actualizaTimerZeroConfig();
	    if(distancia == 0) putchGLCD(5, 7, '0');
	    else writeNum(5, 7, distancia);
	    for(int i = 0; i < 100; ++i) __delay_ms(5);
	    clearGLCD(5,5,0,127);
	 }
	 TRISCbits.TRISC1 = 1;
	 TMR0ON = 0;
      }
}
```

### Schematic capture previ

![Screenshot](https://github.com/srmeeseeks/CI-FIB/blob/master/L1/L1.jpg)
