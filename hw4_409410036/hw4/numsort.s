
    .section .text
    .global NumSort
    .type NumSort,%function

NumSort:
    stmfd sp!,{r0-r9, fp, ip, lr}

    /*get array size from r9*/
    mov r0, r9
    /*get array address from r10*/
    mov r1, r10

    ldr r2, =0x22220
    ldr r3, =#0         @i = 0;
LOOP1:                  @for(i = 0; i < size;)   @將資料移至新區域（未排列）
    cmp r3, r0          
    bge EXIT1           @i >= size
    ldr r4, [r1], #4    @temp = [r1]
    str r4, [r2], #4    @[r2] = temp
    add r3, r3, #1      @i++
    b LOOP1
EXIT1:
    
    /*
    r0 : size    
    r1 : &a[i]
    r2 : &a[j]
    r3 : i
    r4 : j
    r5 : a[i]
    r6 : a[j]
    r7 : temp

    for(int i = 0; i < size; i++)
        for(int j = i + 1; j < size ;j++)
        {
            if(a[i] > a[j])
                swap(a[i], a[j]);            
        }

    */

    mov r0, r0
    ldr r1, =0x22220        @r1 = &a[i]
    ldr r3,=#0              @i = 0

LOOP2:                      @for(i = 0; i < size;)          @第一層迴圈
    cmp r3, r0
    bge EXIT2

    add r4, r3, #1          @j = i + 1
    mov r2, r1                      
    add r2, r2, #4          @r2 = &a[i+1] ( = &a[j] )
LOOP3:                      @for(j = i + 1; j < size;)      @第二層迴圈
    cmp r4,r0
    bge EXIT3

    /* ===== swap(a[i], a[j]) ===== */
    ldr r5, [r1]            @r5 = a[i]
    ldr r6, [r2]            @r6 = a[j]
    cmp r5, r6              
    movge r7, r5            @swap r5, r6
    movge r5, r6
    movge r6, r7
    strge r5, [r1]          @存回r1 r2
    strge r6, [r2]
    /* ==============  ============== */


    add r4, r4, #1          @j++
    add r2, r2, #4          @r2　=　&a[j]
    b LOOP3
EXIT3:
    add r3, r3, #1          @i++
    add r1, r1, #4          @r1　=　&a[i]
    b LOOP2
EXIT2:

    /*put result array address into r10*/
    ldr r10, =#0x22220

    ldmfd sp!, {r0-r9, fp, ip, pc}
    .end
