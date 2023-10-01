程式可完成hw7的運算,並將計算結果輸出到output.txt,且printf出各部份所需執行時間

CPU         : Intel(R) Core(TM) i5-10210U CPU @ 1.60GHz
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx rdtscp lm constant_tsc rep_good nopl xtopology nonstop_tsc cpuid tsc_known_freq pni pclmulqdq ssse3 cx16 pcid sse4_1 sse4_2 x2apic movbe popcnt aes xsave avx rdrand hypervisor lahf_lm abm 3dnowprefetch invpcid_single fsgsbase avx2 invpcid rdseed clflushopt md_clear flush_l1d arch_capabilities
作業系統　　 : Linux Mint

Nom-SIMD version:
    read : 0:19406717
    computation : 0:25387854
    write : 0:179549
SIMD version:
    read : 0:24274118
    computation : 0:10931267
    write : 0:139739

使用Makefile執行 gcc -msse4 -lrt hw7simd.c 將hw7simd.c編譯成a.out
執行a.out,會印出read、computation、write執行時間,並將執行結果寫到output.txt

使用指令：
    _mm_add_ps      CPUID Flag : SSE
    _mm_sub_ps      CPUID Flag : SSE
    _mm_mul_ps      CPUID Flag : SSE


