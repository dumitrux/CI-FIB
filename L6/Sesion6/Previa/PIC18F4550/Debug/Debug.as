opt subtitle "Microchip Technology Omniscient Code Generator (Lite mode) build 54009"

opt pagewidth 120

	opt lm

	processor	18F4550
porta	equ	0F80h
portb	equ	0F81h
portc	equ	0F82h
portd	equ	0F83h
porte	equ	0F84h
lata	equ	0F89h
latb	equ	0F8Ah
latc	equ	0F8Bh
latd	equ	0F8Ch
late	equ	0F8Dh
trisa	equ	0F92h
trisb	equ	0F93h
trisc	equ	0F94h
trisd	equ	0F95h
trise	equ	0F96h
pie1	equ	0F9Dh
pir1	equ	0F9Eh
ipr1	equ	0F9Fh
pie2	equ	0FA0h
pir2	equ	0FA1h
ipr2	equ	0FA2h
t3con	equ	0FB1h
tmr3l	equ	0FB2h
tmr3h	equ	0FB3h
ccp1con	equ	0FBDh
ccpr1l	equ	0FBEh
ccpr1h	equ	0FBFh
adcon1	equ	0FC1h
adcon0	equ	0FC2h
adresl	equ	0FC3h
adresh	equ	0FC4h
sspcon2	equ	0FC5h
sspcon1	equ	0FC6h
sspstat	equ	0FC7h
sspadd	equ	0FC8h
sspbuf	equ	0FC9h
t2con	equ	0FCAh
pr2	equ	0FCBh
tmr2	equ	0FCCh
t1con	equ	0FCDh
tmr1l	equ	0FCEh
tmr1h	equ	0FCFh
rcon	equ	0FD0h
wdtcon	equ	0FD1h
lvdcon	equ	0FD2h
osccon	equ	0FD3h
t0con	equ	0FD5h
tmr0l	equ	0FD6h
tmr0h	equ	0FD7h
status	equ	0FD8h
fsr2	equ	0FD9h
fsr2l	equ	0FD9h
fsr2h	equ	0FDAh
plusw2	equ	0FDBh
preinc2	equ	0FDCh
postdec2	equ	0FDDh
postinc2	equ	0FDEh
indf2	equ	0FDFh
bsr	equ	0FE0h
fsr1	equ	0FE1h
fsr1l	equ	0FE1h
fsr1h	equ	0FE2h
plusw1	equ	0FE3h
preinc1	equ	0FE4h
postdec1	equ	0FE5h
postinc1	equ	0FE6h
indf1	equ	0FE7h
wreg	equ	0FE8h
fsr0	equ	0FE9h
fsr0l	equ	0FE9h
fsr0h	equ	0FEAh
plusw0	equ	0FEBh
preinc0	equ	0FECh
postdec0	equ	0FEDh
postinc0	equ	0FEEh
indf0	equ	0FEFh
intcon3	equ	0FF0h
intcon2	equ	0FF1h
intcon	equ	0FF2h
prod	equ	0FF3h
prodl	equ	0FF3h
prodh	equ	0FF4h
tablat	equ	0FF5h
tblptr	equ	0FF6h
tblptrl	equ	0FF6h
tblptrh	equ	0FF7h
tblptru	equ	0FF8h
pcl	equ	0FF9h
pclat	equ	0FFAh
pclath	equ	0FFAh
pclatu	equ	0FFBh
stkptr	equ	0FFCh
tosl	equ	0FFDh
tosh	equ	0FFEh
tosu	equ	0FFFh
skipnz macro
	btfsc	status,2
endm
pushw macro
	movwf postinc1
endm
pushf macro arg1
	movff arg1, postinc1
endm
popw macro
	movf postdec1,w
	movf indf1,w
endm
popf macro arg1
	movf postdec1,w
	movff indf1,arg1
endm
popfc macro arg1
	movff plusw1,arg1
	decfsz fsr1,f
endm
	global	__ramtop
	global	__accesstop
