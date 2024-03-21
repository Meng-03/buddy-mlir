module attributes {gpu.container_module} {
  func.func private @printMemrefF32(memref<*xf32>)
  func.func @main() {
    %alloc = memref.alloc() : memref<4x4xf32>
    %alloc_0 = memref.alloc() : memref<4x4xf32>
    %alloc_1 = memref.alloc() : memref<4x4xf32>
    %c1 = arith.constant 1 : index
    %c32 = arith.constant 32 : index
    %cst = arith.constant 1.000000e+00 : f32
    linalg.fill ins(%cst : f32) outs(%alloc : memref<4x4xf32>)
    linalg.fill ins(%cst : f32) outs(%alloc_0 : memref<4x4xf32>)
    linalg.fill ins(%cst : f32) outs(%alloc_1 : memref<4x4xf32>)
    gpu.launch_func  @main_kernel::@main_kernel blocks in (%c1, %c1, %c1) threads in (%c32, %c1, %c1)  args(%alloc : memref<4x4xf32>, %alloc_0 : memref<4x4xf32>, %alloc_1 : memref<4x4xf32>)
    %cast = memref.cast %alloc_1 : memref<4x4xf32> to memref<*xf32>
    call @printMemrefF32(%cast) : (memref<*xf32>) -> ()
    memref.dealloc %alloc : memref<4x4xf32>
    memref.dealloc %alloc_0 : memref<4x4xf32>
    memref.dealloc %alloc_1 : memref<4x4xf32>
    return
  }
  gpu.module @main_kernel {
    gpu.func @main_kernel(%arg0: memref<4x4xf32>, %arg1: memref<4x4xf32>, %arg2: memref<4x4xf32>) kernel attributes {gpu.known_block_size = array<i32: 32, 1, 1>, gpu.known_grid_size = array<i32: 1, 1, 1>} {
      %0 = gpu.block_id  x
      %1 = gpu.block_id  y
      %2 = gpu.block_id  z
      %3 = gpu.thread_id  x
      %4 = gpu.thread_id  y
      %5 = gpu.thread_id  z
      %6 = gpu.grid_dim  x
      %7 = gpu.grid_dim  y
      %8 = gpu.grid_dim  z
      %9 = gpu.block_dim  x
      %10 = gpu.block_dim  y
      %11 = gpu.block_dim  z
      cf.br ^bb1
    ^bb1:  // pred: ^bb0
      linalg.matmul ins(%arg0, %arg1 : memref<4x4xf32>, memref<4x4xf32>) outs(%arg2 : memref<4x4xf32>)
      gpu.return
    }
  }
}

