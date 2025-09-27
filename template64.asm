; 64-bit Linux, pure syscalls
global _start
section .text
_start:
    ; ... your code ...
    xor rdi, rdi    ; status 0
    mov rax, 60     ; sys_exit
    syscall