# 46 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
SPPDATA equ 0F62h ;# 
# 65 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
SPPCFG equ 0F63h ;# 
# 141 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
SPPEPS equ 0F64h ;# 
# 214 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
SPPCON equ 0F65h ;# 
# 239 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
UFRM equ 0F66h ;# 
# 245 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
UFRML equ 0F66h ;# 
# 322 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
UFRMH equ 0F67h ;# 
# 361 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
UIR equ 0F68h ;# 
# 416 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
UIE equ 0F69h ;# 
# 471 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
UEIR equ 0F6Ah ;# 
# 521 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
UEIE equ 0F6Bh ;# 
# 571 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
USTAT equ 0F6Ch ;# 
# 630 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
UCON equ 0F6Dh ;# 
# 680 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
UADDR equ 0F6Eh ;# 
# 743 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
UCFG equ 0F6Fh ;# 
# 824 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
UEP0 equ 0F70h ;# 
# 955 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
UEP1 equ 0F71h ;# 
# 1086 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
UEP2 equ 0F72h ;# 
# 1217 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
UEP3 equ 0F73h ;# 
# 1348 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
UEP4 equ 0F74h ;# 
# 1479 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
UEP5 equ 0F75h ;# 
# 1610 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
UEP6 equ 0F76h ;# 
# 1741 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
UEP7 equ 0F77h ;# 
# 1872 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
UEP8 equ 0F78h ;# 
# 1959 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
UEP9 equ 0F79h ;# 
# 2046 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
UEP10 equ 0F7Ah ;# 
# 2133 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
UEP11 equ 0F7Bh ;# 
# 2220 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
UEP12 equ 0F7Ch ;# 
# 2307 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
UEP13 equ 0F7Dh ;# 
# 2394 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
UEP14 equ 0F7Eh ;# 
# 2481 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
UEP15 equ 0F7Fh ;# 
# 2568 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
PORTA equ 0F80h ;# 
# 2724 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
PORTB equ 0F81h ;# 
# 2833 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
PORTC equ 0F82h ;# 
# 2986 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
PORTD equ 0F83h ;# 
# 3106 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
PORTE equ 0F84h ;# 
# 3357 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
LATA equ 0F89h ;# 
# 3492 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
LATB equ 0F8Ah ;# 
# 3624 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
LATC equ 0F8Bh ;# 
# 3739 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
LATD equ 0F8Ch ;# 
# 3871 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
LATE equ 0F8Dh ;# 
# 3973 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
TRISA equ 0F92h ;# 
# 3978 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
DDRA equ 0F92h ;# 
# 4170 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
TRISB equ 0F93h ;# 
# 4175 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
DDRB equ 0F93h ;# 
# 4391 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
TRISC equ 0F94h ;# 
# 4396 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
DDRC equ 0F94h ;# 
# 4562 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
TRISD equ 0F95h ;# 
# 4567 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
DDRD equ 0F95h ;# 
# 4783 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
TRISE equ 0F96h ;# 
# 4788 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
DDRE equ 0F96h ;# 
# 4884 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
OSCTUNE equ 0F9Bh ;# 
# 4942 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
PIE1 equ 0F9Dh ;# 
# 5030 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
PIR1 equ 0F9Eh ;# 
# 5118 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
IPR1 equ 0F9Fh ;# 
# 5206 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
PIE2 equ 0FA0h ;# 
# 5276 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
PIR2 equ 0FA1h ;# 
# 5346 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
IPR2 equ 0FA2h ;# 
# 5416 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
EECON1 equ 0FA6h ;# 
# 5481 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
EECON2 equ 0FA7h ;# 
# 5487 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
EEDATA equ 0FA8h ;# 
# 5493 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
EEADR equ 0FA9h ;# 
# 5499 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
RCSTA equ 0FABh ;# 
# 5504 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
RCSTA1 equ 0FABh ;# 
# 5708 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
TXSTA equ 0FACh ;# 
# 5713 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
TXSTA1 equ 0FACh ;# 
# 6005 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
TXREG equ 0FADh ;# 
# 6010 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
TXREG1 equ 0FADh ;# 
# 6016 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
RCREG equ 0FAEh ;# 
# 6021 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
RCREG1 equ 0FAEh ;# 
# 6027 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
SPBRG equ 0FAFh ;# 
# 6032 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
SPBRG1 equ 0FAFh ;# 
# 6038 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
SPBRGH equ 0FB0h ;# 
# 6044 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
T3CON equ 0FB1h ;# 
# 6166 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
TMR3 equ 0FB2h ;# 
# 6172 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
TMR3L equ 0FB2h ;# 
# 6178 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
TMR3H equ 0FB3h ;# 
# 6184 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
CMCON equ 0FB4h ;# 
# 6279 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
CVRCON equ 0FB5h ;# 
# 6363 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
ECCP1AS equ 0FB6h ;# 
# 6368 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
CCP1AS equ 0FB6h ;# 
# 6524 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
ECCP1DEL equ 0FB7h ;# 
# 6529 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
CCP1DEL equ 0FB7h ;# 
# 6661 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
BAUDCON equ 0FB8h ;# 
# 6666 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
BAUDCTL equ 0FB8h ;# 
# 6840 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
CCP2CON equ 0FBAh ;# 
# 6903 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
CCPR2 equ 0FBBh ;# 
# 6909 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
CCPR2L equ 0FBBh ;# 
# 6915 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
CCPR2H equ 0FBCh ;# 
# 6921 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
CCP1CON equ 0FBDh ;# 
# 6926 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
ECCP1CON equ 0FBDh ;# 
# 7082 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
CCPR1 equ 0FBEh ;# 
# 7088 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
CCPR1L equ 0FBEh ;# 
# 7094 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
CCPR1H equ 0FBFh ;# 
# 7100 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
ADCON2 equ 0FC0h ;# 
# 7170 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
ADCON1 equ 0FC1h ;# 
# 7260 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
ADCON0 equ 0FC2h ;# 
# 7382 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
ADRES equ 0FC3h ;# 
# 7388 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
ADRESL equ 0FC3h ;# 
# 7394 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
ADRESH equ 0FC4h ;# 
# 7400 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
SSPCON2 equ 0FC5h ;# 
# 7461 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
SSPCON1 equ 0FC6h ;# 
# 7530 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
SSPSTAT equ 0FC7h ;# 
# 7796 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
SSPADD equ 0FC8h ;# 
# 7802 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
SSPBUF equ 0FC9h ;# 
# 7808 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
T2CON equ 0FCAh ;# 
# 7905 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
PR2 equ 0FCBh ;# 
# 7910 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
MEMCON equ 0FCBh ;# 
# 8014 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
TMR2 equ 0FCCh ;# 
# 8020 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
T1CON equ 0FCDh ;# 
# 8124 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
TMR1 equ 0FCEh ;# 
# 8130 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
TMR1L equ 0FCEh ;# 
# 8136 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
TMR1H equ 0FCFh ;# 
# 8142 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
RCON equ 0FD0h ;# 
# 8290 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
WDTCON equ 0FD1h ;# 
# 8317 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
HLVDCON equ 0FD2h ;# 
# 8322 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
LVDCON equ 0FD2h ;# 
# 8586 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
OSCCON equ 0FD3h ;# 
# 8668 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
T0CON equ 0FD5h ;# 
# 8737 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
TMR0 equ 0FD6h ;# 
# 8743 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
TMR0L equ 0FD6h ;# 
# 8749 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
TMR0H equ 0FD7h ;# 
# 8755 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
STATUS equ 0FD8h ;# 
# 8833 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
FSR2 equ 0FD9h ;# 
# 8839 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
FSR2L equ 0FD9h ;# 
# 8845 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
FSR2H equ 0FDAh ;# 
# 8851 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
PLUSW2 equ 0FDBh ;# 
# 8857 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
PREINC2 equ 0FDCh ;# 
# 8863 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
POSTDEC2 equ 0FDDh ;# 
# 8869 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
POSTINC2 equ 0FDEh ;# 
# 8875 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
INDF2 equ 0FDFh ;# 
# 8881 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
BSR equ 0FE0h ;# 
# 8887 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
FSR1 equ 0FE1h ;# 
# 8893 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
FSR1L equ 0FE1h ;# 
# 8899 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
FSR1H equ 0FE2h ;# 
# 8905 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
PLUSW1 equ 0FE3h ;# 
# 8911 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
PREINC1 equ 0FE4h ;# 
# 8917 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
POSTDEC1 equ 0FE5h ;# 
# 8923 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
POSTINC1 equ 0FE6h ;# 
# 8929 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
INDF1 equ 0FE7h ;# 
# 8935 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
WREG equ 0FE8h ;# 
# 8941 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
FSR0 equ 0FE9h ;# 
# 8947 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
FSR0L equ 0FE9h ;# 
# 8953 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
FSR0H equ 0FEAh ;# 
# 8959 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
PLUSW0 equ 0FEBh ;# 
# 8965 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
PREINC0 equ 0FECh ;# 
# 8971 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
POSTDEC0 equ 0FEDh ;# 
# 8977 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
POSTINC0 equ 0FEEh ;# 
# 8983 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
INDF0 equ 0FEFh ;# 
# 8989 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
INTCON3 equ 0FF0h ;# 
# 9080 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
INTCON2 equ 0FF1h ;# 
# 9156 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
INTCON equ 0FF2h ;# 
# 9292 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
PROD equ 0FF3h ;# 
# 9298 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
PRODL equ 0FF3h ;# 
# 9304 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
PRODH equ 0FF4h ;# 
# 9310 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
TABLAT equ 0FF5h ;# 
# 9318 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
TBLPTR equ 0FF6h ;# 
# 9324 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
TBLPTRL equ 0FF6h ;# 
# 9330 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
TBLPTRH equ 0FF7h ;# 
# 9336 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
TBLPTRU equ 0FF8h ;# 
# 9344 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
PCLAT equ 0FF9h ;# 
# 9351 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
PC equ 0FF9h ;# 
# 9357 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
PCL equ 0FF9h ;# 
# 9363 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
PCLATH equ 0FFAh ;# 
# 9369 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
PCLATU equ 0FFBh ;# 
# 9375 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
STKPTR equ 0FFCh ;# 
# 9450 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
TOS equ 0FFDh ;# 
# 9456 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
TOSL equ 0FFDh ;# 
# 9462 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
TOSH equ 0FFEh ;# 
# 9468 "C:\Program Files (x86)\Microchip\xc8\v1.21\include\pic18f4550.h"
TOSU equ 0FFFh ;# 
	FNCALL	_main,_pampallugues
	FNCALL	_main,_LEDstop
	FNROOT	_main
	FNCALL	intlevel2,_tc_int
	global	intlevel2
	FNROOT	intlevel2
	global	_int1
	global	_int2
	global	_ADCON1
