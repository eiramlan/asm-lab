; Build:  make           (or: nasm -felf64 hello.asm && gcc -nostartfiles -no-pie -o hello hello.o)
; Run:    make run

global _start

section .text
_start:
    mov rax, 1          ; sys_write
    mov rdi, 1          ; fd = stdout
    mov rsi, msg
    mov rdx, msglen
    syscall

    mov rax, 60         ; sys_exit
    xor rdi, rdi
    syscall

section .rodata
msg:    db "Hello, x86-64!", 10
msglen: equ $ - msg
