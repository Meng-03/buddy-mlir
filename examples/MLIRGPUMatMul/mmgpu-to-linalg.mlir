module {
  func.func private @printMemrefF32(memref<*xf32>)
  func.func @main() {
    %alloc = memref.alloc() : memref<4x4xf32>
    %alloc_0 = memref.alloc() : memref<4x4xf32>
    %alloc_1 = memref.alloc() : memref<4x4xf32>
    %cst = arith.constant 1.000000e+00 : f32
    linalg.fill ins(%cst : f32) outs(%alloc : memref<4x4xf32>)
    linalg.fill ins(%cst : f32) outs(%alloc_0 : memref<4x4xf32>)
    linalg.fill ins(%cst : f32) outs(%alloc_1 : memref<4x4xf32>)
    gpu.module @gpumma {
      gpu.func @matmul(%arg0: memref<4x4xf32>, %arg1: memref<4x4xf32>, %arg2: memref<4x4xf32>) kernel {
        linalg.matmul ins(%arg0, %arg1 : memref<4x4xf32>, memref<4x4xf32>) outs(%arg2 : memref<4x4xf32>)
        gpu.return
      }
    }
    %cast = memref.cast %alloc_1 : memref<4x4xf32> to memref<*xf32>
    call @printMemrefF32(%cast) : (memref<*xf32>) -> ()
    memref.dealloc %alloc : memref<4x4xf32>
    memref.dealloc %alloc_0 : memref<4x4xf32>
    memref.dealloc %alloc_1 : memref<4x4xf32>
    return
  }
}