_ADCON1	set	0xFC1
	global	_PORTD
_PORTD	set	0xF83
	global	_PORTDbits
_PORTDbits	set	0xF83
	global	_TRISD
_TRISD	set	0xF95
	global	_GIEH
_GIEH	set	0x7F97
	global	_INT1IE
_INT1IE	set	0x7F83
	global	_INT1IF
_INT1IF	set	0x7F80
	global	_INT1IP
_INT1IP	set	0x7F86
	global	_INT2IE
_INT2IE	set	0x7F84
	global	_INT2IF
_INT2IF	set	0x7F81
	global	_INT2IP
_INT2IP	set	0x7F87
psect	intcode_body,class=CODE,space=0,reloc=2
global __pintcode_body
__pintcode_body:
; #config settings
global __CFG_CPUDIV$OSC1_PLL2
__CFG_CPUDIV$OSC1_PLL2 equ 0x0
global __CFG_PLLDIV$2
__CFG_PLLDIV$2 equ 0x0
global __CFG_USBDIV$2
__CFG_USBDIV$2 equ 0x0
global __CFG_IESO$OFF
__CFG_IESO$OFF equ 0x0
global __CFG_FOSC$HS
__CFG_FOSC$HS equ 0x0
global __CFG_FCMEN$OFF
__CFG_FCMEN$OFF equ 0x0
global __CFG_VREGEN$ON
__CFG_VREGEN$ON equ 0x0
global __CFG_BOR$ON
__CFG_BOR$ON equ 0x0
global __CFG_BORV$3
__CFG_BORV$3 equ 0x0
global __CFG_PWRT$OFF
__CFG_PWRT$OFF equ 0x0
global __CFG_WDTPS$32768
__CFG_WDTPS$32768 equ 0x0
global __CFG_WDT$OFF
__CFG_WDT$OFF equ 0x0
global __CFG_PBADEN$OFF
__CFG_PBADEN$OFF equ 0x0
global __CFG_LPT1OSC$OFF
__CFG_LPT1OSC$OFF equ 0x0
global __CFG_MCLRE$ON
__CFG_MCLRE$ON equ 0x0
global __CFG_STVREN$ON
__CFG_STVREN$ON equ 0x0
global __CFG_XINST$OFF
__CFG_XINST$OFF equ 0x0
global __CFG_LVP$OFF
__CFG_LVP$OFF equ 0x0
global __CFG_CP0$OFF
__CFG_CP0$OFF equ 0x0
global __CFG_CP1$OFF
__CFG_CP1$OFF equ 0x0
global __CFG_CPB$OFF
__CFG_CPB$OFF equ 0x0
global __CFG_WRT0$OFF
__CFG_WRT0$OFF equ 0x0
global __CFG_WRT1$OFF
__CFG_WRT1$OFF equ 0x0
global __CFG_WRTB$OFF
__CFG_WRTB$OFF equ 0x0
global __CFG_WRTC$OFF
__CFG_WRTC$OFF equ 0x0
global __CFG_EBTR0$OFF
__CFG_EBTR0$OFF equ 0x0
global __CFG_EBTR1$OFF
__CFG_EBTR1$OFF equ 0x0
global __CFG_EBTRB$OFF
__CFG_EBTRB$OFF equ 0x0
	file	"Debug.as"
	line	#
psect	cinit,class=CODE,delta=1,reloc=2
global __pcinit
__pcinit:
global start_initialization
start_initialization:

global __initialization
__initialization:
psect	bssCOMRAM,class=COMRAM,space=1,noexec
global __pbssCOMRAM
__pbssCOMRAM:
	global	_int1
_int1:
       ds      1
	global	_int2
_int2:
       ds      1
	line	#
psect	cinit
; Clear objects allocated to COMRAM (2 bytes)
	global __pbssCOMRAM
clrf	(__pbssCOMRAM+1)&0xffh,c
clrf	(__pbssCOMRAM+0)&0xffh,c
psect cinit,class=CODE,delta=1
global end_of_initialization,__end_of__initialization

;End of C runtime variable initialization code

end_of_initialization:
__end_of__initialization:movlb 0
goto _main	;jump to C main() function
psect	cstackCOMRAM,class=COMRAM,space=1,noexec
global __pcstackCOMRAM
__pcstackCOMRAM:
?_tc_int:	; 0 bytes @ 0x0
??_tc_int:	; 0 bytes @ 0x0
?_pampallugues:	; 0 bytes @ 0x0
?_LEDstop:	; 0 bytes @ 0x0
?_main:	; 0 bytes @ 0x0
	ds   15
??_pampallugues:	; 0 bytes @ 0xF
??_LEDstop:	; 0 bytes @ 0xF
	ds   1
	global	pampallugues@i
