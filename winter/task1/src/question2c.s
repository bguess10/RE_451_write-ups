.text
    .globl simulate_range
    .type simulate_range, @function
simulate_range:
    pushq %rbx
    pushq %rcx
    pushq %rdx
    movq %rdi, %rbx 
    movq %rdi, %rdx
    movq %rdi, %rcx
    looptop:
        cmp %rbx, %rcx
        jge nextSTMT
        movq %rcx, %rbx
        nextSTMT:
        cmp %rdx, %rcx
        jle endSTMT
        movq %rcx, %rdx
        endSTMT:
        dec %rcx
        cmp $0, %rcx
        jg looptop
    subq %rbx, %rdx
    movq %rdx, %rax
    popq %rdx
    popq %rcx
    popq %rbx
    ret
