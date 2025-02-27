;	int main(int argc, char** argv) {
;		signed short num1 = 4660;	// use dw to declare 16-bit variable
;		signed short num2 = -292;	// use dw to declare 16-bit variable
;		signed short dif = 0; 	// use dw to declare 16-bit variable
;		dif = num1 - num2;
;		return 0;

section .data
SYS_exit equ 60
EXIT_SUCCESS equ 0
num1 dw 4660
num2 dw -292
dif dw 0

section .text
    global _start
_start:
	mov ax, word[num1]
	sub ax, word[num2]
    mov word[dif], ax

    mov rax, SYS_exit
    mov rdi, EXIT_SUCCESS
    syscall
