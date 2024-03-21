module {
  func.func private @printMemrefF32(memref<*xf32>)
  func.func @matmul(%arg0: memref<?x?xf32>, %arg1: memref<?x?xf32>, %arg2: memref<?x?xf32>) {
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %dim = memref.dim %arg0, %c0 : memref<?x?xf32>
    %dim_0 = memref.dim %arg0, %c1 : memref<?x?xf32>
    %dim_1 = memref.dim %arg1, %c1 : memref<?x?xf32>
    affine.for %arg3 = 0 to %dim {//M
      affine.for %arg4 = 0 to %dim_1 {//N
        affine.for %arg5 = 0 to %dim_0 {//K
          %0 = affine.load %arg0[%arg3, %arg5] : memref<?x?xf32>
          %1 = affine.load %arg1[%arg5, %arg4] : memref<?x?xf32>
          %2 = affine.load %arg2[%arg3, %arg4] : memref<?x?xf32>
          %3 = arith.mulf %0, %1 : f32
          %4 = arith.addf %2, %3 : f32
          affine.store %4, %arg2[%arg3, %arg4] : memref<?x?xf32>
        }
      }
    }
    return
  }
  func.func @main() {
    %c4 = arith.constant 4 : index
    %cst = arith.constant 1.000000e+00 : f32
    %alloc = memref.alloc(%c4, %c4) : memref<?x?xf32>
    %alloc_0 = memref.alloc(%c4, %c4) : memref<?x?xf32>
    %alloc_1 = memref.alloc(%c4, %c4) : memref<?x?xf32>
    affine.for %arg0 = 0 to 4 {
      affine.for %arg1 = 0 to 4 {
        affine.store %cst, %alloc[%arg0, %arg1] : memref<?x?xf32>
      }
    }
    affine.for %arg0 = 0 to 4 {
      affine.for %arg1 = 0 to 4 {
        affine.store %cst, %alloc_0[%arg0, %arg1] : memref<?x?xf32>
      }
    }
    affine.for %arg0 = 0 to 4 {
      affine.for %arg1 = 0 to 4 {
        affine.store %cst, %alloc_1[%arg0, %arg1] : memref<?x?xf32>
      }
    }
    call @matmul(%alloc, %alloc_0, %alloc_1) : (memref<?x?xf32>, memref<?x?xf32>, memref<?x?xf32>) -> ()
    %cast = memref.cast %alloc_1 : memref<?x?xf32> to memref<*xf32>
    call @printMemrefF32(%cast) : (memref<*xf32>) -> ()
    memref.dealloc %alloc_1 : memref<?x?xf32>
    memref.dealloc %alloc_0 : memref<?x?xf32>
    memref.dealloc %alloc : memref<?x?xf32>
    return
  }
}

