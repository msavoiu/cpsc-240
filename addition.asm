;	int main(int argc, char** argv) {
;		unsigned short num1 = 65244; 	// use dw to declare 16-bit variable
;		unsigned short num2 = 4660; 	// use dw to declare 16-bit variable
;		unsigned int sum = 0; 	// use dd to declare 32-bit variable
;		sum = int(num1 + num2);
;		return 0;
;	}

; WORKS
section .data
SYS_exit	equ	60
EXIT_SUCCESS	equ	0
num1		dw	65244
num2		dw	4660
sum		dd	0
; word = 2 bytes = 16 bit
; doubleword = 4 bytes = 32-bit

section .text
        global _start
_start:
	mov dx, 0 ; clear dx
        ; why don't we need to clear ax?
                ; the value inside ax gets overwritten by the next instruction
                ; dx specifically needs to be 0 because it should hold the carry and nothing else

        mov ax, word[num1] ; brackets to access memory (mov ax, num1 will only move the memory address of num1)
        add ax, word[num2]
	
        adc dx, 0
        ; ADC is the same as ADD but adds an extra 1 if processor's carry flag is set
                ; adding 0 and whatever's in dx (in this case, 0)
                ; the extra 1 is set because of the carry flag emitted by the previous ADD operation

        ; eax is a 32-bit register, we need to carry to bit 16, but it doesn't have a name??
        ; use dx as temporary storage instead because we don't have a name for the high 16 bits we need

        ; TLDR:
        ; hold non carried part of the number in ax
        ; hold the carry in dx
        ; grab the numbers from both those 16 bit registers to move them over and conslidate in one 32-bit register (rax)

        ; move what's in the registers into our sum variable:
        mov word[sum+0], ax
        mov word[sum+2], dx		; do NOT do [sum+1], since the original number without carry already uses 2 bytes it would override					; mov word[sum], ax
        
l39:    mov rax, SYS_exit		; terminate executing process
        mov rdi, EXIT_SUCCESS		; exit status
        syscall				; calling system services
