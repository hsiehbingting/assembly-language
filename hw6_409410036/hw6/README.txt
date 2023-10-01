main使用NumSort函式將一組未排序陣列由小而大排列，
並放置於使用malloc產生的新陣列，並將陣列位址放在r0傳回main，
再將排序過的result_array輸出到result.txt

使用Makefile執行	~/arm-tool-20.4/bin/arm-none-eabi-gcc -g -O0 hw6_test.s numsort.s -o hw6.exe將hw6_test.s和numsort.s編譯成hw6.exe

執行arm-none-eabi-insight,使用insight debugger執行hw6.exe

