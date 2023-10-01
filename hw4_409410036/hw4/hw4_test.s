/* ========================= */
/*       DATA section        */
/* ========================= */
    .data
/* --- variable a --- */
    .type a, %object
    .size a, 32
a:
    .word 6
    .word 3
    .word 8
    .word 5
    .word 4
    .word 7
    .word 2
    .word 1
/* ========================= */
/*       TEXT section        */
/* ========================= */
    .section .text
    .global main
    .type main,%function
.matrix:
    .word a
main:
    mov ip,sp
    stmfd sp!, {fp, ip, lr, pc}
    sub fp, ip, #4

    /*prepare input array*/
    ldr r0, .matrix     @r0=&a[0]
    /*put array size into r9*/
    ldr r9, =#8         @r9=8
    /*put array address into r10*/
    mov r10, r0         @r10=r0=&a[0]

    bl NumSort

    nop
    ldmea fp, {fp, sp, pc}
    .end
