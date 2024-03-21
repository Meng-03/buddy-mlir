#!/bin/bash
BUDDY_OPT := ../../build/bin/buddy-opt
MLIR_OPT := ../../llvm/build/bin/mlir-opt
MLIR_TRANSLATE := ../../llvm/build/bin/mlir-translate
MLIR_CPU_RUNNER := ../../llvm/build/bin/mlir-cpu-runner
LLC := ../../llvm/build/bin/llc
OPT_FLAG := -O0

ifeq ($(shell uname),Linux)
MLIR_RUNNER_UTILS := ../../llvm/build/lib/libmlir_runner_utils.so
MLIR_C_RUNNER_UTILS := ../../llvm/build/lib/libmlir_c_runner_utils.so
MLIR_ASYNC_RUNTIME := ../../llvm/build/lib/libmlir_async_runtime.so
MLIR_CUDA_RUNTIME := ../../llvm/build/lib/libmlir_cuda_runtime.so
MTRIPLE := x86_64-unknown-linux-gnu
else ifeq ($(shell uname),Darwin)
MLIR_RUNNER_UTILS := ../../llvm/build/lib/libmlir_runner_utils.dylib
MLIR_C_RUNNER_UTILS := ../../llvm/build/lib/libmlir_c_runner_utils.dylib
MLIR_ASYNC_RUNTIME := ./../llvm/build/lib/libmlir_async_runtime.dylib
MTRIPLE := x86_64-apple-darwin
endif

matmul-test-lower:
	@${BUDDY_OPT} matmul.mlir \
		--lower-mma -o matmul-to-linalg.mlir

linalg-to-affine-loops:
	@${BUDDY_OPT} matmul-to-linalg.mlir \
		-convert-linalg-to-affine-loops -o linalg-to-affine-loops.mlir

lower-affine:
	@${BUDDY_OPT} linalg-to-affine-loops.mlir \
		-lower-affine -o lower-affine.mlir
convert-to-cf:
	@${BUDDY_OPT} lower-affine.mlir \
	-convert-scf-to-cf -o convert-to-cf.mlir

# 如下直接一步 convert-to-llvm 会缺少其中一些pass中包含的对mlir的优化
# convert-to-llvm:
# 	@${BUDDY_OPT} convert-to-cf.mlir \
# 	-convert-to-llvm -o convert-to-llvm.mlir

convert-vector:
	@${BUDDY_OPT} convert-to-cf.mlir \
	-convert-vector-to-llvm -o convert-vector-to-llvm.mlir	

convert-memref:
	@${BUDDY_OPT} convert-vector-to-llvm.mlir \
	-finalize-memref-to-llvm -o convert-memref-to-llvm.mlir	

convert-arith:
	@${BUDDY_OPT} convert-memref-to-llvm.mlir \
	-convert-arith-to-llvm -o convert-arith-to-llvm.mlir	

# func.func, call @func ....转化成llvm 
convert-func:
	@${BUDDY_OPT} convert-arith-to-llvm.mlir \
	-convert-func-to-llvm -o convert-func-to-llvm.mlir

reconcile-casts:
	@${BUDDY_OPT} convert-func-to-llvm.mlir \
	-reconcile-unrealized-casts -o reconcile-unrealized-casts.mlir

matmul-test-runner:
	@${MLIR_CPU_RUNNER} reconcile-unrealized-casts.mlir  \
	${OPT_FLAG}  -entry-point-result=void -shared-libs=${MLIR_RUNNER_UTILS} 

# linalg-to-loops:
# 	@${BUDDY_OPT} matmul-to-linalg.mlir \
# 		-convert-linalg-to-loops -o linalg-to-loops.mlir

# **************************************** gpu-test **************************************** #
# matmul-test-lower:
# 	@${BUDDY_OPT} matmul.mlir \
# 		--lower-mma -o matmul-to-linalg.mlir

# linalg-to-affine-loops:
# 	@${BUDDY_OPT} matmul-to-linalg.mlir \
# 		-convert-linalg-to-affine-loops -o linalg-to-affine-loops.mlir

convert-linalg-to-parallel-loops:
	@${BUDDY_OPT} matmul-to-linalg.mlir \
		-convert-linalg-to-parallel-loops -o convert-linalg-to-parallel-loops.mlir

