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

/* --- string --- */
output_I:
    .ascii "Input array: \000"
output:
    .ascii "%d\000"
output_comma:
    .ascii ", \000"
output_R:
    .ascii "\nResult array: \000"

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

     /*put array size into r0*/
    ldr r0, =#8         @r0 = 8
    /*prepare input array*/
    ldr r1, .matrix     @r1 = &a[0]
  
    bl NumSort

    /*printf input array*/
    mov r10, #1     @r10 = i
    mov r9, r0      @r9 = &a[0]
    ldr r8, .matrix
    ldr r0, =output_I
    bl printf 
LOOP1:
    cmp r10, #8         @cmp(i,array size)
    bgt EXIT1           @if(i > 8)EXIT
    ldr r0, =output
    ldr r1, [r8]        @r1 = a[i]
    bl printf
    
    cmp r10, #8         @cmp(i,array size)
    ldrlt r0, =output_comma
    bllt printf

    add r8, r8, #4      @r2 = &a[i+1]
    add r10, r10, #1    @i++
    b LOOP1
EXIT1:

    /*printf result array*/
    mov r10, #1     @r10 = i
    mov r9, r9      @r9 = &a[0]
    ldr r0, =output_R
    bl printf 
LOOP2:
    cmp r10, #8         @cmp(i,array size)
    bgt EXIT2           @if(i > 8)EXIT
    ldr r0, =output
    ldr r1, [r9]        @r1 = a[i]
    bl printf
    
    cmp r10, #8         @cmp(i,array size)
    ldrlt r0, =output_comma
    bllt printf

    add r9, r9, #4      @r2 = &a[i+1]
    add r10, r10, #1    @i++
    b LOOP2
EXIT2:

    nop
    ldmea fp, {fp, sp, pc}
    .end
