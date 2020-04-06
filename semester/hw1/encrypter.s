; nasm -f elf32 -g -F dwarf encrypter.s -o encrypter.o
; gcc -m32 -o encrypter encrypter.o -lc

global main

section .data
    enc:        db "Encrypted Value %d", 0x0a, 0x00 
    dec:        db "Decrypted Value %d", 0x0a, 0x00 
    failure:    db "Arguments: [0 = encrypt| 1 = decrypt] [key] [value]", 0x0a, 0x00 

section .text
    extern printf
    extern atoi

; Randomizes a single byte value, passed over al
rng_gen:
    mov ah, al

    ; Seed the value
    add al, 0xb

    ; shift and xor to generate a random number
    shr al, 3
    xor ah, al
    mov al, ah
    shl al, 5
    xor ah, al
    mov al, ah
    shr al, 2
    xor ah, al
    mov al, ah

    ret

; Takes its value from what was already on the stack, does rand_gen for all 4 bytes of 
;       the passed 32 bit integer
rng_gen_4_bytes:
    push ebp 
    mov ebp, esp
    push 0

    mov al, [ebp + 11]
    call rng_gen
    mov [esp+3], al

    mov al, [ebp + 10]
    call rng_gen
    mov [esp+2], al

    mov al, [ebp + 9]
    call rng_gen
    mov [esp+1], al

    mov al, [ebp + 8]
    call rng_gen
    mov [esp], al

    pop eax
    pop ebp
    ret
    
; Takes a key (which will be used as a decrypter as well)
encrypt:
    push ebp
    mov ebp, esp

    ; Gets the 4 random bytes using the seed on the stack
    push dword [ebp + 12]
    call rng_gen_4_bytes

    ; Adds and returns over eax
    add esp, 4
    mov ebx, eax
    mov eax, [ebp + 8]
    xor eax, ebx 

    pop ebp
    ret

decrypt:
    push ebp
    mov ebp, esp

    ; Gets the 4 random bytes using the seed on the stack
    push dword [ebp + 12]
    call rng_gen_4_bytes

    ; Subtracts and returns over eax
    add esp, 4
    mov ebx, eax
    mov eax, [ebp + 8]
    xor eax, ebx

    pop ebp
    ret
    

main:
    mov ebp, esp
    sub esp, 12

    ; Ensures that we have the right number of arguments
    cmp dword [ebp + 4], 4
    jne Failed_Code
    
    ; Parse command line args using atoi
    ; get type of op
    mov edx, [ebp + 8]
    mov eax, [edx + 4]
    push eax
    call atoi
    add esp, 4
    mov [ebp - 4], eax

    ; get key
    mov edx, [ebp + 8]
    mov eax, [edx + 8]
    push eax
    call atoi
    add esp, 4
    mov [ebp - 8], eax

    ; get value
    mov edx, [ebp + 8]
    mov eax, [edx + 12]
    push eax
    call atoi
    add esp, 4
    mov [ebp - 12], eax

    ; Check CLA 1 to see what operation is preferred, error out if its nonsense
    mov ebx, [ebp - 4]
    cmp ebx, 0
    je Encrypt
    cmp ebx, 1
    je Decrypt
    jmp Failed_Code

    Encrypt:
    ; Push args to the stack
    mov eax, [ebp - 8]
    push eax
    mov eax, [ebp - 12]
    push eax

    ; Call the encryption tool
    call encrypt
    add esp, 8

    ; Call printf to give you the encrypted value
    push eax
    push enc
    call printf
    add esp, 8
    jmp Main_Done

    Decrypt:
    ; Push args to the stack
    mov eax, [ebp - 8]
    push eax
    mov eax, [ebp - 12]
    push eax

    ; Call the decryption tool
    call decrypt
    add esp, 8

    ; Call printf to give you the decrypted value
    push eax
    push dec
    call printf
    add esp, 8
    jmp Main_Done

    ; Run here if there was an issue with the arguments
    Failed_Code:
    push failure
    call printf
    add esp, 4

    ; Clean up stack
    Main_Done:
    add esp, 12
    mov eax, 0
    ret