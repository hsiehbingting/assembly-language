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
output:
    .ascii "%d\000"
output_comma:
    .ascii ", \000"
 
str_add:
    .space 40,0
    .align 4
result:
    .word file_name
    .word 0x4
    .word 0x8

file_name:
    .ascii "result.txt"


/* ========================= */
/*       TEXT section        */
/* ========================= */
    .section .text
    .global main
    .type main,%function
.matrix:
    .word a
.write:
    .space 4
    .space 4
    .space 4
main:
    mov ip,sp
    stmfd sp!, {fp, ip, lr, pc}
    sub fp, ip, #4

     /*put array size into r0*/
    ldr r0, =#8         @r0 = 8
    /*prepare input array*/
    ldr r1, .matrix     @r1 = &a[0]
  
    bl NumSort



    @r0=new array address 
    /*printf result array*/
    
    mov r10, #1     @r10 = i
    mov r9, r0      @r9 = &a[0]

    /* --- file open --- */
    ldr r0, =#0x1
    ldr r1, =result
    swi 0x123456
    mov r8, r0  @r8 = descriptor


LOOP2:
    cmp r10, #8         @cmp(i,array size)
    bgt EXIT2           @if(i > 8)EXIT
    
    /* --- int to str ---*/
    ldr r0, =str_add
    ldr r1, =output
    ldr r2, [r9]    @r2 = r9 = &a[0]
    bl sprintf
    
    /* output num */
    ldr r0, =str_add
    adr r1, .write
    str r8, [r1]        @[r1] = r8 = descriptor
    str r0, [r1, #4]    @address
    ldr r0, =#1
    str r0, [r1, #8]    @length
    ldr r0, =#0x5
    swi 0x123456

    cmp r10, #8         @cmp(i,array size)
    bge EXIT3

    /* output comma */
    ldr r0, =output_comma
    adr r1, .write
    str r8, [r1]        @[r1] = r8 = descriptor
    str r0, [r1, #4]    @address
    ldr r0, =#1
    str r0, [r1, #8]    @length
    ldr r0, =#0x5
    swi 0x123456

EXIT3:

    add r9, r9, #4      @r9 = &a[i+1] 
    add r10, r10, #1    @i++
    b LOOP2
EXIT2:

    /* --- file close --- */
    ldr r0, =#0x2
    mov r1, r8
    swi 0x123456

    nop
    ldmea fp, {fp, sp, pc}
    .end
