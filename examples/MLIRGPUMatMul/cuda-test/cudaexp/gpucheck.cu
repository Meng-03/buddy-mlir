#include <iostream>
#include <cuda_runtime.h>
using namespace std;
#define CHECK(call)                                                        \
{                                                                          \
    const cudaError_t error = call;                                        \
    if (error != cudaSuccess)                                              \
    {                                                                      \
        std::cerr << "Error: " << __FILE__ << ", line " << __LINE__       \
                  << "\nCode: " << error << ", reason: " << cudaGetErrorString(error) << std::endl; \
        std::exit(error);                                                  \
    }                                                                      \
}
int main(){
  int dev = 0;
  cudaDeviceProp devProp;
  CHECK(cudaGetDeviceProperties(&devProp, dev));
  cout << "使用GPU device " << dev << ": " << devProp.name << std::endl;
  cout << "SM的数量：" << devProp.multiProcessorCount << std::endl;
  cout << "每个线程块的共享内存大小：" << devProp.sharedMemPerBlock / 1024.0 << " KB" << std::endl;
  cout << "每个线程块的最大线程数：" << devProp.maxThreadsPerBlock << std::endl;
  cout << "每个SM的最大线程数：" << devProp.maxThreadsPerMultiProcessor << std::endl;
  cout << "每个SM的最大线程束数：" << devProp.maxThreadsPerMultiProcessor / 32 << std::endl;
}
// // 输出如下
// 使用GPU device 0: GeForce GT 730
// SM的数量：2
// 每个线程块的共享内存大小：48 KB
// 每个线程块的最大线程数：1024
// 每个SM的最大线程数：2048
// 每个SM的最大线程束数：64
////////////////////
// 使用GPU device 0: Tesla V100-SXM2-32GB
// SM的数量：80
// 每个线程块的共享内存大小：48 KB
// 每个线程块的最大线程数：1024
// 每个SM的最大线程数：2048
// 每个SM的最大线程束数：64