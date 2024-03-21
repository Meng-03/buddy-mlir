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

gpu-all-reduce-and-lower:
	@${MLIR_OPT} gpu-all-reduce-and.mlir -gpu-kernel-outlining | \
	${MLIR_OPT} -pass-pipeline='builtin.module(gpu.module(strip-debuginfo,convert-gpu-to-nvvm,nvvm-attach-target))' | \
	${MLIR_OPT} -gpu-to-llvm -o log.mlir

gpu-all-reduce-and-run:
	@${MLIR_OPT} gpu-all-reduce-and.mlir -gpu-kernel-outlining | \
	${MLIR_OPT} -pass-pipeline='builtin.module(gpu.module(strip-debuginfo,convert-gpu-to-nvvm,gpu-to-cubin))' | \
	${MLIR_OPT} -gpu-to-llvm | \
	${MLIR_CPU_RUNNER} -entry-point-result=void -shared-libs=${MLIR_RUNNER_UTILS} -shared-libs=${MLIR_CUDA_RUNTIME}

gpu-launch-func-lower:
	@${MLIR_OPT} gpu-launch-func.mlir -gpu-kernel-outlining | \
	${MLIR_OPT} -pass-pipeline='builtin.module(gpu.module(strip-debuginfo,convert-gpu-to-nvvm,gpu-to-cubin))' | \
	${MLIR_OPT}	-gpu-async-region -gpu-to-llvm -o log.mlir

gpu-launch-func-run:
	@${MLIR_OPT} gpu-launch-func.mlir -gpu-kernel-outlining | \
	${MLIR_OPT} -pass-pipeline='builtin.module(gpu.module(strip-debuginfo,convert-gpu-to-nvvm,gpu-to-cubin))' | \
	${MLIR_OPT}	-gpu-async-region -gpu-to-llvm | \
	${MLIR_CPU_RUNNER} -entry-point-result=void -shared-libs=${MLIR_RUNNER_UTILS} -shared-libs=${MLIR_CUDA_RUNTIME}

async-execute-lower:
	@${MLIR_OPT} async-execute.mlir -gpu-kernel-outlining | \
	${MLIR_OPT} -pass-pipeline='builtin.module(gpu.module(strip-debuginfo,convert-gpu-to-nvvm,gpu-to-cubin))' | \
	${MLIR_OPT}	-gpu-async-region -gpu-to-llvm | \
	${MLIR_OPT} -async-to-async-runtime -async-runtime-ref-counting | \
	${MLIR_OPT} -convert-async-to-llvm -convert-func-to-llvm -o log.mlir

async-execute-run:
	@${MLIR_OPT} async-execute.mlir -gpu-kernel-outlining | \
	${MLIR_OPT} -pass-pipeline='builtin.module(gpu.module(strip-debuginfo,convert-gpu-to-nvvm,gpu-to-cubin))' | \
	${MLIR_OPT}	-gpu-async-region -gpu-to-llvm | \
	${MLIR_OPT} -async-to-async-runtime -async-runtime-ref-counting | \
	${MLIR_OPT} -convert-async-to-llvm -convert-func-to-llvm | \
	${MLIR_CPU_RUNNER} -entry-point-result=void -shared-libs=${MLIR_RUNNER_UTILS} -shared-libs=${MLIR_CUDA_RUNTIME} \
	-shared-libs=${MLIR_ASYNC_RUNTIME} ${OPT_FLAG}

# gpu-mma-lower:
# 	@${MLIR_OPT} gpu-mma.mlir -gpu-kernel-outlining | \
# 	${MLIR_OPT} -pass-pipeline='builtin.module(gpu.module(strip-debuginfo,convert-gpu-to-nvvm,nvvm-attach-target{chip=sm_70}))' | \
# 	${MLIR_OPT}	-convert-scf-to-cf -gpu-to-llvm -o log.mlir

# gpu-mma-lower:                  
# 	@${MLIR_OPT} gpu-mma.mlir --pass-pipeline="builtin.module(gpu-kernel-outlining,nvvm-attach-target{chip=sm_70 O=3}, gpu.module(convert-gpu-to-nvvm), gpu-to-llvm, gpu-module-to-binary )" -o example-nvvm.mlir
# 	${MLIR_TRANSLATE} example-nvvm.mlir  --mlir-to-llvmir -o example.ll

# gpu-mma-lower:                  \
#   @${MLIR_OPT} --pass-pipeline="builtin.module(      \
#     gpu-kernel-outlining,               \ # Outline gpu.launch body to a kernel.
#     nvvm-attach-target{chip=sm_90 O=3}, \ # Attach an NVVM target to a gpu.module op.
#     gpu.module(convert-gpu-to-nvvm),    \ # Convert GPU to NVVM.
#     gpu-to-llvm,                        \ # Convert GPU to LLVM.
#     gpu-module-to-binary                \ # Serialize GPU modules to binaries.
#   )" -o example-nvvm.mlir
# mlir-translate example-nvvm.mlir        
#   --mlir-to-llvmir                      \ # Obtain the translated LLVM IR.
#   -o example.ll

gpu-mma-gpu-kernel-outline:
	@${MLIR_OPT} gpu-mma.mlir --pass-pipeline="builtin.module(gpu-kernel-outlining)" -o gpu-mma-kernel-outline.mlir
