;Finding largest among the given three numbers using nested if else: Error encountered
    
	THUMB
	 AREA     Factorial, CODE, READONLY
     EXPORT __main
     ENTRY 
__main  FUNCTION		
     MOV R1,#10 ;Moving value of A into the register R1
	 MOV R2,#20	;Moving value of B into the register R2
	 MOV R3,#30	;Moving value of c into the register R3
	 CMP R1,R2	;Comparing A & B
     ITTE GE	;If-Then-Then-Else statements (if A>B)
	 CMPGE R1,R3 ;check for A>C 
	 ITEGE GE 
	 MOVGE R4,R1 ;if A>C then move the value of R1 into R4 
	 MOVLT R4,R3 ;else move R3 into R4
	 CMPLT R2,R3 ;if A<B then compare B and C
     ITELT GE	 ;if B>C satisfies 
	 MOVGE R4,R1 ;Move R1 into R4
	 MOVLT R4,R3 ;Else move R3 into R4

stop    B stop ; stop program
     ENDFUNC
     END 


Error:	 
assembling first.s...
first.s(12): error: A1163E: Unknown opcode ITEGE , expecting opcode or Macro
first.s(16): error: A1163E: Unknown opcode ITELT , expecting opcode or Macro
assembling startup_stm32f407xx.s...
compiling system_stm32f4xx.c...
".\Objects\first.axf" - 2 Error(s), 0 Warning(s).
  
	 
 
 