pampallugues@i:	; 2 bytes @ 0x10
	ds   2
??_main:	; 0 bytes @ 0x12
;!
;!Data Sizes:
;!    Strings     0
;!    Constant    0
;!    Data        0
;!    BSS         2
;!    Persistent  0
;!    Stack       0
;!
;!Auto Spaces:
;!    Space          Size  Autos    Used
;!    COMRAM           95     18      20
;!    BANK0           160      0       0
;!    BANK1           256      0       0
;!    BANK2           256      0       0
;!    BANK3           256      0       0
;!    BANK4           256      0       0
;!    BANK5           256      0       0
;!    BANK6           256      0       0
;!    BANK7           256      0       0

;!
;!Pointer List with Targets:
;!
;!    None.


;!
;!Critical Paths under _main in COMRAM
;!
;!    _main->_pampallugues
;!
;!Critical Paths under _tc_int in COMRAM
;!
;!    None.
;!
;!Critical Paths under _main in BANK0
;!
;!    None.
;!
;!Critical Paths under _tc_int in BANK0
;!
;!    None.
;!
;!Critical Paths under _main in BANK1
;!
;!    None.
;!
;!Critical Paths under _tc_int in BANK1
;!
;!    None.
;!
;!Critical Paths under _main in BANK2
;!
;!    None.
;!
;!Critical Paths under _tc_int in BANK2
;!
;!    None.
;!
;!Critical Paths under _main in BANK3
;!
;!    None.
;!
;!Critical Paths under _tc_int in BANK3
;!
;!    None.
;!
;!Critical Paths under _main in BANK4
;!
;!    None.
;!
;!Critical Paths under _tc_int in BANK4
;!
;!    None.
;!
;!Critical Paths under _main in BANK5
;!
;!    None.
;!
;!Critical Paths under _tc_int in BANK5
;!
;!    None.
;!
;!Critical Paths under _main in BANK6
;!
;!    None.
;!
;!Critical Paths under _tc_int in BANK6
;!
;!    None.
;!
;!Critical Paths under _main in BANK7
;!
;!    None.
;!
;!Critical Paths under _tc_int in BANK7
;!
;!    None.

;;
;;Main: autosize = 0, tempsize = 0, incstack = 0, save=0
;;

;!
;!Call Graph Tables:
;!
;! ---------------------------------------------------------------------------------
;! (Depth) Function   	        Calls       Base Space   Used Autos Params    Refs
;! ---------------------------------------------------------------------------------
;! (0) _main                                                 0     0      0      45
;!                       _pampallugues
;!                            _LEDstop
;! ---------------------------------------------------------------------------------
;! (1) _LEDstop                                              0     0      0       0
;! ---------------------------------------------------------------------------------
;! (1) _pampallugues                                         3     3      0      45
;!                                             15 COMRAM     3     3      0
;! ---------------------------------------------------------------------------------
;! Estimated maximum stack depth 1
;! ---------------------------------------------------------------------------------
;! (Depth) Function   	        Calls       Base Space   Used Autos Params    Refs
;! ---------------------------------------------------------------------------------
;! (2) _tc_int                                              15    15      0       0
;!                                              0 COMRAM    15    15      0
;! ---------------------------------------------------------------------------------
;! Estimated maximum stack depth 2
;! ---------------------------------------------------------------------------------
;!
;! Call Graph Graphs:
;!
;! _main (ROOT)
;!   _pampallugues
;!   _LEDstop
;!
;! _tc_int (ROOT)
;!

