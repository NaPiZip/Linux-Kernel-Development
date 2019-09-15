;;kernel.asm
bits 32			;nasm directive - 32 bit
section .text
	;multiboot spec
	align 4
	dd 0x1BADB002		;magic flag
	dd 0x00			;flags
	dd - (0x1BADB002 + 00)	;checksum. m+f+c should lead to zero

global start
extern kmain		;kmain is defined in the c file

start:
  cli 			;clear interrupt flag  blocks iterrupts
  mov esp, stack_space	;set stack pointer
  call kmain		
  hlt			;halt the CPU

section .bss
 resb 8192		;8KB for stack
 stack_space:
