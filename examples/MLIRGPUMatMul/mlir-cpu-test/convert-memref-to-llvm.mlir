module {
  llvm.func @free(!llvm.ptr)
  llvm.func @malloc(i64) -> !llvm.ptr
  func.func private @printMemrefF32(memref<*xf32>)
  func.func @matmul(%arg0: memref<4x4xf32>, %arg1: memref<4x4xf32>, %arg2: memref<4x4xf32>) {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<4x4xf32> to !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %1 = builtin.unrealized_conversion_cast %arg1 : memref<4x4xf32> to !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %2 = builtin.unrealized_conversion_cast %arg2 : memref<4x4xf32> to !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %c0 = arith.constant 0 : index
    %c4 = arith.constant 4 : index
    %c1 = arith.constant 1 : index
    cf.br ^bb1(%c0 : index)
  ^bb1(%3: index):  // 2 preds: ^bb0, ^bb8
    %4 = builtin.unrealized_conversion_cast %3 : index to i64
    %5 = arith.cmpi slt, %3, %c4 : index
    cf.cond_br %5, ^bb2, ^bb9
  ^bb2:  // pred: ^bb1
    cf.br ^bb3(%c0 : index)
  ^bb3(%6: index):  // 2 preds: ^bb2, ^bb7
    %7 = builtin.unrealized_conversion_cast %6 : index to i64
    %8 = arith.cmpi slt, %6, %c4 : index
    cf.cond_br %8, ^bb4, ^bb8
  ^bb4:  // pred: ^bb3
    cf.br ^bb5(%c0 : index)
  ^bb5(%9: index):  // 2 preds: ^bb4, ^bb6
    %10 = builtin.unrealized_conversion_cast %9 : index to i64
    %11 = arith.cmpi slt, %9, %c4 : index
    cf.cond_br %11, ^bb6, ^bb7
  ^bb6:  // pred: ^bb5
    %12 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %13 = llvm.mlir.constant(4 : index) : i64
    %14 = llvm.mul %4, %13  : i64
    %15 = llvm.add %14, %10  : i64
    %16 = llvm.getelementptr %12[%15] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %17 = llvm.load %16 : !llvm.ptr -> f32
    %18 = llvm.extractvalue %1[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %19 = llvm.mlir.constant(4 : index) : i64
    %20 = llvm.mul %10, %19  : i64
    %21 = llvm.add %20, %7  : i64
    %22 = llvm.getelementptr %18[%21] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %23 = llvm.load %22 : !llvm.ptr -> f32
    %24 = llvm.extractvalue %2[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %25 = llvm.mlir.constant(4 : index) : i64
    %26 = llvm.mul %4, %25  : i64
    %27 = llvm.add %26, %7  : i64
    %28 = llvm.getelementptr %24[%27] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %29 = llvm.load %28 : !llvm.ptr -> f32
    %30 = arith.mulf %17, %23 : f32
    %31 = arith.addf %29, %30 : f32
    %32 = llvm.extractvalue %2[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %33 = llvm.mlir.constant(4 : index) : i64
    %34 = llvm.mul %4, %33  : i64
    %35 = llvm.add %34, %7  : i64
    %36 = llvm.getelementptr %32[%35] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    llvm.store %31, %36 : f32, !llvm.ptr
    %37 = arith.addi %9, %c1 : index
    cf.br ^bb5(%37 : index)
  ^bb7:  // pred: ^bb5
    %38 = arith.addi %6, %c1 : index
    cf.br ^bb3(%38 : index)
  ^bb8:  // pred: ^bb3
    %39 = arith.addi %3, %c1 : index
    cf.br ^bb1(%39 : index)
  ^bb9:  // pred: ^bb1
    return
  }
  func.func @main() {
    %c1 = arith.constant 1 : index
    %c4 = arith.constant 4 : index
    %c0 = arith.constant 0 : index
    %cst = arith.constant 1.000000e+00 : f32
    %0 = llvm.mlir.constant(4 : index) : i64
    %1 = llvm.mlir.constant(4 : index) : i64
    %2 = llvm.mlir.constant(1 : index) : i64
    %3 = llvm.mlir.constant(16 : index) : i64
    %4 = llvm.mlir.zero : !llvm.ptr
    %5 = llvm.getelementptr %4[%3] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %6 = llvm.ptrtoint %5 : !llvm.ptr to i64
    %7 = llvm.call @malloc(%6) : (i64) -> !llvm.ptr
    %8 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %9 = llvm.insertvalue %7, %8[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %10 = llvm.insertvalue %7, %9[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %11 = llvm.mlir.constant(0 : index) : i64
    %12 = llvm.insertvalue %11, %10[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %13 = llvm.insertvalue %0, %12[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %14 = llvm.insertvalue %1, %13[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %15 = llvm.insertvalue %1, %14[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %16 = llvm.insertvalue %2, %15[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %17 = builtin.unrealized_conversion_cast %16 : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> to memref<4x4xf32>
    %18 = llvm.mlir.constant(4 : index) : i64
    %19 = llvm.mlir.constant(4 : index) : i64
    %20 = llvm.mlir.constant(1 : index) : i64
    %21 = llvm.mlir.constant(16 : index) : i64
    %22 = llvm.mlir.zero : !llvm.ptr
    %23 = llvm.getelementptr %22[%21] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %24 = llvm.ptrtoint %23 : !llvm.ptr to i64
    %25 = llvm.call @malloc(%24) : (i64) -> !llvm.ptr
    %26 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %27 = llvm.insertvalue %25, %26[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %28 = llvm.insertvalue %25, %27[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %29 = llvm.mlir.constant(0 : index) : i64
    %30 = llvm.insertvalue %29, %28[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %31 = llvm.insertvalue %18, %30[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %32 = llvm.insertvalue %19, %31[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %33 = llvm.insertvalue %19, %32[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %34 = llvm.insertvalue %20, %33[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %35 = builtin.unrealized_conversion_cast %34 : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> to memref<4x4xf32>
    %36 = llvm.mlir.constant(4 : index) : i64
    %37 = llvm.mlir.constant(4 : index) : i64
    %38 = llvm.mlir.constant(1 : index) : i64
    %39 = llvm.mlir.constant(16 : index) : i64
    %40 = llvm.mlir.zero : !llvm.ptr
    %41 = llvm.getelementptr %40[%39] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %42 = llvm.ptrtoint %41 : !llvm.ptr to i64
    %43 = llvm.call @malloc(%42) : (i64) -> !llvm.ptr
    %44 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %45 = llvm.insertvalue %43, %44[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %46 = llvm.insertvalue %43, %45[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %47 = llvm.mlir.constant(0 : index) : i64
    %48 = llvm.insertvalue %47, %46[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %49 = llvm.insertvalue %36, %48[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %50 = llvm.insertvalue %37, %49[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %51 = llvm.insertvalue %37, %50[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %52 = llvm.insertvalue %38, %51[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %53 = builtin.unrealized_conversion_cast %52 : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> to memref<4x4xf32>
    cf.br ^bb1(%c0 : index)
  ^bb1(%54: index):  // 2 preds: ^bb0, ^bb5
    %55 = builtin.unrealized_conversion_cast %54 : index to i64
    %56 = arith.cmpi slt, %54, %c4 : index
    cf.cond_br %56, ^bb2, ^bb6
  ^bb2:  // pred: ^bb1
    cf.br ^bb3(%c0 : index)
  ^bb3(%57: index):  // 2 preds: ^bb2, ^bb4
    %58 = builtin.unrealized_conversion_cast %57 : index to i64
    %59 = arith.cmpi slt, %57, %c4 : index
    cf.cond_br %59, ^bb4, ^bb5
  ^bb4:  // pred: ^bb3
    %60 = llvm.extractvalue %16[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %61 = llvm.mlir.constant(4 : index) : i64
    %62 = llvm.mul %55, %61  : i64
    %63 = llvm.add %62, %58  : i64
    %64 = llvm.getelementptr %60[%63] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    llvm.store %cst, %64 : f32, !llvm.ptr
    %65 = arith.addi %57, %c1 : index
    cf.br ^bb3(%65 : index)
  ^bb5:  // pred: ^bb3
    %66 = arith.addi %54, %c1 : index
    cf.br ^bb1(%66 : index)
  ^bb6:  // pred: ^bb1
    cf.br ^bb7(%c0 : index)
  ^bb7(%67: index):  // 2 preds: ^bb6, ^bb11
    %68 = builtin.unrealized_conversion_cast %67 : index to i64
    %69 = arith.cmpi slt, %67, %c4 : index
    cf.cond_br %69, ^bb8, ^bb12
  ^bb8:  // pred: ^bb7
    cf.br ^bb9(%c0 : index)
  ^bb9(%70: index):  // 2 preds: ^bb8, ^bb10
    %71 = builtin.unrealized_conversion_cast %70 : index to i64
    %72 = arith.cmpi slt, %70, %c4 : index
    cf.cond_br %72, ^bb10, ^bb11
  ^bb10:  // pred: ^bb9
    %73 = llvm.extractvalue %34[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %74 = llvm.mlir.constant(4 : index) : i64
    %75 = llvm.mul %68, %74  : i64
    %76 = llvm.add %75, %71  : i64
    %77 = llvm.getelementptr %73[%76] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    llvm.store %cst, %77 : f32, !llvm.ptr
    %78 = arith.addi %70, %c1 : index
    cf.br ^bb9(%78 : index)
  ^bb11:  // pred: ^bb9
    %79 = arith.addi %67, %c1 : index
    cf.br ^bb7(%79 : index)
  ^bb12:  // pred: ^bb7
    cf.br ^bb13(%c0 : index)
  ^bb13(%80: index):  // 2 preds: ^bb12, ^bb17
    %81 = builtin.unrealized_conversion_cast %80 : index to i64
    %82 = arith.cmpi slt, %80, %c4 : index
    cf.cond_br %82, ^bb14, ^bb18
  ^bb14:  // pred: ^bb13
    cf.br ^bb15(%c0 : index)
  ^bb15(%83: index):  // 2 preds: ^bb14, ^bb16
    %84 = builtin.unrealized_conversion_cast %83 : index to i64
    %85 = arith.cmpi slt, %83, %c4 : index
    cf.cond_br %85, ^bb16, ^bb17
  ^bb16:  // pred: ^bb15
    %86 = llvm.extractvalue %52[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %87 = llvm.mlir.constant(4 : index) : i64
    %88 = llvm.mul %81, %87  : i64
    %89 = llvm.add %88, %84  : i64
    %90 = llvm.getelementptr %86[%89] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    llvm.store %cst, %90 : f32, !llvm.ptr
    %91 = arith.addi %83, %c1 : index
    cf.br ^bb15(%91 : index)
  ^bb17:  // pred: ^bb15
    %92 = arith.addi %80, %c1 : index
    cf.br ^bb13(%92 : index)
  ^bb18:  // pred: ^bb13
    call @matmul(%17, %35, %53) : (memref<4x4xf32>, memref<4x4xf32>, memref<4x4xf32>) -> ()
    %93 = llvm.mlir.constant(1 : index) : i64
    %94 = llvm.alloca %93 x !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> : (i64) -> !llvm.ptr
    llvm.store %52, %94 : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr
    %95 = llvm.mlir.constant(2 : index) : i64
    %96 = llvm.mlir.undef : !llvm.struct<(i64, ptr)>
    %97 = llvm.insertvalue %95, %96[0] : !llvm.struct<(i64, ptr)> 
    %98 = llvm.insertvalue %94, %97[1] : !llvm.struct<(i64, ptr)> 
    %99 = builtin.unrealized_conversion_cast %98 : !llvm.struct<(i64, ptr)> to memref<*xf32>
    call @printMemrefF32(%99) : (memref<*xf32>) -> ()
    %100 = llvm.extractvalue %16[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    llvm.call @free(%100) : (!llvm.ptr) -> ()
    %101 = llvm.extractvalue %34[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    llvm.call @free(%101) : (!llvm.ptr) -> ()
    %102 = llvm.extractvalue %52[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    llvm.call @free(%102) : (!llvm.ptr) -> ()
    return
  }
}

