# Introdució a la programació de microcontroladors en Proteus

## Laboratori sobre
- [Source code](#source-code)
- [Schematic capture](#schematic-capture)

### Source code

```
;====================================================================
; CI Programa d'exemple, copia el contingut del PORTA al PORTB
;
; Created:   Fri Sep 15 2017
; Processor: PIC18F4550
; Compiler:  MPASM (Proteus)
;====================================================================

;====================================================================
; DEFINITIONS
;====================================================================

#include p18f4550.inc          ; Include register definition file

                               ; Configuracio del hw intern del Micro 18F4550
                               ; normalment estaran en el fitxer config.inc

 config PLLDIV   = 2           ; (8 MHz crystal on EASYPIC6 board)
 config CPUDIV   = OSC1_PLL2   ;No dividim. Treballem a 8MHz
 config USBDIV   = 2           ;Clock source from 96MHz PLL/2
 config FOSC     = HS          ;sense PLL
 config FCMEN    = OFF
 config IESO     = OFF
 config PWRT     = OFF
 config BOR      = ON
 config BORV     = 3
 config VREGEN   = ON          ;USB Voltage Regulator
 config WDT      = OFF
 config WDTPS    = 32768
 config MCLRE    = ON
 config LPT1OSC  = OFF
 config PBADEN   = OFF
 config STVREN   = ON
 config LVP      = OFF
 config XINST    = OFF         ;Extended Instruction Set
 config CP0      = OFF
 config CP1      = OFF
 config CPB      = OFF
 config WRT0     = OFF
 config WRT1     = OFF
 config WRTB     = OFF         ;Boot Block Write Protection
 config WRTC     = OFF
 config EBTR0    = OFF
 config EBTR1    = OFF
 config EBTRB    = OFF
  
;====================================================================
; VARIABLES
;====================================================================
   cont EQU 0x00
   aux EQU 0x00
   iter EQU 0x00
;====================================================================
; RESET and INTERRUPT VECTORS
;====================================================================

                                  ; Reset Vector
RST   code  0x0
      goto  Start

;====================================================================
; CODE SEGMENT
;====================================================================

PGM   code
Start
                                  ; incialitzacions dels ports A i B
   MOVLW 0x0F
   MOVWF ADCON1,0		; config ports com DIGITALS 
   MOVLW 0xFF
   MOVWF TRISA,0		; config port A com INPUTS
   MOVLW 0x00
   MOVWF TRISB,0		; config port B com OUTUTS
   MOVF PORTA, 0, 0             ;W = PORTA
   MOVWF aux,0                  ;aux = W

bucle 

   BTFSC aux,iter,0
   INCF cont,1,0
   INCF iter,1,0
   MOVLW 0x05
   CPFSEQ iter,0
   BRA bucle

   MOVF cont,0,0
   MOVWF PORTB,0
 
   END                             ;Fi del Programa


;====================================================================
      END
```

### Schematic capture

![Screenshot](https://github.com/srmeeseeks/CI-FIB/blob/master/L2/L2.jpg)
