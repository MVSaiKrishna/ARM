	
	THUMB
	 AREA     Symboid, CODE, READONLY
     EXPORT __main
	 IMPORT printMsg
     ENTRY 
__main    FUNCTION

		
		VLDR.F32 S7,=0.5	;	w0
		VLDR.F32 S8,=-0.7	;	w1 
		VLDR.F32 S9,=-0.7	;	w2
		
		VLDR.F32 S13,=1	;	x0	
		VLDR.F32 S14,=0	;	x1
		VLDR.F32 S15,=0	;	x2
		
		VLDR.F32 S25,=0.1	;	bias
		VLDR.F32 S26,=0.5	;	Adding 0.5 to the final result to check whether the result is >0.5 or <0.5
		
		VMUL.F32 S16,S7,S13	; w0*x0
		VMUL.F32 S17,S8,S14	; w1*x1
		VMUL.F32 S18,S9,S15	; w2*x2
		
		VADD.F32 S19,S16,S17	; (w0*x0)+(w1*x1)
		VADD.F32 S20,S18,S19	; (w0*x0)+(w1*x1)+(w2*x2)
		VADD.F32 S21,S20,S25	; (w0*x0)+(w1*x1)+(w2*x2)+Bias

		VMOV.F32 S2,S21	;	z=(w0*x0)+(w1*x1)+(w2*x2)+Bias Loading final z value


Sigmoid MOV R0,#35		;Holding the Number of Terms in Series 'n'
        MOV R1,#1		;Counting Variable 'i'
        VLDR.F32 S0,=1	;Holding the sum of series elements 
        VLDR.F32 S1,=1	;Temp Variable to hold the intermediate series elements 
		VLDR.F32 S6,=1	
				
		
COUNT1  CMP R1,R0		;Compare 'i' and 'n' 
        BLE LOOP1		;if i < n goto LOOP
        B stop			;else goto stop
		
LOOP1   VMUL.F32 S1,S1,S2	; t = t*x
        VMOV.F32 S5,R1		;Moving the bit stream in R1('i') to S5(floating point register)
        VCVT.F32.U32 S5,S5	;Converting the bitstream into unsigned fp Number 32 bit
        VDIV.F32 S1,S1,S5	;Divide temp by 'i' and store it back in 't'
        VADD.F32 S0,S0,S1	;Finally adding previous sum to new term and store it in sum
		VDIV.F32 S10,S6,S0	; e power minus x
		VADD.F32 S11,S10,S6	; 1+e power minus x
		VDIV.F32 S12,S6,S11	; 1/1+e power minus x
		VMOV.F32 R0,S12
		BL printMsg
		VADD.F32 S12,S12,S26; Result=Result+0.5 (if result>0.5 then output is 1 otherwise 0)
		VCVT.U32.F32 S12,S12	; Converting IEEE-754 format to Interger
		VMOV.F32 R0,S12		; Moving the Sigmoid result to R0 register
		BL printMsg			; Branching to print function in c
        ADD R1,R1,#1		;Increment the counter variable 'i'
        B COUNT1			;Again goto comparision
		
stop    B stop
        ENDFUNC
        END