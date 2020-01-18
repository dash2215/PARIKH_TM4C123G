;****************** main.s ***************
; Author: Darshil Parikh
; ECE505, W 2020, Experiment 1
; This file adds on to the sample code provided. 
; Date: 01/18/2020
;*****************************************

        IMPORT   PortF_Init
		IMPORT   delay
        IMPORT   blue_led_on
		IMPORT   blue_led_off
		IMPORT	 red_led_on
		IMPORT	 red_led_off
		IMPORT	 green_led_on
		IMPORT	 green_led_off
       
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
; LOOP START
Myloop

; BLUE LOOP START
	MOV R4, #1
LoopBlue	
	BL  blue_led_on
    BL  delay
	BL  blue_led_off
    BL  delay
	
	SUBS R4, R4, #1
	BNE LoopBlue
; BLUE LOOP END


;RED LOOP START	
	MOV R5, #2
LoopRed
	BL  red_led_on
    BL  delay
	BL  red_led_off
    BL  delay
		
	SUBS R5, R5, #1
	BNE LoopRed
; RED LOOP END


;GREEN LOOP START	
	MOV R6, #3
LoopGreen
	BL  green_led_on
    BL  delay
	BL  green_led_off
    BL  delay
	
	SUBS R6, R6, #1
	BNE LoopGreen
;GREEN LOOP END

	MOV R7, #0x00000005
	MOV R8, #0xFFFFFFFE
	MOV R9, #0x7FFFFFFF
	ADDS R7, R8
	SUBS R7, R7
	ADDS R9, R7
	SUBS R8, R9
	ADDS R8, R9

		
	B   Myloop

		END