     AREA     appcode, CODE, READONLY
     EXPORT __main
     ENTRY 
__main  FUNCTION
		MOV R1,#5			;Moving value of A into the register R1
		MOV R2,#10			;Moving value of B into the register R2
		MOV R3,#15			;Moving value of C into the register R3
		MOV  R4, #0x20000000;Address location for storing the large number
		CMP R1,R2			;Comparing A & B
		MOVLT R1,R2			;if A<B then copy B value into A
		CMP R1,R3			;Comparing A and Cs
		MOVLT R1,R3			;if A<C then copy C value into A
		STR R1,[R4]			;Storing the large number into the memory location 
stop    B stop 				;stop program
     ENDFUNC
     END 
