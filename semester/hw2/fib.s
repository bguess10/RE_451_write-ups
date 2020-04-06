; nasm -f elf32 -g -F dwarf fib.s -o fib.o
; g++ -m32 -o fib fib.o -lc
global main

section .data
    result_text: db "The value of a %d degree fibonacci is %u",0x0a,0x0
    failed_text: db "Arguments: [fibonacci degeree (defaults to 13)]",0x0a,0x0

section .text
    extern printf
    extern atoi

; fib(degree : i32)
; returns the result into degree 
fib:
    push ebp
    mov ebp, esp
    sub esp, 16
    push dword [ebp + 8]
    pop dword [esp + 12] ; target
    mov dword [esp + 8], 0 ; n-2 value
    mov dword [esp + 4], 1 ; n-1 value
    mov dword [esp], 1 ; counter


    ; ebp is useless from this point until return
    ; deal with 0 and 1
    mov ebp, [esp+12]
    cmp ebp, 0 
    je fib_zero_cond
    cmp ebp, 1
    je fib_done

    ; deal with [2,47]
    fib_loop:
    mov ebp, [esp + 8]
    add ebp, [esp + 4]
    push ebp
    mov ebp, [esp + 8]
    mov [esp + 12], ebp
    pop ebp
    mov [esp + 4], ebp

    inc dword [esp]
    mov ebp, [esp]
    cmp ebp, [esp + 12]
    jl fib_loop
    jmp fib_done

    
    fib_zero_cond:
    mov dword [esp+4], 0

    fib_done:
    push dword [esp + 4]
    pop ebp 
    add esp, 16
    mov [esp + 8], ebp
    pop ebp
    ret

; Registers are used in main for operate functions like printf and atoi, as well as return the proper code
; However, only ebp and esp are used in fib
main:
    mov ebp, esp
    sub esp, 4

    ; Ensures that we have the right number of arguments
    cmp dword [ebp + 4], 2
    jg failed_code
    cmp dword [ebp + 4], 1
    jne has_argument
    mov dword [ebp - 4], 13
    jmp run_fib


    has_argument:
    ; Parse command line args using atoi
    ; get type of op
    mov edx, [ebp + 8]
    mov eax, [edx + 4]
    push eax
    call atoi
    add esp, 4
    mov [ebp - 4], eax

    run_fib:
    push dword [ebp - 4]
    call fib
    mov ebx, [esp]
    add esp, 4

    push ebx
    push dword [ebp - 4]
    push result_text
    call printf
    add esp, 12
    jmp Main_Done

    failed_code:
    push failed_text
    call printf
    add esp, 8
    mov eax, 1
    ret
    


    Main_Done:
    add esp, 4
    mov eax, 0
    ret