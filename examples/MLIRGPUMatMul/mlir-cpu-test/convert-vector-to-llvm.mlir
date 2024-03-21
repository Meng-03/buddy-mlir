module {
  func.func private @printMemrefF32(memref<*xf32>)
  func.func @matmul(%arg0: memref<4x4xf32>, %arg1: memref<4x4xf32>, %arg2: memref<4x4xf32>) {
    %c0 = arith.constant 0 : index
    %c4 = arith.constant 4 : index
    %c1 = arith.constant 1 : index
    cf.br ^bb1(%c0 : index)
  ^bb1(%0: index):  // 2 preds: ^bb0, ^bb8
    %1 = arith.cmpi slt, %0, %c4 : index
    cf.cond_br %1, ^bb2, ^bb9
  ^bb2:  // pred: ^bb1
    cf.br ^bb3(%c0 : index)
  ^bb3(%2: index):  // 2 preds: ^bb2, ^bb7
    %3 = arith.cmpi slt, %2, %c4 : index
    cf.cond_br %3, ^bb4, ^bb8
  ^bb4:  // pred: ^bb3
    cf.br ^bb5(%c0 : index)
  ^bb5(%4: index):  // 2 preds: ^bb4, ^bb6
    %5 = arith.cmpi slt, %4, %c4 : index
    cf.cond_br %5, ^bb6, ^bb7
  ^bb6:  // pred: ^bb5
    %6 = memref.load %arg0[%0, %4] : memref<4x4xf32>
    %7 = memref.load %arg1[%4, %2] : memref<4x4xf32>
    %8 = memref.load %arg2[%0, %2] : memref<4x4xf32>
    %9 = arith.mulf %6, %7 : f32
    %10 = arith.addf %8, %9 : f32
    memref.store %10, %arg2[%0, %2] : memref<4x4xf32>
    %11 = arith.addi %4, %c1 : index
    cf.br ^bb5(%11 : index)
  ^bb7:  // pred: ^bb5
    %12 = arith.addi %2, %c1 : index
    cf.br ^bb3(%12 : index)
  ^bb8:  // pred: ^bb3
    %13 = arith.addi %0, %c1 : index
    cf.br ^bb1(%13 : index)
  ^bb9:  // pred: ^bb1
    return
  }
  func.func @main() {
    %c1 = arith.constant 1 : index
    %c4 = arith.constant 4 : index
    %c0 = arith.constant 0 : index
    %cst = arith.constant 1.000000e+00 : f32
    %alloc = memref.alloc() : memref<4x4xf32>
    %alloc_0 = memref.alloc() : memref<4x4xf32>
    %alloc_1 = memref.alloc() : memref<4x4xf32>
    cf.br ^bb1(%c0 : index)
  ^bb1(%0: index):  // 2 preds: ^bb0, ^bb5
    %1 = arith.cmpi slt, %0, %c4 : index
    cf.cond_br %1, ^bb2, ^bb6
  ^bb2:  // pred: ^bb1
    cf.br ^bb3(%c0 : index)
  ^bb3(%2: index):  // 2 preds: ^bb2, ^bb4
    %3 = arith.cmpi slt, %2, %c4 : index
    cf.cond_br %3, ^bb4, ^bb5
  ^bb4:  // pred: ^bb3
    memref.store %cst, %alloc[%0, %2] : memref<4x4xf32>
    %4 = arith.addi %2, %c1 : index
    cf.br ^bb3(%4 : index)
  ^bb5:  // pred: ^bb3
    %5 = arith.addi %0, %c1 : index
    cf.br ^bb1(%5 : index)
  ^bb6:  // pred: ^bb1
    cf.br ^bb7(%c0 : index)
  ^bb7(%6: index):  // 2 preds: ^bb6, ^bb11
    %7 = arith.cmpi slt, %6, %c4 : index
    cf.cond_br %7, ^bb8, ^bb12
  ^bb8:  // pred: ^bb7
    cf.br ^bb9(%c0 : index)
  ^bb9(%8: index):  // 2 preds: ^bb8, ^bb10
    %9 = arith.cmpi slt, %8, %c4 : index
    cf.cond_br %9, ^bb10, ^bb11
  ^bb10:  // pred: ^bb9
    memref.store %cst, %alloc_0[%6, %8] : memref<4x4xf32>
    %10 = arith.addi %8, %c1 : index
    cf.br ^bb9(%10 : index)
  ^bb11:  // pred: ^bb9
    %11 = arith.addi %6, %c1 : index
    cf.br ^bb7(%11 : index)
  ^bb12:  // pred: ^bb7
    cf.br ^bb13(%c0 : index)
  ^bb13(%12: index):  // 2 preds: ^bb12, ^bb17
    %13 = arith.cmpi slt, %12, %c4 : index
    cf.cond_br %13, ^bb14, ^bb18
  ^bb14:  // pred: ^bb13
    cf.br ^bb15(%c0 : index)
  ^bb15(%14: index):  // 2 preds: ^bb14, ^bb16
    %15 = arith.cmpi slt, %14, %c4 : index
    cf.cond_br %15, ^bb16, ^bb17
  ^bb16:  // pred: ^bb15
    memref.store %cst, %alloc_1[%12, %14] : memref<4x4xf32>
    %16 = arith.addi %14, %c1 : index
    cf.br ^bb15(%16 : index)
  ^bb17:  // pred: ^bb15
    %17 = arith.addi %12, %c1 : index
    cf.br ^bb13(%17 : index)
  ^bb18:  // pred: ^bb13
    call @matmul(%alloc, %alloc_0, %alloc_1) : (memref<4x4xf32>, memref<4x4xf32>, memref<4x4xf32>) -> ()
    %cast = memref.cast %alloc_1 : memref<4x4xf32> to memref<*xf32>
    call @printMemrefF32(%cast) : (memref<*xf32>) -> ()
    memref.dealloc %alloc : memref<4x4xf32>
    memref.dealloc %alloc_0 : memref<4x4xf32>
    memref.dealloc %alloc_1 : memref<4x4xf32>
    return
  }
}

