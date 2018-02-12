/* Main.c file generated by New Project wizard
 *
 * Created:   Tue Oct 29 2013
 * Processor: PIC18F4550
 * Compiler:  MPLAB XC8
 */

#include <xc.h>
#include<p18f4550.h>
#include "config.h"
#include <stdbool.h>	// Libreria para usar booleans

bool int1 = false;
bool int2 = false;

void interrupt tc_int(void)
{
	if (INT1IF) {			// INT1 routine
		int2 = false;
		int1 = true;
		INT1IF = 0;
	}
	else if (INT2IF) {		// INT2 routine
		int1 = false;
		int2 = true;
		INT2IF = 0;
	}
}

void pampallugues (void)
{
	for (int i = 0x01; i <= 0x80; i*=2) {
		PORTD = i;
		_delay(50000);
	}
}

void LEDstop(void)
{
	PORTDbits.RD0 = 1;
	PORTDbits.RD1 = 1;
	PORTDbits.RD2 = 1;
	PORTDbits.RD3 = 1;
	PORTDbits.RD4 = 1;
	PORTDbits.RD5 = 1;
	PORTDbits.RD6 = 1;
	PORTDbits.RD7 = 1;
}

void main(void)
 {
	 ADCON1 = 0x0F; // for digital inputs
	 GIEH = 1;
	 INT2IF = 0;	// Deshabilitar int2if (IF Flag)
	 INT1IF = 0;	// Deshabilitar int1if
	 INT2IE = 1;	// habilitar int2
	 INT1IE = 1;
	 INT2IP = 1;	// high priority int2
	 INT1IP = 1;
	 
	 TRISD = 0x00;
	 
	 while (1) {
		 while (int1) pampallugues();
		 while (int2) LEDstop();
	 }
 }