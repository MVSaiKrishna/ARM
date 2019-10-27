     AREA     appcode, CODE, READONLY
     EXPORT __main
     ENTRY 
__main  FUNCTION
		MOV R1,#6		;Moving first number into the register R0
		MOV R2,#12		;Moving second number 0 into the register R1		
GCD    	CMP R1,R2		;Comparing both the numbers
		SUBGT R1,R1,R2	;If value of R1> value of R2 then perform R1-R2 
		SUBLT R2,R2,R1	;If value of R1< value of R2 then perform R2-R1 
		BNE    GCD		;If the numbers are not equal repeat the process
stop    B stop 			; stop program
     ENDFUNC
     END 