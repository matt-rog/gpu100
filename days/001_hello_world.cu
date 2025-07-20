#include "stdio.h"

__global__ void cuda_hello(){
    println("Hello World!");
}

int main() {
    cuda_hello<<<1,1>>>(); 
    cudaDeviceSynchronize();
    return 0;
}