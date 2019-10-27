     AREA     appcode, CODE, READONLY
     EXPORT __main
     ENTRY 
__main  FUNCTION		
    MOV R0,#0			;Moving 0 into the register R0
    MOV R1,#1			;Moving 1 into the register R1
    MOV R3,#100			;Upto what number you want the series
	MOV R5,#0x20000000	;Starting addreess of the fibonacci series
    MOV R4,#0			;Stores the next element of the series from the addition result of present and previous values   
    ADD R4,R0,R1		;Adding present and previous numbers of the series 
L1 	CMP R4,R3			;Checking if present value is less than the required value
    BLE LOOP			;if less goto LOOP
    B stop				;Else goto end 
LOOP STR R4,[R5],#4		;Storing the series of numbers into memory
    MOV R0,R1			;Moving previous value to R0 
    MOV R1,R4			;Moving present value to R1
    ADD R4,R0,R1		;Next value is obtained by adding present and previous values
    B L1				;Repeat the loop until R4 value > required value 
stop    B stop 			;stop program
     ENDFUNC
     END 
