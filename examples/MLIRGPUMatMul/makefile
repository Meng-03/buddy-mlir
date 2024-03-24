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

# ***************************  test for mma dialect lower pass *********************** #
# ***************************  mma.matmul op lower to linalg.matmul op)  ************* #

mm-v0-lower:
	@${BUDDY_OPT} mm-v0.mlir \
		--lower-mma -o mm-v0-lower-mma.mlir
mm-v0-linalg-to-affine-loops:
	@${BUDDY_OPT} mm-v0-lower-mma.mlir \
		-convert-linalg-to-affine-loops -o mm-v0-linalg-to-affine-loops.mlir
mm-v0-lower-affine:
	@${BUDDY_OPT} mm-v0-linalg-to-affine-loops.mlir \
		-lower-affine -o mm-v0-lower-affine.mlir
mm-v0-convert-to-cf:
	@${BUDDY_OPT} mm-v0-lower-affine.mlir \
	-convert-scf-to-cf -o mm-v0-convert-to-cf.mlir
# 如下直接一步 convert-to-llvm 会缺少其中一些pass中包含的对mlir的优化
# convert-to-llvm:
# 	@${BUDDY_OPT} convert-to-cf.mlir \
# 	-convert-to-llvm -o convert-to-llvm.mlir
mm-v0-convert-vector:
	@${BUDDY_OPT} mm-v0-convert-to-cf.mlir \
	-convert-vector-to-llvm -o mm-v0-convert-vector-to-llvm.mlir	
mm-v0-convert-memref:
	@${BUDDY_OPT} mm-v0-convert-vector-to-llvm.mlir \
	-finalize-memref-to-llvm -o mm-v0-convert-memref-to-llvm.mlir	
mm-v0-convert-arith:
	@${BUDDY_OPT} mm-v0-convert-memref-to-llvm.mlir \
	-convert-arith-to-llvm -o mm-v0-convert-arith-to-llvm.mlir	
mm-v0-convert-func:
	@${BUDDY_OPT} mm-v0-convert-arith-to-llvm.mlir \
	-convert-func-to-llvm -o mm-v0-convert-func-to-llvm.mlir
mm-v0-reconcile-casts:
	@${BUDDY_OPT} mm-v0-convert-func-to-llvm.mlir \
	-reconcile-unrealized-casts -o mm-v0-reconcile-unrealized-casts.mlir
mm-v0-runner:
	@${MLIR_CPU_RUNNER} mm-v0-reconcile-unrealized-casts.mlir  \
	${OPT_FLAG}  -entry-point-result=void -shared-libs=${MLIR_RUNNER_UTILS} 


# **************************************** gpu-test **************************************** #
gpu-test-lower:               
	@${MLIR_OPT} gpu-test.mlir | \
	${MLIR_OPT} --pass-pipeline="builtin.module(gpu-kernel-outlining,nvvm-attach-target{chip=sm_70 O=3},gpu.module(convert-gpu-to-nvvm),gpu-to-llvm, gpu-module-to-binary)" -o gpu-test-lower.mlir 
gpu-test-run:
	${MLIR_CPU_RUNNER}  gpu-test-lower.mlir -entry-point-result=void -shared-libs=${MLIR_RUNNER_UTILS} -shared-libs=${MLIR_CUDA_RUNTIME}

# ********************** matmul gpu passes test (tensor core)*************************************** #
# matmul-test-lower:
# 	@${BUDDY_OPT} matmul.mlir \
# 		--lower-mma -o matmul-to-linalg.mlir
# linalg-to-affine-loops:
# 	@${BUDDY_OPT} matmul-to-linalg.mlir \
# 		-convert-linalg-to-affine-loops -o linalg-to-affine-loops.mlir
# convert-linalg-to-parallel-loops:
# 	@${BUDDY_OPT} mm-v0-lower-mma.mlir \
# 		-convert-linalg-to-parallel-loops -o convert-linalg-to-parallel-loops.mlir	
mm-gpu-pass-test-lower:
	@${BUDDY_OPT} mm-gpu-pass-test.mlir \
		--lower-mma -o mm-gpu-pass-test-lower.mlir
mm-gpu-pass-test-lower-kernel-outlining:
	@${BUDDY_OPT} mm-gpu-pass-test-lower.mlir \
		-gpu-kernel-outlining -o mm-gpu-pass-test-lower-kernel-outline.mlir

