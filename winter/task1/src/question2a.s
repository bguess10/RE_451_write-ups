.text
    .globl ranged_avg
    .type ranged_avg, @function
ranged_avg:
    pushq %rbx
    pushq %rcx
    pushq %rdx
    movq %rdi, %rcx
    movq $0, %rbx
    looptop:
        addq %rcx, %rbx
        dec %rcx
        cmp $0, %rcx
        jg looptop
    movq %rbx, %rax
    movq $0, %rdx
    idiv %rdi
    popq %rdx
    popq %rcx
    popq %rbx
    ret
