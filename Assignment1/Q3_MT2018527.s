     AREA     appcode, CODE, READONLY
     EXPORT __main
     ENTRY 
__main  FUNCTION
		MOV R1,#9			;Moving the given number into register R1
		AND R2,R1,#1		;Performing logical AND operation between the given number and 1. Storing the result in R2 
		MOV  R4, #0x20000000;Memory address to store the result
		STR R2,[R4]			;If the given number is EVEN then the value stored in the memory location 0. If it is ODD then the value stored is 1
stop    B stop 				; stop program
     ENDFUNC
     END 