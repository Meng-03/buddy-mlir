//C=A✖️B
//选择grid和block为2-D的--这个结构只是逻辑上的，依据需求去设定
#include <iostream>
using namespace std;
int ROW_a=3;
int COL_a=2;
int ROW_b=2;
int COL_b=3;
int ROW_c=3;
int COL_c=3;
__global__ void matmulKernel(float *A, float *B, float *C,int width,int ROW_c,int COL_c){
    int i=threadIdx.x+blockDim.x*blockIdx.x;
    int j=threadIdx.y+blockDim.y*blockIdx.y;
    float ctemp=0.0;
    //2. 这里需要限制越界！！因为block和thread设置的时候会出现越界的情况
    if(i<ROW_c&&j<COL_c){
        // printf("*%d %d\n",i,j);
        for(int k=0;k<width;k++){ 
            ctemp+=A[i*width+k]*B[k*width+j];
        }
        C[i*COL_c+j]=ctemp;//3.这里COL_c写错
    }
}
int main(){
    float *A,*B,*C;
    A=(float*)malloc(sizeof(float)*COL_a*ROW_a);
    B=(float*)malloc(sizeof(float)*COL_b*ROW_b);
    C=(float*)malloc(sizeof(float)*COL_c*ROW_c);

    float *d_A,*d_B,*d_C;
    cudaMalloc((void**)&d_A,sizeof(float)*COL_a*ROW_a);
    cudaMalloc((void**)&d_B,sizeof(float)*COL_b*ROW_b);
    cudaMalloc((void**)&d_C,sizeof(float)*COL_c*ROW_c);

    for(int i=0;i<COL_a*ROW_a;i++){
        A[i]=1.0;
    }
    for(int i=0;i<COL_b*ROW_b;i++){
        B[i]=2.0;
    }

    cudaMemcpy((void*)d_A,(void*)A,sizeof(float)*COL_a*ROW_a,cudaMemcpyHostToDevice);
    cudaMemcpy((void*)d_B,(void*)B,sizeof(float)*COL_b*ROW_b,cudaMemcpyHostToDevice);
    
    dim3 blocksize(32,32);
    dim3 gridsize((ROW_c+blocksize.x-1)/blocksize.x,(COL_c+blocksize.y-1)/blocksize.y);
    matmulKernel<<<gridsize,blocksize>>>(d_A,d_B,d_C,COL_a,ROW_c,COL_c);//1.内核调用出错，错传了host端的数据，而不是device端

    cudaMemcpy((void*)C,(void*)d_C,sizeof(float)*COL_c*ROW_c,cudaMemcpyDeviceToHost);
    
    float maxError=0.0;
    for(int m=0;m<COL_c*ROW_c;m++){
        // int i=m/ROW_c;
        // int j=m%ROW_c;
        // C_ij=0;
        // for(int k=0;k<COL_a;k++)
        //     C_ij+=A[i*width+k]*B[k*width+j];]
        // cout<<C[m]<<endl;
        maxError=fmax(maxError,fabs(C[m]-2*COL_a));
    }
    std::cout<<"最大误差"<<maxError<<std::endl;
    free(A);free(B);free(C);
    cudaFree(d_A);cudaFree(d_B);cudaFree(d_C);
    return 0;

}