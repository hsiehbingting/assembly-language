main使用NumSort函式將一組未排序陣列由小而大排列，
並放置於使用malloc產生的新陣列，並將陣列位址放在r0傳回main，
再使用printf將input_array和result_array輸出

使用Makefile執行	~/arm-tool-20.4/bin/arm-none-eabi-gcc -g -O0 hw5_test.s numsort.s -o hw5.exe將hw5_test.s和numsort.s編譯成hw5.exe

執行arm-none-eabi-insight,使用insight debugger執行hw5.exe

