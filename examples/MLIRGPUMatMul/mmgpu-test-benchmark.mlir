module attributes {gpu.container_module} {
  func.func @main() {
    %c0 = arith.constant 0 : index 
    %c1 = arith.constant 1 : index  
    %c2 = arith.constant 2 : index
    %c32 = arith.constant 32 : index 
    %c16 = arith.constant 16 : index 
    %f0 = arith.constant 0.0 : f16
    %f1 = arith.constant 1.0 : f16
    %f2 = arith.constant 2.0 : f16
    %f2f32 = arith.constant 2.0 : f32
    %f0f32 = arith.constant 0.0 : f32
    %input0 = memref.alloc() : memref<16x16xf16>
    %input1 = memref.alloc() : memref<16x16xf16>
    %output0 = memref.alloc() : memref<16x16xf32>
    %input_cast0 = memref.cast %input0 : memref<16x16xf16> to memref<*xf16>
    %input_cast1 = memref.cast %input1 : memref<16x16xf16> to memref<*xf16>
    %output_cast0 = memref.cast %output0 : memref<16x16xf32> to memref<*xf32>
    scf.for %i = %c0 to %c16 step %c1 {
      scf.for %j = %c0 to %c16 step %c1 {
        memref.store %f2, %input0[%i, %j] : memref<16x16xf16> 
        memref.store %f2, %input1[%i, %j] : memref<16x16xf16>
        memref.store %f0f32, %output0[%i, %j] : memref<16x16xf32>
      }
    }  
    call @printMemrefF32(%output_cast0) : (memref<*xf32>) -> ()
    gpu.host_register %input_cast0 : memref<*xf16>  
    gpu.host_register %input_cast1 : memref<*xf16>
    gpu.host_register %output_cast0 : memref<*xf32>
    
    // Record kernel strart time
    %t_start = call @rtclock():()->f64

    gpu.launch_func @kernels::@kernel1 blocks in (%c1, %c1, %c1) threads in (%c32, %c1, %c1) args(%input0 : memref<16x16xf16>, %input1 : memref<16x16xf16>, %output0 : memref<16x16xf32>)
    
    // Record kernel end time
    %t_end = call @rtclock():()->f64
    // Get the total running time 
    %t = arith.subf %t_end, %t_start : f64

    // 2 * k * m * n
    %flops1 = arith.muli %c16, %c16 : index
    %flops2 = arith.muli %flops1, %c16 : index
    %flops3 = arith.muli %flops2, %c2 : index
    // Caculate FLOPS
    // todo: experiment times
    // %num_flops = arith.muli 
    %flops_i = arith.index_cast %flops3 : index to i64
    %flops_f = arith.sitofp %flops_i : i64 to f64
    %flops = arith.divf %flops_f, %t : f64
    vector.print %flops : f64

    call @printMemrefF32(%output_cast0) : (memref<*xf32>) -> ()
    memref.dealloc %input0 : memref<16x16xf16>
    memref.dealloc %input1 : memref<16x16xf16>
    memref.dealloc %output0 : memref<16x16xf32>
    return
  }

  gpu.module @kernels {
    gpu.func @kernel1(%arg0 : memref<16x16xf16>, %arg1 : memref<16x16xf16>, %arg2 : memref<16x16xf32>) kernel {
      %c0 = arith.constant 0 : index 
      %A = gpu.subgroup_mma_load_matrix %arg0[%c0, %c0] {leadDimension = 16 : index} : memref<16x16xf16> -> !gpu.mma_matrix<16x16xf16, "AOp">
      %B = gpu.subgroup_mma_load_matrix %arg1[%c0, %c0] {leadDimension = 16 : index} : memref<16x16xf16> -> !gpu.mma_matrix<16x16xf16, "BOp">
      %C = gpu.subgroup_mma_load_matrix %arg2[%c0, %c0] {leadDimension = 16 : index} : memref<16x16xf32> -> !gpu.mma_matrix<16x16xf32, "COp">
      %D = gpu.subgroup_mma_compute %A, %B, %C : !gpu.mma_matrix<16x16xf16, "AOp">, !gpu.mma_matrix<16x16xf16, "BOp"> -> !gpu.mma_matrix<16x16xf32, "COp">
      gpu.subgroup_mma_store_matrix %D, %arg2[%c0, %c0] {leadDimension = 16 : index} : !gpu.mma_matrix<16x16xf32, "COp">, memref<16x16xf32>
      gpu.return
    }
  }
  func.func private @printMemrefF32(%ptr : memref<*xf32>)
  func.func private @rtclock() -> f64
}


