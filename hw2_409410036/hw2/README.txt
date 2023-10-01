將r1,r2,r3的值分別設定為1,2,3
並將r0的值初始化為0
把2倍r1的值加到r0,4倍r2的值加到r0,8倍r3的值加到r0
使得r0=r1*2+r2*4+r3*8

使用arm-none-eabi-gcc -g -O0 hw2.s -o hw2.exe將.s檔編譯成.exe檔
使用arm-none-eabi-insight執行insight debugger
target settings選擇simulator後開啟hw2.exe執行
