module attributes {gpu.container_module} {
  func.func @main() {
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %c32 = arith.constant 32 : index
    %c16 = arith.constant 16 : index
    %cst = arith.constant 0.000000e+00 : f16
    %cst_0 = arith.constant 1.000000e+00 : f16
    %cst_1 = arith.constant 2.000000e+00 : f16
    %cst_2 = arith.constant 2.000000e+00 : f32
    %cst_3 = arith.constant 0.000000e+00 : f32
    %alloc = memref.alloc() : memref<16x16xf16>
    %alloc_4 = memref.alloc() : memref<16x16xf16>
    %alloc_5 = memref.alloc() : memref<16x16xf32>
    %cast = memref.cast %alloc : memref<16x16xf16> to memref<*xf16>
    %cast_6 = memref.cast %alloc_4 : memref<16x16xf16> to memref<*xf16>
    %cast_7 = memref.cast %alloc_5 : memref<16x16xf32> to memref<*xf32>
    scf.for %arg0 = %c0 to %c16 step %c1 {
      scf.for %arg1 = %c0 to %c16 step %c1 {
        memref.store %cst_1, %alloc[%arg0, %arg1] : memref<16x16xf16>
        memref.store %cst_1, %alloc_4[%arg0, %arg1] : memref<16x16xf16>
        memref.store %cst_3, %alloc_5[%arg0, %arg1] : memref<16x16xf32>
      }
    }
    call @printMemrefF32(%cast_7) : (memref<*xf32>) -> ()
    gpu.host_register %cast : memref<*xf16>
    gpu.host_register %cast_6 : memref<*xf16>
    gpu.host_register %cast_7 : memref<*xf32>
    gpu.launch_func  @kernels::@kernel1 blocks in (%c1, %c1, %c1) threads in (%c32, %c1, %c1)  args(%alloc : memref<16x16xf16>, %alloc_4 : memref<16x16xf16>, %alloc_5 : memref<16x16xf32>)
    call @printMemrefF32(%cast_7) : (memref<*xf32>) -> ()
    memref.dealloc %alloc : memref<16x16xf16>
    memref.dealloc %alloc_4 : memref<16x16xf16>
    memref.dealloc %alloc_5 : memref<16x16xf32>
    return
  }
  gpu.module @kernels [#nvvm.target<O = 3, chip = "sm_70">]  {
    gpu.func @kernel1(%arg0: memref<16x16xf16>, %arg1: memref<16x16xf16>, %arg2: memref<16x16xf32>) kernel {
      %c0 = arith.constant 0 : index
      %0 = gpu.subgroup_mma_load_matrix %arg0[%c0, %c0] {leadDimension = 16 : index} : memref<16x16xf16> -> !gpu.mma_matrix<16x16xf16, "AOp">
      %1 = gpu.subgroup_mma_load_matrix %arg1[%c0, %c0] {leadDimension = 16 : index} : memref<16x16xf16> -> !gpu.mma_matrix<16x16xf16, "BOp">
      %2 = gpu.subgroup_mma_load_matrix %arg2[%c0, %c0] {leadDimension = 16 : index} : memref<16x16xf32> -> !gpu.mma_matrix<16x16xf32, "COp">
      %3 = gpu.subgroup_mma_compute %0, %1, %2 : !gpu.mma_matrix<16x16xf16, "AOp">, !gpu.mma_matrix<16x16xf16, "BOp"> -> !gpu.mma_matrix<16x16xf32, "COp">
      gpu.subgroup_mma_store_matrix %3, %arg2[%c0, %c0] {leadDimension = 16 : index} : !gpu.mma_matrix<16x16xf32, "COp">, memref<16x16xf32>
      gpu.return
    }
  }
  func.func private @printMemrefF32(memref<*xf32>)
}

