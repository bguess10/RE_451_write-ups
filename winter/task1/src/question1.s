.text
    .globl simple_avg
    .type simple_avg, @function
simple_avg:
    /* Save values used by the previous function*/
    push %rbx
    push %rcx
    push %rdx

    /* Do stuff */
    push $4
    push $77 
    push $18
    push $57
    push $9
    mov $0, %rax
    mov $5, %rcx
    looptop:
        pop %rbx
        add %rbx, %rax
        dec %rcx
        cmp $0, %rcx
        jg looptop
        
    mov $0, %rdx
    mov $5, %rbx
    idiv %rbx

    /* Pop the old values back into place */
    pop %rdx
    pop %rcx
    pop %rbx
    ret

