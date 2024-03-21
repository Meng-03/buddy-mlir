#!/bin/bash

# 替换为你的MLIR文件和mlir-cpu-runner的执行参数
OPERATIONS=100000.0  # 假设的浮点运算总数

# 使用time命令测量执行时间（秒）
START_TIME=$(date +%s.%N)
# /home/wmn/buddy-mlir/llvm/build# 
./bin/mlir-opt /home/wmn/buddy-mlir/llvm/mlir/test/Integration/GPU/CUDA/TensorCore/wmma-matmul-f16.mlir | 
./bin/mlir-opt -test-lower-to-nvvm="cubin-chip=sm_70"|
./bin/mlir-cpu-runner --shared-libs=lib/libmlir_cuda_runtime.so --shared-libs=lib/libmlir_runner_utils.so --entry-point-result=void

END_TIME=$(date +%s.%N)
EXECUTION_TIME=$(echo "$END_TIME - $START_TIME" | bc)

# 计算GFLOPS
EXECUTION_TIME=$(printf "%.9f" $EXECUTION_TIME)

echo "Execution time: $EXECUTION_TIME seconds"
# echo "GFLOPS: $GFLOPS"

# 示例操作数和执行时间
OPERATIONS=1000000000  # 例如
EXECUTION_TIME=.468812718  # 假设这是你从某处计算得来的执行时间

# 使用printf确保执行时间格式化为浮点数
EXECUTION_TIME=$(printf "%.9f" $EXECUTION_TIME)

# 计算GFLOPS
GFLOPS=$(echo "scale=4; $OPERATIONS / ($(printf "%.9f" $EXECUTION_TIME) * 1e9)" | bc)
echo "GFLOPS: $GFLOPS"