# 没有变化
convert-parallel-loops-to-gpu:
	@${BUDDY_OPT} convert-linalg-to-parallel-loops.mlir \
		-convert-parallel-loops-to-gpu -o convert-parallel-loops-to-gpu.mlir

#<unknown>:0: error: unable to schedule pass 'ConvertAffineForToGPU' on a PassManager intended to run on 'builtin.module'!
# convert-affine-for-to-gpus:
# 	@${BUDDY_OPT} linalg-to-affine-loops.mlir \
# 		--convert-parallel-loops-to-gpu -o convert-affine-for-to-gpu.mlir

matmul-gpu-lower:
	@${BUDDY_OPT} matmul-gpu.mlir \
		--lower-mma -o mmgpu-to-linalg.mlir
matmul-gpu-kernel-outlining:
	@${BUDDY_OPT} mmgpu-to-linalg.mlir \
		-gpu-kernel-outlining -o mmgpu-kernel-outline.mlir

matmul-gpu-test-lower:
	@${MLIR_OPT} mmgpu-test.mlir | \
	${MLIR_OPT}	--pass-pipeline="builtin.module(nvvm-attach-target{chip=sm_70 O=3},gpu.module(convert-gpu-to-nvvm),gpu-to-llvm, gpu-module-to-binary)" | \
	${MLIR_OPT} -convert-linalg-to-loops -lower-affine -convert-scf-to-cf | \
	${MLIR_OPT} -convert-vector-to-llvm -finalize-memref-to-llvm -convert-arith-to-llvm -convert-scf-to-cf --convert-vector-to-llvm --convert-func-to-llvm -o test_1.mlir

matmul-gpu-test-run:
	${MLIR_CPU_RUNNER}  test_1.mlir -entry-point-result=void -shared-libs=${MLIR_CUDA_RUNTIME} -shared-libs=${MLIR_RUNNER_UTILS}


gpu-test-1:               
	@${MLIR_OPT} test-origin.mlir --pass-pipeline="builtin.module(gpu-kernel-outlining,nvvm-attach-target{chip=sm_70 O=3},gpu.module(convert-gpu-to-nvvm),gpu-to-llvm, gpu-module-to-binary)" -o test-origin-lower.mlir 
gpu-test-run:
	${MLIR_CPU_RUNNER}  test-origin-lower.mlir -entry-point-result=void -shared-libs=${MLIR_RUNNER_UTILS} -shared-libs=${MLIR_CUDA_RUNTIME}

mmgpu-benchmark-lower:
	@${MLIR_OPT} mmgpu-test-benchmark.mlir | \
	${MLIR_OPT} --pass-pipeline="builtin.module(nvvm-attach-target{chip=sm_70 O=3},gpu.module(convert-gpu-to-nvvm),gpu-to-llvm, gpu-module-to-binary)" | \
	${MLIR_OPT} -convert-vector-to-llvm | \
	${MLIR_OPT} -finalize-memref-to-llvm | \
	${MLIR_OPT} -convert-arith-to-llvm | \
	${MLIR_OPT} -convert-scf-to-cf | \
	${MLIR_OPT} -convert-func-to-llvm | \
	${MLIR_OPT} -o mmgpu-benchmark-lower.mlir

mmgpu-benchmark-run:
	${MLIR_CPU_RUNNER}  mmgpu-benchmark-lower.mlir -entry-point-result=void -shared-libs=${MLIR_CUDA_RUNTIME} -shared-libs=${MLIR_RUNNER_UTILS} -shared-libs=${MLIR_C_RUNNER_UTILS}

# ${MLIR_CPU_RUNNER} ${OPT_FLAG} -e main -entry-point-result=void -shared-libs=${MLIR_RUNNER_UTILS} -shared-libs=${MLIR_C_RUNNER_UTILS}
# ${MLIR_OPT} --pass-pipeline="builtin.module(nvvm-attach-target{chip=sm_70 O=3},gpu.module(convert-gpu-to-nvvm),gpu-to-llvm, gpu-module-to-binary)" | \
# ${MLIR_OPT} -convert-vector-to-llvm | \
# ${MLIR_OPT} -finalize-memref-to-llvm | \
# ${MLIR_OPT} -convert-arith-to-llvm | \
# ${MLIR_OPT} -convert-scf-to-cf | \
# ${MLIR_OPT} -convert-func-to-llvm | \
# ${MLIR_OPT} -reconcile-unrealized-casts -o mmgpu-benchmark-lower.mlir
	      
