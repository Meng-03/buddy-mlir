// cuda中内存管理的API
//  1.device上分配内存的cudaMalloc函数，和释放内存的cudaFree函数
//      cudaError_t cudaMalloc(void **devPtr, size_t size);
//      input:devPtr 指向所分配内存的指针，size一定字节大小的显存
//  2.host和device之间数据通信的cudaMemcpy函数
//      cudaError_t cudaMemcpy(void* dst, const void *src, size_t count, cudaMemcpyKind kind)
//          src指向数据源，
//          dst是目标区域，
//          count是复制的字节数，
//          kind控制复制的方向：cudaMemcpyHostToHost, cudaMemcpyHostToDevice, cudaMemcpyDeviceToHost及cudaMemcpyDeviceToDevice，如cudaMemcpyHostToDevice将host上数据拷贝到device上
// Question:
// - kernel计算的单位是什么呢---是线程thread

#include <iostream>
//一个线程所执行的
__global__ void add(float* x, float* y,float* z,int n){
    int index=threadIdx.x+blockIdx.x*blockDim.x;
    //步长
    //stride是整个grid的线程数，有时候向量的元素数很多，这时候可以将在每个线程实现多个元素（元素总数/线程总数）的加法，相当于使用了多个grid来处理
    int stride=blockDim.x*gridDim.x;
    for(int i=index;i<n;i+=stride){
        z[i]=x[i]+y[i];
    }
}
int main(){
    int N=1<<20;//2的20次幂
    int nBytes =N*sizeof(float);//n个float所占用的字节数
    
    //申请host内存
    float *a=(float*)malloc(nBytes);
    float *b=(float*)malloc(nBytes);
    float *c=(float*)malloc(nBytes);
    //可以申请托管内存--共同管理host和device中的内存，并自动在host和device中进行数据传输
    // float *a,*b,*c;
    // cudaMallocManaged((void**)&a,nBytes);
    // cudaMallocManaged((void**)&b,nBytes);
    // cudaMallocManaged((void**)&c,nBytes);
    // ...kernel计算完成后
    // //同步device，保证后面的检验能够正确访问
    // //因为kernel和host的执行是异步的，需要用cudaDeviceSynchronize保证device和host同步
    // cudaDeviceSynchronize();


    //初始化数据
    for(int i=0;i<N;i++){
        a[i]=10.0;
        b[i]=20.0;
    }

    //申请device内存
    float *d_a,*d_b,*d_c;
    cudaMalloc((void **)&d_a, nBytes);
    cudaMalloc((void **)&d_b,nBytes);
    cudaMalloc((void **)&d_c,nBytes);

    //将host数据拷贝到device
    cudaMemcpy((void*)d_a,(void*)a,nBytes,cudaMemcpyHostToDevice);
    cudaMemcpy((void*)d_b,(void*)b,nBytes,cudaMemcpyHostToDevice);
    //定义kernel的执行配置
    dim3 blockSize(32);
    dim3 gridSize(N+blockSize.x-1/blockSize.x);//+blockSize.x-1为了保证当N不是block的倍数时能够向上取整
    //执行kernel
    add<<<gridSize,blockSize>>>(d_a,d_b,d_c,N);

    //将device结果拷贝到host
    cudaMemcpy((void*)c,(void*)d_c,nBytes,cudaMemcpyDeviceToHost);

    //检查执行结果
    float maxError=0.0;
    for(int i=0;i<N;i++)
        maxError=fmax(maxError,fabs(c[i]-30.0));
    std::cout<<"最大误差："<<maxError<<std::endl;

    //释放内存
    cudaFree(d_a);
    cudaFree(d_b);
    cudaFree(d_c);

    free(a);
    free(b);
    free(c);

    return 0;
}
// nvprof ./madd
//*****block=256
// ==9823== NVPROF is profiling process 9823, command: ./madd
// 最大误差：0
// ==9823== Profiling application: ./madd
// ==9823== Profiling result:
//             Type  Time(%)      Time     Calls       Avg       Min       Max  Name
//  GPU activities:   39.82%  1.7923ms         1  1.7923ms  1.7923ms  1.7923ms  [CUDA memcpy DtoH]
//                    39.37%  1.7718ms         1  1.7718ms  1.7718ms  1.7718ms  add(float*, float*, float*, int)
//                    20.81%  936.38us         2  468.19us  462.85us  473.54us  [CUDA memcpy HtoD]
//       API calls:   95.68%  300.80ms         3  100.27ms  809.34us  299.12ms  cudaMalloc
//                     2.08%  6.5418ms         3  2.1806ms  599.28us  5.1628ms  cudaMemcpy
//                     1.12%  3.5234ms       202  17.442us     210ns  869.81us  cuDeviceGetAttribute
//                     1.01%  3.1834ms         3  1.0611ms  669.79us  1.7633ms  cudaFree
//                     0.09%  282.50us         2  141.25us  127.88us  154.61us  cuDeviceGetName
//                     0.01%  34.645us         1  34.645us  34.645us  34.645us  cudaLaunchKernel
//                     0.00%  10.354us         2  5.1770us  2.3430us  8.0110us  cuDeviceGetPCIBusId
//                     0.00%  2.3430us         3     781ns     297ns  1.6740us  cuDeviceGetCount
//                     0.00%  1.6240us         4     406ns     239ns     737ns  cuDeviceGet
//                     0.00%  1.1340us         2     567ns     484ns     650ns  cuDeviceTotalMem
//                     0.00%     626ns         2     313ns     294ns     332ns  cuDeviceGetUuid