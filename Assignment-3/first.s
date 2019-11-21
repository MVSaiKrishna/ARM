	
	THUMB
	 AREA     Symboid, CODE, READONLY
     EXPORT __main
	 IMPORT printMsg
     ENTRY 
__main    FUNCTION
		MOV R3,#41
		MOV R4,#1
		
		VLDR.F32 S7,=-5	;Holding 'x' Value
		VLDR.F32 S8,=0.25 ; increment
		

COUNT	CMP R4,R3			;Compare 'i' and 'n'
		BLE Main
		B stop

Main	VMOV.F32 S2,S7;		; Update the z value 
		BL Sigmoid 			; Calling Sigmoid function 
		VMOV.F32 R0,S12		; Moving the Sigmoid result to R0 register	
		BL printMsg			; Calling print function 
		VADD.F32 S7,S7,S8	; initial Value + increment of 0.25
		ADD R4,R4,#1		; Increment the counter variable
		B COUNT				; Again go to the comparision


Sigmoid MOV R0,#30		;Holding the Number of Terms in Series 'n'
        MOV R1,#1		;Counting Variable 'i'
        VLDR.F32 S0,=1	;Holding the sum of series elements 
        VLDR.F32 S1,=1	;Temp Variable to hold the intermediate series elements 
		VLDR.F32 S6,=1	
				
		
COUNT1  CMP R1,R0		;Compare 'i' and 'n' 
        BLE LOOP1		;if i < n goto LOOP
        BX LR			;else goto stop
		
LOOP1   VMUL.F32 S1,S1,S2	; t = t*x
        VMOV.F32 S5,R1		;Moving the bit stream in R1('i') to S5(floating point register)
        VCVT.F32.U32 S5,S5	;Converting the bitstream into unsigned fp Number 32 bit
        VDIV.F32 S1,S1,S5	;Divide temp by 'i' and store it back in 't'
        VADD.F32 S0,S0,S1	;Finally adding previous sum to new term and store it in sum
		VDIV.F32 S10,S6,S0	; e power minus x
		VADD.F32 S11,S10,S6	; 1+e power minus x
		VDIV.F32 S12,S6,S11	; 1/1+e power minus x
        ADD R1,R1,#1		;Increment the counter variable 'i'
        B COUNT1			;Again goto comparision
		
stop    B stop
        ENDFUNC
        END