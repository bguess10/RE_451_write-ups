; nasm -f elf32 -g -F dwarf question3.s -o ex.o
; ld -m elf_i386 ex.o -o ex

global _start

section .data
section .text

_start:
_problem3:
    mov ebp, esp
    ; Make a place to store the iterations, mult, and sum
    mov dword [esp - 4], 0 ; Store the iterations
    mov dword [esp - 8], 1 ; Mult lower 32
    mov dword [esp - 12], 0 ; mult upper 32
    mov dword [esp - 16], 0 ; Sum location
    mov dword [esp - 20], 100 ; initial loop limit
    sub esp, 24
    
    ; Load the numbers into the loop for 0:[epb - 20], count the iterations with esi
    mov ecx, 0
    LOOP_LOAD_100:
        push ecx
        ; Checks if our current number is equal to a constant we want to repeat 10 times
        cmp ecx, 42
        jne INC_NUMS
            ; unrolled this part since there seems this repeats the exact same action
            mov dword [esp - 4], 42
            mov dword [esp - 8], 42
            mov dword [esp - 12], 42
            mov dword [esp - 16], 42
            mov dword [esp - 20], 42
            mov dword [esp - 24], 42
            mov dword [esp - 28], 42
            mov dword [esp - 32], 42
            mov dword [esp - 36], 42
            sub esp, 36
            add dword [ebp - 4], 9
        INC_NUMS:
        ; increment the loop variable and the iteration counter
        inc ecx
        inc dword [ebp - 4]
        cmp ecx, [ebp - 20]
        jle LOOP_LOAD_100

    ; prepare for another loop 1:[ebp - 20]
    mov ecx, 1
    mov esi, [ebp - 4]
    mov [ebp - 20], esi

    ; Mult numbers less than 30 and sum everything
    LOOP_THRU_100:
        pop ebx
        ; sum
        add [ebp - 16], ebx
        cmp ebx, 30
        jge NO_MULTIPLY_EBX
            ; multiply
            imul ebx, [ebp - 8]
            mov [ebp - 8], ebx
        NO_MULTIPLY_EBX:
        inc ecx
        cmp ecx, [ebp - 20]
        jle LOOP_THRU_100
    mov eax, [ebp - 8]  ; Multiplication Result in eax
    mov ebx, [ebp - 16] ; Sum result in ebx
    mov ecx, [ebp - 4]  ; Total number of iterations in ecx 
    
_end:
    mov ebx, 0
    mov eax, 1
    int 0x80