// module attributes {gpu.container_module} {
//   func.func private @printMemrefF32(memref<*xf32>)
//   func.func @main() {
//     %alloc = memref.alloc() : memref<16x16xf16>
//     %alloc_0 = memref.alloc() : memref<16x16xf16>
//     %alloc_1 = memref.alloc() : memref<16x16xf32>
//     %c1 = arith.constant 1 : index
//     %c32 = arith.constant 32 : index
//     %f1 = arith.constant 1.000000e+00 : f16
//     %f0 = arith.constant 0.000000e+00 : f32
//     linalg.fill ins(%f1 : f16) outs(%alloc : memref<16x16xf16>)
//     linalg.fill ins(%f1 : f16) outs(%alloc_0 : memref<16x16xf16>)
//     linalg.fill ins(%f0 : f32) outs(%alloc_1 : memref<16x16xf32>)
//     gpu.host_register %input_cast0 : memref<*xf16>  
//     gpu.host_register %input_cast1 : memref<*xf16>
//     gpu.host_register %output_cast0 : memref<*xf32>
//     gpu.launch_func  @main_kernel::@main_kernel blocks in (%c1, %c1, %c1) threads in (%c32, %c1, %c1)  args(%alloc : memref<16x16xf16>, %alloc_0 : memref<16x16xf16>, %alloc_1 : memref<16x16xf32>)
//     %cast = memref.cast %alloc_1 : memref<16x16xf32> to memref<*xf32>
//     call @printMemrefF32(%cast) : (memref<*xf32>) -> ()
//     memref.dealloc %alloc : memref<16x16xf16>
//     memref.dealloc %alloc_0 : memref<16x16xf16>
//     memref.dealloc %alloc_1 : memref<16x16xf32>
//     return
//   }
//   gpu.module @main_kernel {
//     gpu.func @main_kernel(%arg0: memref<16x16xf16>, %arg1: memref<16x16xf16>, %arg2: memref<16x16xf32>) kernel attributes {gpu.known_block_size = array<i32: 32, 1, 1>, gpu.known_grid_size = array<i32: 1, 1, 1>} {
//       %0 = gpu.block_id  x
//       %1 = gpu.block_id  y
//       %2 = gpu.block_id  z
//       %3 = gpu.thread_id  x
//       %4 = gpu.thread_id  y
//       %5 = gpu.thread_id  z
//       %6 = gpu.grid_dim  x
//       %7 = gpu.grid_dim  y
//       %8 = gpu.grid_dim  z
//       %9 = gpu.block_dim  x
//       %10 = gpu.block_dim  y
//       %11 = gpu.block_dim  z
//       cf.br ^bb1
//     ^bb1:  // pred: ^bb0
//         %c0 = arith.constant 0 : index 
//         %A = gpu.subgroup_mma_load_matrix %arg0[%c0, %c0] {leadDimension = 4 : index} : memref<16x16xf16> -> !gpu.mma_matrix<16x16xf16, "AOp">
//         %B = gpu.subgroup_mma_load_matrix %arg1[%c0, %c0] {leadDimension = 4 : index} : memref<16x16xf16> -> !gpu.mma_matrix<16x16xf16, "BOp">
//         %C = gpu.subgroup_mma_load_matrix %arg2[%c0, %c0] {leadDimension = 4 : index} : memref<16x16xf32> -> !gpu.mma_matrix<16x16xf32, "COp">
//         %D = gpu.subgroup_mma_compute %A, %B, %C : !gpu.mma_matrix<16x16xf16, "AOp">, !gpu.mma_matrix<16x16xf16, "BOp"> -> !gpu.mma_matrix<16x16xf32, "COp">
//         gpu.subgroup_mma_store_matrix %D, %arg2[%c0, %c0] {leadDimension = 16 : index} : !gpu.mma_matrix<16x16xf32, "COp">, memref<16x16xf32>
//         gpu.return
//     }
//   }
// }


