; 32-bit Linux, pure syscalls
global _start
section .text
_start:
    ; ... your code ...
    mov eax, 1      ; sys_exit
    xor ebx, ebx    ; status 0
    int 0x80