# ********************** matmul gpu test (tensor core)*************************************** #
mm-v1-gpu-lower:
	@${MLIR_OPT} mm-v1-gpu.mlir | \
	${MLIR_OPT}	--pass-pipeline="builtin.module(nvvm-attach-target{chip=sm_70 O=3},gpu.module(convert-gpu-to-nvvm),gpu-to-llvm, gpu-module-to-binary)" | \
	${MLIR_OPT} -convert-linalg-to-loops -lower-affine -convert-scf-to-cf | \
	${MLIR_OPT} -convert-vector-to-llvm -finalize-memref-to-llvm -convert-arith-to-llvm -convert-scf-to-cf --convert-vector-to-llvm --convert-func-to-llvm -o mm-v1-gpu-runable.mlir
mm-v1-gpu-run:
	${MLIR_CPU_RUNNER}  mm-v1-gpu-runable.mlir -entry-point-result=void -shared-libs=${MLIR_CUDA_RUNTIME} -shared-libs=${MLIR_RUNNER_UTILS}


# ********************** matmul gpu benchmark test (tensor core)*************************************** #
mm-v1-gpu-benchmark-lower:
	@${MLIR_OPT} mm-v1-gpu-benchmark.mlir | \
	${MLIR_OPT} --pass-pipeline="builtin.module(nvvm-attach-target{chip=sm_70 O=3},gpu.module(convert-gpu-to-nvvm),gpu-to-llvm, gpu-module-to-binary)" | \
	${MLIR_OPT} -convert-vector-to-llvm | \
	${MLIR_OPT} -finalize-memref-to-llvm | \
	${MLIR_OPT} -convert-arith-to-llvm | \
	${MLIR_OPT} -convert-scf-to-cf | \
	${MLIR_OPT} -convert-func-to-llvm | \
	${MLIR_OPT} -o mm-v1-gpu-benchmark-lower.mlir

mmgpu-benchmark-run:
	${MLIR_CPU_RUNNER}  mm-v1-gpu-benchmark-lower.mlir -entry-point-result=void -shared-libs=${MLIR_CUDA_RUNTIME} -shared-libs=${MLIR_RUNNER_UTILS} -shared-libs=${MLIR_C_RUNNER_UTILS}


# ********************** matmul gpu test (tensor core)*************************************** #
mm-v2-gpu-lower:
	@${MLIR_OPT} mm-v2-gpu.mlir | \
	${MLIR_OPT}	--pass-pipeline="builtin.module(nvvm-attach-target{chip=sm_70 O=3},gpu.module(convert-gpu-to-nvvm),gpu-to-llvm, gpu-module-to-binary)" -o mm-v2-gpu-bin.mlir
# ${MLIR_OPT} -convert-linalg-to-loops -lower-affine -convert-scf-to-cf | \
# ${MLIR_OPT} -convert-vector-to-llvm -finalize-memref-to-llvm -convert-arith-to-llvm -convert-scf-to-cf --convert-vector-to-llvm --convert-func-to-llvm -o mm-v1-gpu-runable.mlir
mm-v2-gpu-lower-test:
	@${MLIR_OPT} mm-v2-gpu-bin.mlir | \
	${MLIR_OPT} -convert-scf-to-cf -convert-func-to-llvm -o mm-v2-gpu-test_1.mlir
mm-v2-gpu-run:
	${MLIR_CPU_RUNNER}  mm-v2-gpu-test.mlir -entry-point-result=void -shared-libs=${MLIR_CUDA_RUNTIME} -shared-libs=${MLIR_RUNNER_UTILS}




# Passes:
# ${MLIR_CPU_RUNNER} ${OPT_FLAG} -e main -entry-point-result=void -shared-libs=${MLIR_RUNNER_UTILS} -shared-libs=${MLIR_C_RUNNER_UTILS}
# ${MLIR_OPT} --pass-pipeline="builtin.module(nvvm-attach-target{chip=sm_70 O=3},gpu.module(convert-gpu-to-nvvm),gpu-to-llvm, gpu-module-to-binary)" | \
# ${MLIR_OPT} -convert-vector-to-llvm | \
# ${MLIR_OPT} -finalize-memref-to-llvm | \
# ${MLIR_OPT} -convert-arith-to-llvm | \
# ${MLIR_OPT} -convert-scf-to-cf | \
# ${MLIR_OPT} -convert-func-to-llvm | \
# ${MLIR_OPT} -reconcile-unrealized-casts -o mmgpu-benchmark-lower.mlir
	      
