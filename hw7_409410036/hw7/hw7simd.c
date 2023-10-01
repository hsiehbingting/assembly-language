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
    float C[200][200]__attribute__((aligned(16)));
    __m128 *a[200], *b[200], *c[200];
    for(int i = 0; i < 200; i++)
    {
        a[i] = (__m128*)A[i];
        b[i] = (__m128*)B[i];
        c[i] = (__m128*)C[i];
    }

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
        *(c[i]) = _mm_sub_ps(*(c[i]), *(c[i])); //initialize
        for(int j = 0; j < 200; j++)
        {
            for(int k = 0; k < 50; k++) //  ceil(198/4) = 50
            {
                *(c[i]) = _mm_add_ps( *(c[i]) ,  _mm_mul_ps( *(a[i]+k) , *(b[j]+k) ) ); //C[i] += A[i][k] * B[j][k];(in hw7.c)
            }            
        }
        C[i][0] += C[i][1] + C[i][2] + C[i][3];
    }


    clock_gettime(CLOCK_MONOTONIC, &time2); //computation end
    printf("computation : %ld:%ld\n", diff(time1, time2).tv_sec, diff(time1, time2).tv_nsec);

    clock_gettime(CLOCK_MONOTONIC, &time1); //write start
    for(int i = 0; i < 200; i++)
    {
        fprintf(output,"%f\n", C[i][0]);
    }
    clock_gettime(CLOCK_MONOTONIC, &time2); //write end
    printf("write : %ld:%ld\n", diff(time1, time2).tv_sec, diff(time1, time2).tv_nsec);

    fclose(data);
    fclose(output);
}
