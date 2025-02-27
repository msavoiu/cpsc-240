;	int main(int argc, char** argv) {
;		unsigned int num1 = 300,000; 	// use dd to declare 32-bit variable
;		unsigned int num2 = 400,000; 	// use dd to declare 32-bit variable
;		unsigned long product = 0; 	// use dq to declare 64-bit variable
;		product = long(num1 * num2);
;		return 0;
;	}

; product is 120,000,000,000, which only requires 32 bits to store?
; CORRECT! the rest of 'product' should just be filled with 0's, which will be stored in edx by the MUL instruction

section .data
SYS_exit equ 60
EXIT_SUCCESS equ 0
num1 dd 300000 ; doubleword: 4 bytes
num2 dd 400000
product dq 0 ;quadword: 8 bytes

section .text
        global _start
_start:
        mov eax, dword[num1] ; move our first value into the reserved "multiplication register"
        mul dword[num2] ; does it automatically know to use the value in eax?
        mov dword[product], eax
        mov dword[product+4], edx ; this should just move some 0's in?
_stop:
l26:    mov rax, SYS_exit
        mov rdi, EXIT_SUCCESS
        syscall