;! Address spaces:

;!Name               Size   Autos  Total    Cost      Usage
;!BIGRAM             7FF      0       0      21        0.0%
;!EEDATA             100      0       0       0        0.0%
;!BITBANK7           100      0       0      18        0.0%
;!BANK7              100      0       0      19        0.0%
;!BITBANK6           100      0       0      16        0.0%
;!BANK6              100      0       0      17        0.0%
;!BITBANK5           100      0       0      14        0.0%
;!BANK5              100      0       0      15        0.0%
;!BITBANK4           100      0       0      12        0.0%
;!BANK4              100      0       0      13        0.0%
;!BITBANK3           100      0       0      10        0.0%
;!BANK3              100      0       0      11        0.0%
;!BITBANK2           100      0       0       8        0.0%
;!BANK2              100      0       0       9        0.0%
;!BITBANK1           100      0       0       6        0.0%
;!BANK1              100      0       0       7        0.0%
;!BITBANK0            A0      0       0       4        0.0%
;!BANK0               A0      0       0       5        0.0%
;!BITCOMRAM           5F      0       0       0        0.0%
;!COMRAM              5F     12      14       1       21.1%
;!BITSFR               0      0       0      40        0.0%
;!SFR                  0      0       0      40        0.0%
;!STACK                0      0       1       2        0.0%
;!NULL                 0      0       0       0        0.0%
;!ABS                  0      0      14      20        0.0%
;!DATA                 0      0      15       3        0.0%
;!CODE                 0      0       0       0        0.0%

	global	_main

;; *************** function _main *****************
;; Defined at:
;;		line 51 in file "../main.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, status,2, status,0, cstack
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMRAM   BANK0   BANK1   BANK2   BANK3   BANK4   BANK5   BANK6   BANK7
;;      Params:         0       0       0       0       0       0       0       0       0
;;      Locals:         0       0       0       0       0       0       0       0       0
;;      Temps:          0       0       0       0       0       0       0       0       0
;;      Totals:         0       0       0       0       0       0       0       0       0
;;Total ram usage:        0 bytes
;; Hardware stack levels required when called:    2
;; This function calls:
;;		_pampallugues
;;		_LEDstop
;; This function is called by:
;;		Startup code after reset
;; This function uses a non-reentrant model
;;
psect	text0,class=CODE,space=0,reloc=2
global __ptext0
__ptext0:
psect	text0
	file	"../main.c"
	line	51
	global	__size_of_main
	__size_of_main	equ	__end_of_main-_main
	
_main:
;incstack = 0
	opt	stack 29
;incstack = 0
	line	52
	
l652:
	movlw	low(0Fh)
	movwf	((c:4033)),c	;volatile
	line	53
	
l654:
	bsf	c:(32663/8),(32663)&7	;volatile
	line	54
	
l656:
	bcf	c:(32641/8),(32641)&7	;volatile
	line	55
	
l658:
	bcf	c:(32640/8),(32640)&7	;volatile
	line	56
	
l660:
	bsf	c:(32644/8),(32644)&7	;volatile
	line	57
	
l662:
	bsf	c:(32643/8),(32643)&7	;volatile
	line	58
	
l664:
	bsf	c:(32647/8),(32647)&7	;volatile
	line	59
	
l666:
	bsf	c:(32646/8),(32646)&7	;volatile
	line	61
	movlw	low(0)
	movwf	((c:3989)),c	;volatile
	goto	l670
	line	63
	
l45:
	line	64
	goto	l670
	
l47:
	
l668:
	call	_pampallugues	;wreg free
	goto	l670
	
l46:
	
l670:
	tstfsz	((c:_int1)),c
	goto	u51
	goto	u50
u51:
	goto	l668
u50:
	goto	l674
	
l48:
	line	65
	goto	l674
	
l50:
	
l672:
	call	_LEDstop	;wreg free
	goto	l674
	
l49:
	
l674:
	tstfsz	((c:_int2)),c
	goto	u61
	goto	u60
u61:
	goto	l672
u60:
	goto	l670
	
l51:
	goto	l670
	line	66
	
l52:
	line	63
	goto	l670
	
l53:
	line	67
	
l54:
	global	start
	goto	start
	opt stack 0
GLOBAL	__end_of_main
	__end_of_main:
	signat	_main,88
	global	_LEDstop

