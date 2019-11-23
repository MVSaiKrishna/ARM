; Assembly code to plot circle
;x=r*sin(theta)
;y=r*cos(theta)
;radius=150
;centre=(320,240)
	THUMB
	  AREA     pixels, CODE, READONLY
      EXPORT __main
	  IMPORT printMsg
	  IMPORT printMsg2p
	  IMPORT printMsg4p
      ENTRY 
__main  FUNCTION
		MOV R3,#91	; Incrementing the angle from to 0 to 360 with an increment of 4 degrees 
		MOV R4,#1	; Initial i value 

		VLDR.F32 S22,=0 ; initial angle
		VLDR.F32 S1,=4 ; increment
		
		VLDR.F32 S23,=150; radius
		
	;Degrees to Radian Conversion
		
		VLDR.F32 S31, =3.14159 ; storing Pi value 
		VLDR.F32 S30, =180 ; 
		VDIV.F32 S29,S31,S30 ; Pi/180
		
		VLDR.F32 S4,=2 ; to calculate 2*i, ((2*i)+1) and ((2*i)-1)
		
		;shifting the centre to (320,240)
		VLDR.F32 S18,=320; x shift
		VLDR.F32 S19,=240; y shift

COUNT	CMP R4,R3			;Compare 'i' and 'n'
		BLE Angle
		B stop


Angle	VMUL.F32 S2,S2,S29 ; (pi/180)*angle - given angle is converted to radians 

	;Every term has to be multiplied by x^2 for next iteration 
		VMUL.F32 S3,S2,S2 ; x*x
		
		;VCVT.U32.F32 S22,S22
		VMOV.F32 R0,S22		; R0 is updated with new angle after every iteration
		;BL printMsg	 ; 
		
		BL SIN			; Calling Sin(theta) function
		VMUL.F32 S24,S0,S23	; r*sin(theta)
		VADD.F32 S24,S24,S18	; y-shift+r*sin(theta)
		VCVT.U32.F32 S24,S24	; Converting the result to Integer value from IEEE-754 format
		VMOV.F32 R0,S24		; Moving the integer value to R0 register  
		;BL printMsg	 ; 
		
		BL COS			; Calling Sin(theta) function
		VMUL.F32 S26,S20,S23	; r*cos(theta)
		VADD.F32 S26,S26,S19	; x-shift+r*cos(theta)
		VCVT.U32.F32 S26,S26	; onverting the result to Integer value from IEEE-754 format
		VMOV.F32 R1,S26		; Moving the integer value to R1 register
		BL printMsg2p	 	; Calling printMsg c function to the values of (Xi,Yi) 	
		
		VADD.F32 S22,S22,S1	; Increment the angle by 4 degrees 
		VMOV.F32 S2,S22;	; Storing the new angle calculated after every iteration in S2 register
		ADD R4,R4,#1		; Counter to repeat the loop 
		B COUNT			; goto COUNT after every iteration until the condition is satisfied 
		
		

SIN		MOV R5,#10 ; No of terms in a series 
		MOV R1,#1 ; counting variable n (To repeat the loop)

		VMOV.F32 S11,S2 ; Using S11 to store the intermediate result of sinx
		VMOV.F32 S0,S2	; Sinx result is stored in s0 register 
		
		VLDR.F32 S5,=1; i value
		VLDR.F32 S6,=1; increment value
		

COUNT1  CMP R1,R5			;Compare 'i' and 'n' 
		BLE LOOP1			;if i < n goto LOOP
		BX LR			; Return to the main program once the sin(theta) is calculated 
			
LOOP1   VMUL.F32 S7,S4,S5	; 2*i
		VADD.F32 S8,S7,S6	; (2*i)+1
		
		;Calculating next term for sinx 
		VNMUL.F32 S9,S11,S3	; 
		VDIV.F32 S10,S9,S7
		VDIV.F32 S11,S10,S8
		
		;Adding the new term to the previous result 
		VADD.F32 S0,S0,S11	; (for sinx)
		
		;incrementing i value
		VADD.F32 S5,S5,S6
		
		ADD R1,R1,#1		;Increment the counter variable 'i'
		B COUNT1				;Again goto comparision
		
COS		MOV R5,#10 ; No of terms in a series 
		MOV R1,#1 ; counting variable n (To repeat the loop)
		
		VLDR.F32 S20,=1 ; Cosx  result is stored in s20 register
		VLDR.F32 S15,=1	; Using S15 to store the intermediate result of cosx
		
		VLDR.F32 S5,=1; i value
		VLDR.F32 S6,=1; increment value
		
COUNT2	CMP R1,R5			;Compare 'i' and 'n' 
		BLE LOOP2			;if i < n goto LOOP
		BX LR			; Return to the main program once the cos(theta) is calculated 
			
LOOP2   VMUL.F32 S7,S4,S5	; 2*i
		VSUB.F32 S12,S7,S6	; (2*i)-1
		
		;Calculating next term for sinx 
		VNMUL.F32 S13,S15,S3; 
		VDIV.F32 S14,S13,S7
		VDIV.F32 S15,S14,S12
		
		;Adding the new term to the previous result 
		VADD.F32 S20,S20,S15; (for cosx)
		
		;incrementing i value
		VADD.F32 S5,S5,S6
		
		ADD R1,R1,#1		;Increment the counter variable 'i'
		B COUNT2			;Again goto comparision
			
stop    B stop
		ENDFUNC
		END 
	 

 
