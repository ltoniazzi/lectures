#include <iostream>
#include <cuda.h>

__global__ void TrivialSumReductionKernel(
        float* input, 
        float* output
    ) {
    int thread_id = threadIdx.x;
    int dim = blockDim.x;

    int thread_write_location = 2 * thread_id;

    for (unsigned int stride = 1; stride <= dim; stride*=2) {
        if (thread_id % stride == 0 ) {
        input[thread_write_location] += input[thread_write_location + stride];  // sum iteratively
        }
         __syncthreads();
    }
    if (thread_id == 0){
    *output  = input[0];  // Write sum to output
    }
}

int main() {
    // Size of the input data
    const int size = 2048;
    const int bytes = size * sizeof(float);

    // Allocate memory for input and output on host
    float* h_input = new float[size];
    float* h_output = new float;

    // Initialize input data on host
    for (int i = 0; i < size; i++) {
        h_input[i] = 1.0f; // Example: Initialize all elements to 1
    }

    // Allocate memory for input and output on device
    float* d_input;
    float* d_output;
    cudaMalloc(&d_input, bytes);
    cudaMalloc(&d_output, sizeof(float));

    // Copy data from host to device
    cudaMemcpy(d_input, h_input, bytes, cudaMemcpyHostToDevice);

    // Launch the kernel
    int n_threads = size/2;
    int n_blocks = 1;
    TrivialSumReductionKernel<<<n_blocks, n_threads>>>(d_input, d_output);

    // Copy result back to host
    cudaMemcpy(h_output, d_output, sizeof(float), cudaMemcpyDeviceToHost);

    // Print the result
    std::cout << "\nSum is " << *h_output << "\n" << std::endl;

    // Cleanup
    delete[] h_input;
    delete h_output;
    cudaFree(d_input);
    cudaFree(d_output);

    return 0;
}