;; *************** function _LEDstop *****************
;; Defined at:
;;		line 39 in file "../main.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		None
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMRAM   BANK0   BANK1   BANK2   BANK3   BANK4   BANK5   BANK6   BANK7
;;      Params:         0       0       0       0       0       0       0       0       0
;;      Locals:         0       0       0       0       0       0       0       0       0
;;      Temps:          0       0       0       0       0       0       0       0       0
;;      Totals:         0       0       0       0       0       0       0       0       0
;;Total ram usage:        0 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    1
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_main
;; This function uses a non-reentrant model
;;
psect	text1,class=CODE,space=0,reloc=2
global __ptext1
__ptext1:
psect	text1
	file	"../main.c"
	line	39
	global	__size_of_LEDstop
	__size_of_LEDstop	equ	__end_of_LEDstop-_LEDstop
	
_LEDstop:
;incstack = 0
	opt	stack 29
;incstack = 0
	line	40
	
l650:
	bsf	((c:3971)),c,0	;volatile
	line	41
	bsf	((c:3971)),c,1	;volatile
	line	42
	bsf	((c:3971)),c,2	;volatile
	line	43
	bsf	((c:3971)),c,3	;volatile
	line	44
	bsf	((c:3971)),c,4	;volatile
	line	45
	bsf	((c:3971)),c,5	;volatile
	line	46
	bsf	((c:3971)),c,6	;volatile
	line	47
	bsf	((c:3971)),c,7	;volatile
	line	48
	
l42:
	return
	opt stack 0
GLOBAL	__end_of_LEDstop
	__end_of_LEDstop:
	signat	_LEDstop,88
	global	_pampallugues

;; *************** function _pampallugues *****************
;; Defined at:
;;		line 31 in file "../main.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;  i               2   16[COMRAM] int 
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, status,2, status,0
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMRAM   BANK0   BANK1   BANK2   BANK3   BANK4   BANK5   BANK6   BANK7
;;      Params:         0       0       0       0       0       0       0       0       0
;;      Locals:         2       0       0       0       0       0       0       0       0
;;      Temps:          1       0       0       0       0       0       0       0       0
;;      Totals:         3       0       0       0       0       0       0       0       0
;;Total ram usage:        3 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    1
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_main
;; This function uses a non-reentrant model
;;
psect	text2,class=CODE,space=0,reloc=2
global __ptext2
__ptext2:
psect	text2
	file	"../main.c"
	line	31
	global	__size_of_pampallugues
	__size_of_pampallugues	equ	__end_of_pampallugues-_pampallugues
	
_pampallugues:
;incstack = 0
	opt	stack 29
;incstack = 0
	line	32
	
l640:
	movlw	high(01h)
	movwf	((c:pampallugues@i+1)),c
	movlw	low(01h)
	movwf	((c:pampallugues@i)),c
	
l642:
	movf	((c:pampallugues@i+1)),c,w
	xorlw	80h
	addlw	-((0)^80h)
	movlw	081h
	btfsc	status,2
	subwf	((c:pampallugues@i)),c,w
	btfss	status,0
	goto	u31
	goto	u30
u31:
	goto	l37
u30:
	goto	l39
	
l644:
	goto	l39
	
l37:
	line	33
	movff	(c:pampallugues@i),(c:3971)	;volatile
	line	34
	
l646:
	movlw	65
movwf	(??_pampallugues+0+0)&0ffh,c,f
	movlw	238
u77:
	decfsz	wreg,f
	goto	u77
	decfsz	(??_pampallugues+0+0)&0ffh,c,f
	goto	u77
	nop

	line	32
	
l648:
	bcf	status,0
	rlcf	((c:pampallugues@i)),c
	rlcf	((c:pampallugues@i+1)),c
	movf	((c:pampallugues@i+1)),c,w
	xorlw	80h
	addlw	-((0)^80h)
	movlw	081h
	btfsc	status,2
	subwf	((c:pampallugues@i)),c,w
	btfss	status,0
	goto	u41
	goto	u40
u41:
	goto	l37
u40:
	goto	l39
	
l38:
	line	36
	
l39:
	return
	opt stack 0
GLOBAL	__end_of_pampallugues
	__end_of_pampallugues:
	signat	_pampallugues,88
	global	_tc_int

