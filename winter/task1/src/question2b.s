.text
    .globl bad_ranged_avg
    .type bad_ranged_avg, @function
bad_ranged_avg:
    pushq %rbx
    pushq %rcx
    pushq %rdx
    pushq %rsi
    movq %rdi, %rcx
    movq $0, %rbx
    movq $0, %rsi
    looptop:
        cmp $21, %rcx
        jl altSTMT
        cmp $29, %rcx
        jg altSTMT
            inc %rsi
        jmp endSTMT
        altSTMT:
            addq %rcx, %rbx
        endSTMT:
        dec %rcx
        cmp $0, %rcx
        jg looptop
    movq %rbx, %rax
    movq $0, %rdx
    subq %rsi, %rdi
    idiv %rdi
    popq %rsi
    popq %rdx
    popq %rcx
    popq %rbx
    ret
