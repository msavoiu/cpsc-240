;	int main(int argc, char** argv) {
;		unsigned long num1 = 50,000,000,000; 	// use dq to declare 64-bit variable
;		unsigned int num2 = 3,333,333; 	// use dd to declare 32-bit variable
;		unsigned int quotient = 0, remainder = 0; 	// use dd to declare 32-bit variable
;		quotient = num1 / num2;
;		remainder = num1 % num2;
;		return 0;
;	}

section .data
SYS_exit equ 60
EXIT_SUCCESS equ 0
num1 dq 50000000000
num2 dd 3333333
quotient dd 0
remainder dd 0

section .text
        global _start
_start:
        ; splitting num1 (64-bit) into two 32-bit registers so it can be divided by a 32-bit operand (num2)
        
        ; the first "half" of the number:
        mov eax, dword[num1]

        ; second half is accessed by jumping "up" 4 bytes (32 bits) from the start of the 64-bit register in memory
        mov edx, dword[num1+4]

        ; division is automatically performed on those 2 registers (edx:eax) when a 32-bit operand is provided?
        div dword[num2]

        ; move the temporarily stored quotient and remainder into the desired variables
        mov dword[quotient], eax
        mov dword[remainder], edx
_stop:
l36:    mov rax, SYS_exit
        mov rdi, EXIT_SUCCESS
        syscall