gpu-mma-nvvm-attach-target:
	@${MLIR_OPT} gpu-mma-kernel-outline.mlir --pass-pipeline="builtin.module(nvvm-attach-target{chip=sm_70 O=3})" -o gpu-mma-nvvm-attach-target.mlir
gpu-mma-convert-to-nvvm:
	@${MLIR_OPT} gpu-mma-nvvm-attach-target.mlir --pass-pipeline="builtin.module(gpu.module(convert-gpu-to-nvvm))" -o gpu-mma-convert-to-nvvm.mlir
gpu-mma-gpu-to-llvm:
	@${MLIR_OPT} gpu-mma-convert-to-nvvm.mlir --pass-pipeline="builtin.module(gpu-to-llvm)" -o gpu-mma-gpu-to-llvm.mlir
gpu-mma-gpu-module-to-binary:
	@${MLIR_OPT} gpu-mma-gpu-to-llvm.mlir --pass-pipeline="builtin.module(gpu-module-to-binary{format=bin})" -o gpu-mma-gpu-module-to-binary.mlir 
#format=isa/bin/llvm/fatbin
gpu-mma-scf-convert:
	@${MLIR_OPT} gpu-mma.mlir --convert-scf-to-cf --convert-to-llvm -o test.mlir 
gpu-mma-to-llvm:
	@${MLIR_TRANSLATE} test.mlir --mlir-to-llvmir -o log.ll
#home/wmn/buddy-mlir/llvm/build/bin/llc -march=nvptx64 -mcpu=sm_70 /home/wmn/buddy-mlir/examples/MLIRGPU/example.ll -o /home/wmn/buddy-mlir/examples/MLIRGPU/example.ptx

gpu-test-1:               
	@${MLIR_OPT} gpu-test.mlir --pass-pipeline="builtin.module(gpu-kernel-outlining,nvvm-attach-target{chip=sm_70 O=3},gpu.module(convert-gpu-to-nvvm),gpu-to-llvm, gpu-module-to-binary)" -o test.mlir 
gpu-test-run:
	${MLIR_CPU_RUNNER}  test.mlir -entry-point-result=void -shared-libs=${MLIR_RUNNER_UTILS} -shared-libs=${MLIR_CUDA_RUNTIME}


gpu-test-llvm-1:	
	@${MLIR_TRANSLATE} test.mlir --mlir-to-llvmir -o example.ll
gpu-test-llc:
	@${LLC} example.ll -o example.s

gpu-test-2:               
	@${MLIR_OPT} gpu-test.mlir -gpu-lower-to-nvvm-pipeline = "cubin-chip=sm_70 opt-level=3" -o gpu-test-2.mlir
gpu-test-llvm-2:	
	@${MLIR_TRANSLATE} test.mlir --mlir-to-llvmir -o example.ll
# mlir-opt example.mlir -gpu-lower-to-nvvm-pipeline = "cubin-chip=sm_90a cubin-features=+ptx80 opt-level=3"


scf-if-translate:
	@${MLIR_OPT} ./scf-if.mlir \
		--convert-scf-to-cf --convert-vector-to-llvm --convert-func-to-llvm \
		--reconcile-unrealized-casts | \
	${MLIR_TRANSLATE} --mlir-to-llvmir -o log.ll
# gpu-mma-test-run:
# 	@${MLIR_TRANSLATE}  gpu-mma-scf-convert.mlir --mlir-to-llvmir -o example.ll

gpu-mma-run:
	@${MLIR_OPT} gpu-mma.mlir -gpu-kernel-outlining | \
	${MLIR_OPT} --pass-pipeline="builtin.module(nvvm-attach-target{chip=sm_70 O=3},gpu.module(convert-gpu-to-nvvm),gpu-to-llvm, gpu-module-to-binary)" | \
	${MLIR_OPT}	-convert-scf-to-cf -gpu-to-llvm | \
	${MLIR_CPU_RUNNER} -entry-point-result=void -shared-libs=${MLIR_CUDA_RUNTIME} -shared-libs=${MLIR_RUNNER_UTILS}

vector-to-gpu-lower:
	@${MLIR_OPT} vector-to-gpu.mlir -convert-linalg-to-loops | \
	${MLIR_OPT} -pass-pipeline="builtin.module(gpu.module(convert-vector-to-gpu,canonicalize))" | \
	${MLIR_OPT} -pass-pipeline='builtin.module(gpu.module(strip-debuginfo,convert-gpu-to-nvvm,gpu-to-cubin{chip=sm_70}))' | \
	${MLIR_OPT}	-convert-scf-to-cf -gpu-to-llvm -o log.mlir 

vector-to-gpu-run:
	@${MLIR_OPT} vector-to-gpu.mlir -convert-linalg-to-loops | \
	${MLIR_OPT} -pass-pipeline="builtin.module(gpu.module(convert-vector-to-gpu,canonicalize))" | \
	${MLIR_OPT} -pass-pipeline='builtin.module(gpu.module(strip-debuginfo,nvvm-attach-target{chip=sm_70 O=3},convert-gpu-to-nvvm,gpu-module-to-binary))' | \
	${MLIR_OPT}	-convert-scf-to-cf -gpu-to-llvm | \
	${MLIR_CPU_RUNNER} -entry-point-result=void -shared-libs=${MLIR_CUDA_RUNTIME} -shared-libs=${MLIR_RUNNER_UTILS}