;; *************** function _tc_int *****************
;; Defined at:
;;		line 17 in file "../main.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		status,2
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMRAM   BANK0   BANK1   BANK2   BANK3   BANK4   BANK5   BANK6   BANK7
;;      Params:         0       0       0       0       0       0       0       0       0
;;      Locals:         0       0       0       0       0       0       0       0       0
;;      Temps:         15       0       0       0       0       0       0       0       0
;;      Totals:        15       0       0       0       0       0       0       0       0
;;Total ram usage:       15 bytes
;; Hardware stack levels used:    1
;; This function calls:
;;		Nothing
;; This function is called by:
;;		Interrupt level 2
;; This function uses a non-reentrant model
;;
psect	intcode,class=CODE,space=0,reloc=2
global __pintcode
__pintcode:
psect	intcode
	file	"../main.c"
	line	17
	global	__size_of_tc_int
	__size_of_tc_int	equ	__end_of_tc_int-_tc_int
	
_tc_int:
;incstack = 0
	opt	stack 29
	movff	pclat+0,??_tc_int+1
	movff	pclat+1,??_tc_int+2
	global	int_func
	call	int_func,f	;refresh shadow registers
psect	intcode_body
int_func:

	pop	; remove dummy address from shadow register refresh
	movff	fsr0l+0,??_tc_int+3
	movff	fsr0h+0,??_tc_int+4
	movff	fsr1l+0,??_tc_int+5
	movff	fsr1h+0,??_tc_int+6
	movff	fsr2l+0,??_tc_int+7
	movff	fsr2h+0,??_tc_int+8
	movff	prodl+0,??_tc_int+9
	movff	prodh+0,??_tc_int+10
	movff	tblptrl+0,??_tc_int+11
	movff	tblptrh+0,??_tc_int+12
	movff	tblptru+0,??_tc_int+13
	movff	tablat+0,??_tc_int+14
;incstack = 0
	line	18
	
i2l630:
	btfss	c:(32640/8),(32640)&7	;volatile
	goto	i2u1_41
	goto	i2u1_40
i2u1_41:
	goto	i2l31
i2u1_40:
	line	19
	
i2l632:
	movwf	(??_tc_int+0+0)&0ffh,c
	movlw	low(0)
	movwf	((c:_int2)),c
	movf	(??_tc_int+0+0)&0ffh,c,w
	line	20
	movwf	(??_tc_int+0+0)&0ffh,c
	movlw	low(01h)
	movwf	((c:_int1)),c
	movf	(??_tc_int+0+0)&0ffh,c,w
	line	21
	
i2l634:
	bcf	c:(32640/8),(32640)&7	;volatile
	line	22
	goto	i2l34
	line	23
	
i2l31:
	btfss	c:(32641/8),(32641)&7	;volatile
	goto	i2u2_41
	goto	i2u2_40
i2u2_41:
	goto	i2l34
i2u2_40:
	line	24
	
i2l636:
	movwf	(??_tc_int+0+0)&0ffh,c
	movlw	low(0)
	movwf	((c:_int1)),c
	movf	(??_tc_int+0+0)&0ffh,c,w
	line	25
	movwf	(??_tc_int+0+0)&0ffh,c
	movlw	low(01h)
	movwf	((c:_int2)),c
	movf	(??_tc_int+0+0)&0ffh,c,w
	line	26
	
i2l638:
	bcf	c:(32641/8),(32641)&7	;volatile
	goto	i2l34
	line	27
	
i2l33:
	goto	i2l34
	line	28
	
i2l32:
	
i2l34:
	movff	??_tc_int+14,tablat+0
	movff	??_tc_int+13,tblptru+0
	movff	??_tc_int+12,tblptrh+0
	movff	??_tc_int+11,tblptrl+0
	movff	??_tc_int+10,prodh+0
	movff	??_tc_int+9,prodl+0
	movff	??_tc_int+8,fsr2h+0
	movff	??_tc_int+7,fsr2l+0
	movff	??_tc_int+6,fsr1h+0
	movff	??_tc_int+5,fsr1l+0
	movff	??_tc_int+4,fsr0h+0
	movff	??_tc_int+3,fsr0l+0
	movff	??_tc_int+2,pclat+1
	movff	??_tc_int+1,pclat+0
	retfie f
	opt stack 0
GLOBAL	__end_of_tc_int
	__end_of_tc_int:
	signat	_tc_int,88
	GLOBAL	__activetblptr
__activetblptr	EQU	0
	psect	intsave_regs,class=BIGRAM,space=1,noexec
	PSECT	rparam,class=COMRAM,space=1,noexec
	GLOBAL	__Lrparam
	FNCONF	rparam,??,?
GLOBAL	__Lparam, __Hparam
GLOBAL	__Lrparam, __Hrparam
__Lparam	EQU	__Lrparam
__Hparam	EQU	__Hrparam
	end
