module {
  func.func private @printMemrefF32(memref<*xf32>)
  func.func @matmul(%arg0: memref<4x4xf32>, %arg1: memref<4x4xf32>, %arg2: memref<4x4xf32>) {
    %c0 = arith.constant 0 : index
    %c4 = arith.constant 4 : index
    %c1 = arith.constant 1 : index
    scf.for %arg3 = %c0 to %c4 step %c1 {
      %c0_0 = arith.constant 0 : index
      %c4_1 = arith.constant 4 : index
      %c1_2 = arith.constant 1 : index
      scf.for %arg4 = %c0_0 to %c4_1 step %c1_2 {
        %c0_3 = arith.constant 0 : index
        %c4_4 = arith.constant 4 : index
        %c1_5 = arith.constant 1 : index
        scf.for %arg5 = %c0_3 to %c4_4 step %c1_5 {
          %0 = memref.load %arg0[%arg3, %arg5] : memref<4x4xf32>
          %1 = memref.load %arg1[%arg5, %arg4] : memref<4x4xf32>
          %2 = memref.load %arg2[%arg3, %arg4] : memref<4x4xf32>
          %3 = arith.mulf %0, %1 : f32
          %4 = arith.addf %2, %3 : f32
          memref.store %4, %arg2[%arg3, %arg4] : memref<4x4xf32>
        }
      }
    }
    return
  }
  func.func @main() {
    %cst = arith.constant 1.000000e+00 : f32
    %alloc = memref.alloc() : memref<4x4xf32>
    %alloc_0 = memref.alloc() : memref<4x4xf32>
    %alloc_1 = memref.alloc() : memref<4x4xf32>
    %c0 = arith.constant 0 : index
    %c4 = arith.constant 4 : index
    %c1 = arith.constant 1 : index
    scf.for %arg0 = %c0 to %c4 step %c1 {
      %c0_8 = arith.constant 0 : index
      %c4_9 = arith.constant 4 : index
      %c1_10 = arith.constant 1 : index
      scf.for %arg1 = %c0_8 to %c4_9 step %c1_10 {
        memref.store %cst, %alloc[%arg0, %arg1] : memref<4x4xf32>
      }
    }
    %c0_2 = arith.constant 0 : index
    %c4_3 = arith.constant 4 : index
    %c1_4 = arith.constant 1 : index
    scf.for %arg0 = %c0_2 to %c4_3 step %c1_4 {
      %c0_8 = arith.constant 0 : index
      %c4_9 = arith.constant 4 : index
      %c1_10 = arith.constant 1 : index
      scf.for %arg1 = %c0_8 to %c4_9 step %c1_10 {
        memref.store %cst, %alloc_0[%arg0, %arg1] : memref<4x4xf32>
      }
    }
    %c0_5 = arith.constant 0 : index
    %c4_6 = arith.constant 4 : index
    %c1_7 = arith.constant 1 : index
    scf.for %arg0 = %c0_5 to %c4_6 step %c1_7 {
      %c0_8 = arith.constant 0 : index
      %c4_9 = arith.constant 4 : index
      %c1_10 = arith.constant 1 : index
      scf.for %arg1 = %c0_8 to %c4_9 step %c1_10 {
        memref.store %cst, %alloc_1[%arg0, %arg1] : memref<4x4xf32>
      }
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

