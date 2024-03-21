module {
  func.func private @printMemrefF32(memref<*xf32>)
  func.func @matmul(%arg0: memref<4x4xf32>, %arg1: memref<4x4xf32>, %arg2: memref<4x4xf32>) {
    %c0 = arith.constant 0 : index
    %c4 = arith.constant 4 : index
    %c1 = arith.constant 1 : index
    scf.parallel (%arg3, %arg4) = (%c0, %c0) to (%c4, %c4) step (%c1, %c1) {
      scf.for %arg5 = %c0 to %c4 step %c1 {
        %0 = memref.load %arg0[%arg3, %arg5] : memref<4x4xf32>
        %1 = memref.load %arg1[%arg5, %arg4] : memref<4x4xf32>
        %2 = memref.load %arg2[%arg3, %arg4] : memref<4x4xf32>
        %3 = arith.mulf %0, %1 : f32
        %4 = arith.addf %2, %3 : f32
        memref.store %4, %arg2[%arg3, %arg4] : memref<4x4xf32>
      }
      scf.yield
    }
    return
  }
  func.func @main() {
    %c0 = arith.constant 0 : index
    %c4 = arith.constant 4 : index
    %c1 = arith.constant 1 : index
    %cst = arith.constant 1.000000e+00 : f32
    %alloc = memref.alloc() : memref<4x4xf32>
    %alloc_0 = memref.alloc() : memref<4x4xf32>
    %alloc_1 = memref.alloc() : memref<4x4xf32>
    scf.parallel (%arg0, %arg1) = (%c0, %c0) to (%c4, %c4) step (%c1, %c1) {
      memref.store %cst, %alloc[%arg0, %arg1] : memref<4x4xf32>
      scf.yield
    }
    scf.parallel (%arg0, %arg1) = (%c0, %c0) to (%c4, %c4) step (%c1, %c1) {
      memref.store %cst, %alloc_0[%arg0, %arg1] : memref<4x4xf32>
      scf.yield
    }
    scf.parallel (%arg0, %arg1) = (%c0, %c0) to (%c4, %c4) step (%c1, %c1) {
      memref.store %cst, %alloc_1[%arg0, %arg1] : memref<4x4xf32>
      scf.yield
    }
    call @matmul(%alloc, %alloc_0, %alloc_1) : (memref<4x4xf32>, memref<4x4xf32>, memref<4x4xf32>) -> ()
    %cast = memref.cast %alloc_1 : memref<4x4xf32> to memref<*xf32>
    call @printMemrefF32(%cast) : (memref<*xf32>) -> ()
    memref.dealloc %alloc : memref<4x4xf32>
    memref.dealloc %alloc_0 : memref<4x4xf32>
    memref.dealloc %alloc_1 : memref<4x4xf32>
    return
  }
}

