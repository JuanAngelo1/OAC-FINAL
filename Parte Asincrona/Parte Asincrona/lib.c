#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <math.h>


void initVector(float *v, int N);
void my_C(float *v1,float *v2,int N);

extern void my_ASM(float *v1,float *v2,int N);
extern void my_ASM_SIMD(float *v1,float *v2,int N);

int main(){

    int N=16;
    float *arr;
    float *arrC,*arrASM,*arrSIMD;

    srand(time(NULL));

    arr= malloc(N * sizeof(float));
    arrC = malloc(N * sizeof(float));
    arrASM = malloc(N * sizeof(float));
    arrSIMD = malloc(N * sizeof(float));

    initVector(arr,N);
    //float arr[]={4,6,2,9,10,12,30,2};

    for(int i=0;i<N;i++){
        arrC[i]=0;
        arrASM[i]=0;
        arrSIMD[i]=0;
    }

    for(int i=0;i<N;i++)printf("%.1lf  ",arr[i]);

    printf("\n");


    //EN C:
    my_C(arr,arrC,N);
    printf("En C: \n");
    printf("El resultado en C es :\n");

    for(int i=0;i<N;i++)printf("%.1lf  ",arrC[i]);
    
    printf("\n\n");
        
    
    //EN ASM:

    my_ASM(arr,arrASM,N);
    printf("En ASM: \n");
    printf("El resultado en ASM es :\n");

    for(int i=0;i<N;i++)printf("%.1lf  ",arrASM[i]);

    printf("\n\n");

    //EN SIMD:

    my_ASM_SIMD(arr,arrSIMD,N);
    printf("En SIMD: \n");
    printf("El resultado en SIMD es :\n");
    for(int i=0;i<N;i++)printf("%.1lf  ",arrSIMD[i]);
    printf("\n\n");

    return 0;
}

void my_C(float *v1,float *v2,int N){

    //Primera derivada
    for(int i=0;i<N-1;i++){
        v2[i]=v1[i+1]-v1[i];     
               
    }
    
    //Segunda derivada
    for(int i=0;i<N-1;i++){
        if(i==N-2){
            v2[i]=0;
        }else{
           v2[i]=v2[i+1]-v2[i];     
        }
    }

}

void initVector(float *v, int N)
{
    for (int i = 0; i < N; i++)
    {
        int e = rand() % 20;
        v[i] = e;
    }
}