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
    gpu.launch blocks(%arg0, %arg1, %arg2) in (%arg6 = %c1, %arg7 = %c1, %arg8 = %c1) threads(%arg3, %arg4, %arg5) in (%arg9 = %c32, %arg10 = %c1, %arg11 = %c1) {
      linalg.matmul ins(%alloc, %alloc_0 : memref<4x4xf32>, memref<4x4xf32>) outs(%alloc_1 : memref<4x4xf32>)
      gpu.terminator
    }
    %cast = memref.cast %alloc_1 : memref<4x4xf32> to memref<*xf32>
    call @printMemrefF32(%cast) : (memref<*xf32>) -> ()
    memref.dealloc %alloc : memref<4x4xf32>
    memref.dealloc %alloc_0 : memref<4x4xf32>
    memref.dealloc %alloc_1 : memref<4x4xf32>
    return
  }
}

