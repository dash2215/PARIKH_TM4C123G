;****************** main.s ***************
; ECE505, W 2020, Example
;*****************************************

        IMPORT   PortF_Init
		IMPORT   delay
        IMPORT   blue_led_on
		IMPORT   blue_led_off
       
; we align 32 bit variables to 32-bits
; we align op codes to 16 bits
       THUMB
       AREA    DATA, ALIGN=4 
       EXPORT  M [DATA,SIZE=4]
	   EXPORT  ARRAY_RAM [DATA,SIZE=32]
		   
M      SPACE   4
ARRAY_RAM  SPACE   32
	
       AREA    |.text|, CODE, READONLY, ALIGN=2
       EXPORT  Start

ARRAY_ROM DCD  0x01,0x02,0x03,0x04		
;*******************************************
; No need to worry about anything above
;*******************************************
; PF1: Red
; PF2: Blue
; PF3: Green
; User functions:
; 	PortF_init:   to initialize port F
; 	blue_led_on:  to turn blue LED on
;	blue_led_off: to turn blue LED off
; 	delay:        delay fixed amount of time (3 * 0.25 = 0.75s)

; By manipulating the sequence of funtion calls, the user can generate different light patterns. 
; This lab is used to demonstrate the development tools and debugging features.

Start
    BL  PortF_Init                  ; initialize input and output pins of Port F

Myloop	
	MOV  R5,#0x1234
	PUSH {R5}
	POP  {R6}		
	
	
	MOV R4, #3

LoopBlue	
	BL  blue_led_on
    BL  delay
	BL  blue_led_off
    BL  delay
	

	
	SUBS R4, R4, #1
	BNE LoopBlue
	

	
	
	B   Myloop


		END