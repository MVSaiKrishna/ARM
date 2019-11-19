	
	THUMB
	  AREA     pixels, CODE, READONLY
      EXPORT __main
	  IMPORT printMsg
	  IMPORT printMsg2p
	  IMPORT printMsg4p
      ENTRY 
__main  FUNCTION
		MOV R3,#10
		MOV R4,#1

		VLDR.F32 S22,=0 ; initial angle
		VLDR.F32 S1,=30 ; increment
		
		VLDR.F32 S23,=10; radius
		
	;Degrees to Radian Conversion
		
		VLDR.F32 S31, =3.14159 ; storing Pi value 
		VLDR.F32 S30, =180 ; 
		VDIV.F32 S29,S31,S30 ; Pi/180
		
		VLDR.F32 S4,=2 ; to calculate 2*i, ((2*i)+1) and ((2*i)-1)

COUNT	CMP R4,R3			;Compare 'i' and 'n'
		BLE Angle
		B stop


Angle	VMUL.F32 S2,S2,S29 ; (pi/180)*angle - given angle is converted to radians 

	;Every term has to be multiplied by x^2 for next iteration 
		VMUL.F32 S3,S2,S2 ; x*x
		
		VCVT.U32.F32 S22,S22
		VMOV.F32 R0,S22
		;BL printMsg4p	 ; Refer to ARM Procedure calling standards.
		BL SIN
		VMUL.F32 S24,S0,S23
		VCVT.U32.F32 S24,S24
		VMOV.F32 R1,S24	
		;BL printMsg4p	 ; Refer to ARM Procedure calling standards.
		BL COS
		VMUL.F32 S26,S20,S23
		VCVT.U32.F32 S26,S26
		VMOV.F32 R2,S26	
		BL printMsg4p	 ; Refer to ARM Procedure calling standards.
		VADD.F32 S22,S22,S1	;
		VMOV.F32 S2,S22;
		ADD R4,R4,#1
		B COUNT
		
		

SIN		MOV R0,#10 ; No of terms in a series 
		MOV R1,#1 ; counting variable n (To repeat the loop)

		VMOV.F32 S11,S2 ; Using S11 to store the intermediate result of sinx
		VMOV.F32 S0,S2	; Sinx result is stored in s0 register 
		
		VLDR.F32 S5,=1; i value
		VLDR.F32 S6,=1; increment value
		

COUNT1   CMP R1,R0			;Compare 'i' and 'n' 
		BLE LOOP1			;if i < n goto LOOP
		BX LR
			
LOOP1    VMUL.F32 S7,S4,S5	; 2*i
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
		
COS		MOV R0,#10 ; No of terms in a series 
		MOV R1,#1 ; counting variable n (To repeat the loop)
		
		VLDR.F32 S20,=1 ; Cosx  result is stored in s20 register
		VLDR.F32 S15,=1	; Using S15 to store the intermediate result of cosx
		
		VLDR.F32 S5,=1; i value
		VLDR.F32 S6,=1; increment value
		
COUNT2   CMP R1,R0			;Compare 'i' and 'n' 
		BLE LOOP2			;if i < n goto LOOP
		BX LR
			
LOOP2    VMUL.F32 S7,S4,S5	; 2*i
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
	 

 
