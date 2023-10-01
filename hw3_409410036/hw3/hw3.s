/* ========================= */
/*       DATA section        */
/* ========================= */
    .data
/* --- variable a --- */
    .type a, %object
    .size a, 32
a:
    .word 1
    .word 2
    .word 3
    .word 4
    .word 5
    .word 6
    .word 7
    .word 8
/* --- variable b --- */
    .type b, %object
    .size b, 32
b:
    .word 8
    .word 7
    .word 6
    .word 5
    .word 4
    .word 3
    .word 2
    .word 1
/* --- variable c --- */
    .type c, %object
c:
    .space 16, 0

/* ========================= */
/*       TEXT section        */
/* ========================= */
    .section .text
    .global main
    .type main, %function
.matrix:
    .word a
    .word b
    .word c
main:
/* --- c(1,1) --- */
    ldr r0, .matrix
    ldr r1, [r0], #4    @r1=a(1,1)
    ldr r2, [r0], #4    @r2=a(1,2)
    ldr r3, [r0], #4    @r3=a(1,3)
    ldr r4, [r0]        @r4=a(1,4)

    ldr r0, .matrix+4
    ldr r5, [r0], #8    @r5=b(1,1)
    ldr r6, [r0], #8    @r6=b(2,1)
    ldr r7, [r0], #8    @r7=b(3,1)
    ldr r8, [r0]        @r8=b(4,1)

    ldr r0, .matrix+8
    mul r9, r1, r5
    mul r10, r2, r6
    add r9, r9, r10     @r9=r1*r5+r2*r6
    mul r10, r3, r7
    add r9, r9, r10     @r9=r1*r5+r2*r6+r3*r7
    mul r10, r4, r8
    add r9, r9, r10     @r9=r1*r5+r2*r6+r3*r7+r4*r8
    str r9,[r0]         @c(1,1)=r9

/* --- c(1,2) --- */
    ldr r0, .matrix
    ldr r1, [r0], #4    @r1=a(1,1)
    ldr r2, [r0], #4    @r2=a(1,2)
    ldr r3, [r0], #4    @r3=a(1,3)
    ldr r4, [r0]        @r4=a(1,4)

    ldr r0, .matrix+4
    add r0, r0, #4
    ldr r5, [r0], #8    @r5=b(1,2)
    ldr r6, [r0], #8    @r6=b(2,2)
    ldr r7, [r0], #8    @r7=b(3,2)
    ldr r8, [r0]        @r8=b(4,2)

    ldr r0, .matrix+8
    mul r9, r1, r5
    mul r10, r2, r6
    add r9, r9, r10     @r9=r1*r5+r2*r6
    mul r10, r3, r7
    add r9, r9, r10     @r9=r1*r5+r2*r6+r3*r7
    mul r10, r4, r8
    add r9, r9, r10     @r9=r1*r5+r2*r6+r3*r7+r4*r8
    str r9, [r0, #4]    @c(1,2)=r9

/* --- c(2,1) --- */
    ldr r0, .matrix
    add r0, r0, #16
    ldr r1, [r0], #4    @r1=a(2,1)
    ldr r2, [r0], #4    @r2=a(2,2)
    ldr r3, [r0], #4    @r3=a(2,3)
    ldr r4, [r0]        @r4=a(2,4)

    ldr r0, .matrix+4
    ldr r5, [r0], #8    @r5=b(1,1)
    ldr r6, [r0], #8    @r6=b(2,1)
    ldr r7, [r0], #8    @r7=b(3,1)
    ldr r8, [r0]        @r8=b(4,1)

    ldr r0, .matrix+8
    mul r9, r1, r5
    mul r10, r2, r6
    add r9, r9, r10     @r9=r1*r5+r2*r6
    mul r10, r3, r7
    add r9, r9, r10     @r9=r1*r5+r2*r6+r3*r7
    mul r10, r4, r8
    add r9, r9, r10     @r9=r1*r5+r2*r6+r3*r7+r4*r8
    str r9,[r0, #8]     @c(2,1)=r9

/* --- c(2,2) --- */
    ldr r0, .matrix
    add r0, r0, #16
    ldr r1, [r0], #4    @r1=a(2,1)
    ldr r2, [r0], #4    @r2=a(2,2)
    ldr r3, [r0], #4    @r3=a(2,3)
    ldr r4, [r0]        @r4=a(2,4)

    ldr r0, .matrix+4
    add r0, r0, #4
    ldr r5, [r0], #8    @r5=b(1,2)
    ldr r6, [r0], #8    @r6=b(2,2)
    ldr r7, [r0], #8    @r7=b(3,2)
    ldr r8, [r0]        @r8=b(4,2)

    ldr r0, .matrix+8
    mul r9, r1, r5
    mul r10, r2, r6
    add r9, r9, r10     @r9=r1*r5+r2*r6
    mul r10, r3, r7
    add r9, r9, r10     @r9=r1*r5+r2*r6+r3*r7
    mul r10, r4, r8
    add r9, r9, r10     @r9=r1*r5+r2*r6+r3*r7+r4*r8
    str r9,[r0, #12]     @c(2,2)=r9
    
    ldr r1, .matrix+8
    nop
    

    
