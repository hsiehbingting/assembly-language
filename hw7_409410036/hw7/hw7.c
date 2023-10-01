#include<stdio.h>
#include<xmmintrin.h>
#include<time.h>
struct timespec diff(struct timespec s, struct timespec e)
{
    struct timespec temp;
    if((e.tv_nsec-s.tv_nsec) < 0)
    {
        temp.tv_sec = e.tv_sec - s.tv_sec - 1;
        temp.tv_nsec = 1000000000 + e.tv_nsec - s.tv_nsec;
    }
    else
    {
        temp.tv_sec = e.tv_sec - s.tv_sec;
        temp.tv_nsec = e.tv_nsec - s.tv_nsec;
    }
    return temp;
}
int main()
{
    float A[200][200]__attribute__((aligned(16)));
    float B[200][200]__attribute__((aligned(16)));
    float C[200]__attribute__((aligned(16)));
    __m128 *a, *b, *c;
    FILE *data, *output;
    data = fopen("data.txt", "r");
    output = fopen("output.txt", "a");

    struct timespec time1, time2;
    clock_gettime(CLOCK_MONOTONIC, &time1); //read start
    for(int i = 0; i < 200; i++)    //input A
    {
        for(int j = 0; j < 198; j++)
        {
            fscanf(data, "%f", &A[i][j]);        
        }
        A[i][198] = 0;  //補0
        A[i][199] = 0;    
    }
    for(int i = 0; i < 200; i++)    //input B
    {
        for(int j = 0; j < 198; j++)
        {
            fscanf(data, "%f", &B[i][j]);        
        }
        B[i][198] = 0;  //補0
        B[i][199] = 0;    
    }
    clock_gettime(CLOCK_MONOTONIC, &time2); //read end
    printf("read : %ld:%ld\n", diff(time1, time2).tv_sec, diff(time1, time2).tv_nsec);

    clock_gettime(CLOCK_MONOTONIC, &time1); //computation start
    for(int i = 0; i < 200; i++)
    {
        C[i] = 0;   //initialize
        for(int j = 0; j < 200; j++)
        {
            for(int k = 0; k < 200; k++)
            {
                C[i] += A[i][k] * B[j][k];
            }            
        }
    }
    clock_gettime(CLOCK_MONOTONIC, &time2); //computation end
    printf("computation : %ld:%ld\n", diff(time1, time2).tv_sec, diff(time1, time2).tv_nsec);

    clock_gettime(CLOCK_MONOTONIC, &time1); //write start
    for(int i = 0; i < 200; i++)
    {
        fprintf(output,"%f\n", C[i]);
    }
    clock_gettime(CLOCK_MONOTONIC, &time2); //write end
    printf("write : %ld:%ld\n", diff(time1, time2).tv_sec, diff(time1, time2).tv_nsec);

    fclose(data);
    fclose(output);
}
