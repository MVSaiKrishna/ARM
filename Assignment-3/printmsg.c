#include "stm32f4xx.h"
#include <string.h>

void printMsg(const int a)
{
	 char Msg[100];
	 char *ptr;
	 sprintf(Msg, "%x\n", a);
	 ptr = Msg ;
   while(*ptr != '\0'){
      ITM_SendChar(*ptr);
      ++ptr;
   }
}

void printMsg4p(const int a, const int b, const int c, const int d)
{
	 char Msg[100];
	 char *ptr;

	 //Printing the first parameter
	 sprintf(Msg, "%x\t", a);
	 ptr = Msg ;
   while(*ptr != '\0')
	 {
      ITM_SendChar(*ptr);
      ++ptr;
   }
	 // Printing the message
	 sprintf(Msg, "%x\t", b);
	 ptr = Msg ;
   while(*ptr != '\0')
	 {
      ITM_SendChar(*ptr);
      ++ptr;
   }
	 // Printing the message
	 sprintf(Msg, "%x\t", c);
	 ptr = Msg ;
   while(*ptr != '\0')
	 {
      ITM_SendChar(*ptr);
      ++ptr;
   }
	 // Printing the message
	 sprintf(Msg, "%x\n", d);
	 ptr = Msg ;
   while(*ptr != '\0')
	 {
      ITM_SendChar(*ptr);
      ++ptr;
	 }
}

void printMsg2p(const int a, const int b)
{
	 char Msg[100];
	 char *ptr;

	 //Printing the first parameter
	 sprintf(Msg, "%x\t", a);
	 ptr = Msg ;
   while(*ptr != '\0')
	 {
      ITM_SendChar(*ptr);
      ++ptr;
   }
	 // Printing the message
	 sprintf(Msg, "%x\n", b);
	 ptr = Msg ;
   while(*ptr != '\0')
	 {
      ITM_SendChar(*ptr);
      ++ptr;
   }
}

void printp(const int a)
{
char *ptr_n;
	 
	 if(a==0){ ptr_n = "Logic AND\nX0\tX1\tX2\tY\n"; }
	 if(a==1){ ptr_n = "Logic OR\nX0\tX1\tX2\tY\n"; }
	 if(a==2){ ptr_n = "Logic NAND\nX0\tX1\tX2\tY\n"; }
	 if(a==3){ ptr_n = "Logic NOR\nX0\tX1\tX2\tY\n"; }
	 if(a==4){ ptr_n = "Logic XOR\nX0\tX1\tX2\tY\n"; }
	 if(a==5){ ptr_n = "Logic XNOR\nX0\tX1\tX2\tY\n"; }
	 if(a==6){ ptr_n = "Logic NOT\nX\tY\n"; }
	
	 while(*ptr_n != '\0'){
      ITM_SendChar(*ptr_n);
      ++ptr_n;
   }
	 return;}