; Finding the exp(x) for different values of x. No of terms to be considered is varied and readings have been noted down	
	
	THUMB
	 AREA     Exponential, CODE, READONLY
     EXPORT __main
     ENTRY 
__main    FUNCTION
        MOV R0,#10		;Holding the Number of Terms in Series 'n'
        MOV R1,#1		;Counting Variable 'i'
        VLDR.F32 S0,=1	;Holding the sum of series elements 
        VLDR.F32 S1,=1	;Temp Variable to hold the intermediate series elements 
        VLDR.F32 S2,=3	;Holding 'x' Value
		
COUNT   CMP R1,R0		;Compare 'i' and 'n' 
        BLE LOOP		;if i < n goto LOOP
        B stop			;else goto stop
		
LOOP    VMUL.F32 S1,S1,S2	; temp = temp*x
        VMOV.F32 S5,R1		;Moving the bit stream in R1('i') to S5(floating point register)
        VCVT.F32.U32 S5,S5	;Converting the bitstream into unsigned fp Number 32 bit
        VDIV.F32 S1,S1,S5	;Divide temp by 'i' and store it back in 't'
        VADD.F32 S0,S0,S1	;Finally add previous value to new term and store it in sum
        ADD R1,R1,#1		;Increment the counter variable 'i'
        B COUNT				;Again goto comparision
		
stop    B stop
        ENDFUNC
        END