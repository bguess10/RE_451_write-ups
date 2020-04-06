; nasm -f elf32 -g -F dwarf question1.s -o ex.o
; ld -m elf_i386 ex.o -o ex

global _start

section .data
section .text

_start:
_problem1:
    mov ebp, esp
    mov eax, 0

    ; push to stack
    push 4 
    push 77
    push 18
    push 57
    push 9
    
    ; sum the list of numbers
    pop edx
    add eax, edx
    pop edx
    add eax, edx
    pop edx
    add eax, edx
    pop edx
    add eax, edx
    pop edx
    add eax, edx
    
    
    ; divide the sum by the count of the list
    mov edx, 0
    mov ebx, 5
    idiv ebx

_problem2:
    mov dword [ebp - 4], eax ; Store our initial avg on the stack (frees up the regs)
    mov dword [ebp - 8], 20 ; Lower Bound for comp
    mov dword [ebp - 12], 30 ; Upper Bound for comp
    mov dword [ebp - 16], 0x7FFFFFFF ; Lower Range
    mov dword [ebp - 20], 0x0 ; Upper Range
    mov dword [ebp - 24], 0 ; Total for full range
    mov dword [ebp - 28], 0 ; Number of increments for full sum
    mov dword [ebp - 32], 0 ; Total for partial range
    mov dword [ebp - 36], 0 ; NUmber of increments for partial sum
    sub esp, 36 

    ; Get everything on the stack
    mov ecx, 1
    LOAD_LOOP:
        push ecx
        inc ecx
        cmp ecx, [ebp - 4]
        jle LOAD_LOOP

    ; Do our operations in one loop    
    mov ecx, 1
    ITER_LOOP:
        ; Pop the val into ebx
        pop ebx

        ; Normal sum stuff
        add [ebp - 24], ebx
        inc dword [ebp - 28]

        ; Calculates the partial sum
        cmp ebx, [ebp - 12]
        jge ADD_FOR_PARTIAL
        cmp ebx, [ebp - 8]
        jle ADD_FOR_PARTIAL
        jmp SKIP_FOR_PARTIAL
        ADD_FOR_PARTIAL:
            add [ebp - 32], ebx
            inc dword [ebp - 36]
        SKIP_FOR_PARTIAL:

        ; Calculates the range
        cmp ebx, [ebp - 16]
        jge NO_REPLACE_LOW
        mov [ebp - 16], ebx
        NO_REPLACE_LOW:
        cmp ebx, [ebp - 20]
        jle NO_REPLACE_HIGH
        mov [ebp - 20], ebx
        NO_REPLACE_HIGH:

        ; Compare for loop
        inc ecx
        cmp ecx, [ebp - 4]
        jle ITER_LOOP
    
    mov edx, 0

    ; Get Partial sum E[x]
    mov eax, [ebp - 32]
    idiv dword [ebp - 36]
    mov ebx, eax

    ; Get Full sum E[x]
    mov eax, [ebp - 24]
    idiv dword [ebp - 28]

    ; Put ranges in ecx and edx
    mov ecx, [ebp - 16]
    mov edx, [ebp - 20]
    
    
_end:
    mov ebx, 0
    mov eax, 1
    int 0x80

