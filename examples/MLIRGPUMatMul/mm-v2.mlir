module attributes {gpu.container_module} {
  func.func @main() {
    %c0 = arith.constant 0 : index 
    %c1 = arith.constant 1 : index  
    %c1024 = arith.constant 1024 : index 
    // %c16 = arith.constant 16 : index 
    %f0 = arith.constant 0.0 : f16
    %f1 = arith.constant 1.0 : f16
    // %f2 = arith.constant 2.0 : f16
    // %f2f32 = arith.constant 2.0 : f32
    %f0f32 = arith.constant 0.0 : f32
    %input0 = memref.alloc() : memref<1024x1024xf16>
    %input1 = memref.alloc() : memref<1024x1024xf16>
    %output0 = memref.alloc() : memref<1024x1024xf32>
    %input_cast0 = memref.cast %input0 : memref<1024x1024xf16> to memref<*xf16>
    %input_cast1 = memref.cast %input1 : memref<1024x1024xf16> to memref<*xf16>
    %output_cast0 = memref.cast %output0 : memref<1024x1024xf32> to memref<*xf32>
    scf.for %i = %c0 to %c1024 step %c1 {
      scf.for %j = %c0 to %c1024 step %c1 {
        memref.store %f1, %input0[%i, %j] : memref<1024x1024xf16> 
        memref.store %f1, %input1[%i, %j] : memref<1024x1024xf16>
        memref.store %f0f32, %output0[%i, %j] : memref<1024x1024xf32>
      }
    }   
    call @printMemrefF32(%output_cast0) : (memref<*xf32>) -> ()
    //gpu.host_register %input_cast0 : memref<*xf16>  
    //gpu.host_register %input_cast1 : memref<*xf16>
    //gpu.host_register %output_cast0 : memref<*xf32>
    mm.matmul %a, %b, %c : memref<1024x1024xf16>, memref<1024x1024xf16>, memref<1024x1024xf32>
    //gpu.launch_func @kernels::@kernel1 blocks in (%c1, %c1, %c1) threads in (%c32, %c1, %c1) args(%input0 : memref<1024x1024xf16>, %input1 : memref<1024x1024xf16>, %output0 : memref<1024x1024xf32>)
    call @printMemrefF32(%output_cast0) : (memref<*xf32>) -> ()
    memref.dealloc %input0 : memref<1024x1024xf16>
    memref.dealloc %input1 : memref<1024x1024xf16>
    memref.dealloc %output0 : memref<1024x1024xf32>
    return
  }

//   gpu.module @kernels {
//     gpu.func @kernel1(%arg0 : memref<1024x1024xf16>, %arg1 : memref<1024x1024xf16>, %arg2 : memref<1024x1024xf32>) kernel {
//       %c0 = arith.constant 0 :index
//       %c16 = arith.constant 16 : index 
//       // %sgid = gpu.subgroup_id : index
//       // %sgId = gpu.subgroup_id : index
//       // gpu.printf "gpu.subgroup_id %d\n" %sgId : index
//       %A_1 = gpu.subgroup_mma_load_matrix %arg0[%c0, %c0] {leadDimension = 32 : index} : memref<1024x1024xf16> -> !gpu.mma_matrix<16x16xf16, "AOp">
//       %B_1 = gpu.subgroup_mma_load_matrix %arg1[%c0, %c0] {leadDimension = 32 : index} : memref<1024x1024xf16> -> !gpu.mma_matrix<16x16xf16, "BOp">
//       %C_1 = gpu.subgroup_mma_load_matrix %arg2[%c0, %c0] {leadDimension = 32 : index} : memref<1024x1024xf32> -> !gpu.mma_matrix<16x16xf32, "COp">
//       %D_1 = gpu.subgroup_mma_compute %A_1, %B_1, %C_1 : !gpu.mma_matrix<16x16xf16, "AOp">, !gpu.mma_matrix<16x16xf16, "BOp"> -> !gpu.mma_matrix<16x16xf32, "COp">
//       gpu.subgroup_mma_store_matrix %D_1, %arg2[%c0, %c0] {leadDimension = 32 : index} : !gpu.mma_matrix<16x16xf32, "COp">, memref<1024x1024xf32>
      
//       %A_2 = gpu.subgroup_mma_load_matrix %arg0[%c0, %c16] {leadDimension = 32 : index} : memref<1024x1024xf16> -> !gpu.mma_matrix<16x16xf16, "AOp">
//       %B_2 = gpu.subgroup_mma_load_matrix %arg1[%c16, %c0] {leadDimension = 32 : index} : memref<1024x1024xf16> -> !gpu.mma_matrix<16x16xf16, "BOp">
//       %C_2 = gpu.subgroup_mma_load_matrix %arg2[%c0, %c0] {leadDimension = 32 : index} : memref<1024x1024xf32> -> !gpu.mma_matrix<16x16xf32, "COp">
//       %D_2 = gpu.subgroup_mma_compute %A_2, %B_2, %C_2 : !gpu.mma_matrix<16x16xf16, "AOp">, !gpu.mma_matrix<16x16xf16, "BOp"> -> !gpu.mma_matrix<16x16xf32, "COp">
//       gpu.subgroup_mma_store_matrix %D_2, %arg2[%c0, %c0] {leadDimension = 32 : index} : !gpu.mma_matrix<16x16xf32, "COp">, memref<1024x1024xf32>
      
//       gpu.return
//     }
//   }
//   func.func private @printMemrefF32(%ptr : memref<*xf32>)
}

