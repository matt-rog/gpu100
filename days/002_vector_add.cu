// Familiarize with memory allocs

#include "stdlib.h"
#include "time.h"

__global__ void add(int *a, int *b, int *c){
    c[blockIdx.x] = b[blockIdx.x] + a[blockIdx.x];
}

void random_int(int *arr, int size) {
    srand(time(NULL));
    for (int i = 0; i < size; i++) {
        arr[i] = rand();
    }

}

#define N 1024
int main() {
    int *a, *b, *c;
    int *d_a, *d_b, *d_c;
    int size = N * sizeof(int);

    cudaMalloc((void **) &d_a, size);
    cudaMalloc((void **) &d_b, size);
    cudaMalloc((void **) &d_c, size);

    a = (int *)malloc(size);
    b = (int *)malloc(size);
    c = (int *)malloc(size);

    cudaMemcpy(d_a, a, size, cudaMemcpyHostToDevice);
    cudaMemcpy(d_b, b, size, cudaMemcpyHostToDevice);

    add<<<N,1>>>(d_a, d_b, d_c); 

    cudaMemcpy(c, d_c, size, cudaMemcpyDeviceToHost);

    free(a); free(b); free(c);
    cudaFree(a); cudaFree(b); cudaFree(c);

    cudaDeviceSynchronize();
    return 0;
}