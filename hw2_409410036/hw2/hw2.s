    .section .text
    .global main
    .type main, %function
main:
        ldr r1,=#1              @r1:=1
        ldr r2,=#2              @r2:=2
        ldr r3,=#3              @r3:=3
        ldr r0,=#0              @r0:=0
        add r0,r0,r1,lsl #1     @r0=0+r1*2
        add r0,r0,r2,lsl #2     @r0=0+r1*2+r2*4
        add r0,r0,r3,lsl #3     @r0=0+r1*2+r2*4+r3*8
        nop
        .end
