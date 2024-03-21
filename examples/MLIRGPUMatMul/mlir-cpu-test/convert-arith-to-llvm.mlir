module {
  llvm.func @free(!llvm.ptr)
  llvm.func @malloc(i64) -> !llvm.ptr
  func.func private @printMemrefF32(memref<*xf32>)
  func.func @matmul(%arg0: memref<4x4xf32>, %arg1: memref<4x4xf32>, %arg2: memref<4x4xf32>) {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<4x4xf32> to !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %1 = builtin.unrealized_conversion_cast %arg1 : memref<4x4xf32> to !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %2 = builtin.unrealized_conversion_cast %arg2 : memref<4x4xf32> to !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %3 = llvm.mlir.constant(0 : index) : i64
    %4 = builtin.unrealized_conversion_cast %3 : i64 to index
    %5 = llvm.mlir.constant(4 : index) : i64
    %6 = llvm.mlir.constant(1 : index) : i64
    cf.br ^bb1(%4 : index)
  ^bb1(%7: index):  // 2 preds: ^bb0, ^bb8
    %8 = builtin.unrealized_conversion_cast %7 : index to i64
    %9 = builtin.unrealized_conversion_cast %7 : index to i64
    %10 = llvm.icmp "slt" %8, %5 : i64
    cf.cond_br %10, ^bb2, ^bb9
  ^bb2:  // pred: ^bb1
    cf.br ^bb3(%4 : index)
  ^bb3(%11: index):  // 2 preds: ^bb2, ^bb7
    %12 = builtin.unrealized_conversion_cast %11 : index to i64
    %13 = builtin.unrealized_conversion_cast %11 : index to i64
    %14 = llvm.icmp "slt" %12, %5 : i64
    cf.cond_br %14, ^bb4, ^bb8
  ^bb4:  // pred: ^bb3
    cf.br ^bb5(%4 : index)
  ^bb5(%15: index):  // 2 preds: ^bb4, ^bb6
    %16 = builtin.unrealized_conversion_cast %15 : index to i64
    %17 = builtin.unrealized_conversion_cast %15 : index to i64
    %18 = llvm.icmp "slt" %16, %5 : i64
    cf.cond_br %18, ^bb6, ^bb7
  ^bb6:  // pred: ^bb5
    %19 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %20 = llvm.mlir.constant(4 : index) : i64
    %21 = llvm.mul %9, %20  : i64
    %22 = llvm.add %21, %17  : i64
    %23 = llvm.getelementptr %19[%22] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %24 = llvm.load %23 : !llvm.ptr -> f32
    %25 = llvm.extractvalue %1[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %26 = llvm.mlir.constant(4 : index) : i64
    %27 = llvm.mul %17, %26  : i64
    %28 = llvm.add %27, %13  : i64
    %29 = llvm.getelementptr %25[%28] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %30 = llvm.load %29 : !llvm.ptr -> f32
    %31 = llvm.extractvalue %2[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %32 = llvm.mlir.constant(4 : index) : i64
    %33 = llvm.mul %9, %32  : i64
    %34 = llvm.add %33, %13  : i64
    %35 = llvm.getelementptr %31[%34] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %36 = llvm.load %35 : !llvm.ptr -> f32
    %37 = llvm.fmul %24, %30  : f32
    %38 = llvm.fadd %36, %37  : f32
    %39 = llvm.extractvalue %2[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %40 = llvm.mlir.constant(4 : index) : i64
    %41 = llvm.mul %9, %40  : i64
    %42 = llvm.add %41, %13  : i64
    %43 = llvm.getelementptr %39[%42] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    llvm.store %38, %43 : f32, !llvm.ptr
    %44 = llvm.add %16, %6  : i64
    %45 = builtin.unrealized_conversion_cast %44 : i64 to index
    cf.br ^bb5(%45 : index)
  ^bb7:  // pred: ^bb5
    %46 = llvm.add %12, %6  : i64
    %47 = builtin.unrealized_conversion_cast %46 : i64 to index
    cf.br ^bb3(%47 : index)
  ^bb8:  // pred: ^bb3
    %48 = llvm.add %8, %6  : i64
    %49 = builtin.unrealized_conversion_cast %48 : i64 to index
    cf.br ^bb1(%49 : index)
  ^bb9:  // pred: ^bb1
    return
  }
  func.func @main() {
    %0 = llvm.mlir.constant(1 : index) : i64
    %1 = llvm.mlir.constant(4 : index) : i64
    %2 = llvm.mlir.constant(0 : index) : i64
    %3 = builtin.unrealized_conversion_cast %2 : i64 to index
    %4 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %5 = llvm.mlir.constant(4 : index) : i64
    %6 = llvm.mlir.constant(4 : index) : i64
    %7 = llvm.mlir.constant(1 : index) : i64
    %8 = llvm.mlir.constant(16 : index) : i64
    %9 = llvm.mlir.zero : !llvm.ptr
    %10 = llvm.getelementptr %9[%8] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %11 = llvm.ptrtoint %10 : !llvm.ptr to i64
    %12 = llvm.call @malloc(%11) : (i64) -> !llvm.ptr
    %13 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %14 = llvm.insertvalue %12, %13[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %15 = llvm.insertvalue %12, %14[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %16 = llvm.mlir.constant(0 : index) : i64
    %17 = llvm.insertvalue %16, %15[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %18 = llvm.insertvalue %5, %17[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %19 = llvm.insertvalue %6, %18[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %20 = llvm.insertvalue %6, %19[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %21 = llvm.insertvalue %7, %20[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %22 = builtin.unrealized_conversion_cast %21 : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> to memref<4x4xf32>
    %23 = llvm.mlir.constant(4 : index) : i64
    %24 = llvm.mlir.constant(4 : index) : i64
    %25 = llvm.mlir.constant(1 : index) : i64
    %26 = llvm.mlir.constant(16 : index) : i64
    %27 = llvm.mlir.zero : !llvm.ptr
    %28 = llvm.getelementptr %27[%26] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %29 = llvm.ptrtoint %28 : !llvm.ptr to i64
    %30 = llvm.call @malloc(%29) : (i64) -> !llvm.ptr
    %31 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %32 = llvm.insertvalue %30, %31[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %33 = llvm.insertvalue %30, %32[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %34 = llvm.mlir.constant(0 : index) : i64
    %35 = llvm.insertvalue %34, %33[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %36 = llvm.insertvalue %23, %35[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %37 = llvm.insertvalue %24, %36[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %38 = llvm.insertvalue %24, %37[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %39 = llvm.insertvalue %25, %38[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %40 = builtin.unrealized_conversion_cast %39 : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> to memref<4x4xf32>
    %41 = llvm.mlir.constant(4 : index) : i64
    %42 = llvm.mlir.constant(4 : index) : i64
    %43 = llvm.mlir.constant(1 : index) : i64
    %44 = llvm.mlir.constant(16 : index) : i64
    %45 = llvm.mlir.zero : !llvm.ptr
    %46 = llvm.getelementptr %45[%44] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %47 = llvm.ptrtoint %46 : !llvm.ptr to i64
    %48 = llvm.call @malloc(%47) : (i64) -> !llvm.ptr
    %49 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %50 = llvm.insertvalue %48, %49[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %51 = llvm.insertvalue %48, %50[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %52 = llvm.mlir.constant(0 : index) : i64
    %53 = llvm.insertvalue %52, %51[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %54 = llvm.insertvalue %41, %53[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %55 = llvm.insertvalue %42, %54[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %56 = llvm.insertvalue %42, %55[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %57 = llvm.insertvalue %43, %56[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %58 = builtin.unrealized_conversion_cast %57 : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> to memref<4x4xf32>
    cf.br ^bb1(%3 : index)
  ^bb1(%59: index):  // 2 preds: ^bb0, ^bb5
    %60 = builtin.unrealized_conversion_cast %59 : index to i64
    %61 = builtin.unrealized_conversion_cast %59 : index to i64
    %62 = llvm.icmp "slt" %60, %1 : i64
    cf.cond_br %62, ^bb2, ^bb6
  ^bb2:  // pred: ^bb1
    cf.br ^bb3(%3 : index)
  ^bb3(%63: index):  // 2 preds: ^bb2, ^bb4
    %64 = builtin.unrealized_conversion_cast %63 : index to i64
    %65 = builtin.unrealized_conversion_cast %63 : index to i64
    %66 = llvm.icmp "slt" %64, %1 : i64
    cf.cond_br %66, ^bb4, ^bb5
  ^bb4:  // pred: ^bb3
    %67 = llvm.extractvalue %21[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %68 = llvm.mlir.constant(4 : index) : i64
    %69 = llvm.mul %61, %68  : i64
    %70 = llvm.add %69, %65  : i64
    %71 = llvm.getelementptr %67[%70] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    llvm.store %4, %71 : f32, !llvm.ptr
    %72 = llvm.add %64, %0  : i64
    %73 = builtin.unrealized_conversion_cast %72 : i64 to index
    cf.br ^bb3(%73 : index)
  ^bb5:  // pred: ^bb3
    %74 = llvm.add %60, %0  : i64
    %75 = builtin.unrealized_conversion_cast %74 : i64 to index
    cf.br ^bb1(%75 : index)
  ^bb6:  // pred: ^bb1
    cf.br ^bb7(%3 : index)
  ^bb7(%76: index):  // 2 preds: ^bb6, ^bb11
    %77 = builtin.unrealized_conversion_cast %76 : index to i64
    %78 = builtin.unrealized_conversion_cast %76 : index to i64
    %79 = llvm.icmp "slt" %77, %1 : i64
    cf.cond_br %79, ^bb8, ^bb12
  ^bb8:  // pred: ^bb7
    cf.br ^bb9(%3 : index)
  ^bb9(%80: index):  // 2 preds: ^bb8, ^bb10
    %81 = builtin.unrealized_conversion_cast %80 : index to i64
    %82 = builtin.unrealized_conversion_cast %80 : index to i64
    %83 = llvm.icmp "slt" %81, %1 : i64
    cf.cond_br %83, ^bb10, ^bb11
  ^bb10:  // pred: ^bb9
    %84 = llvm.extractvalue %39[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %85 = llvm.mlir.constant(4 : index) : i64
    %86 = llvm.mul %78, %85  : i64
    %87 = llvm.add %86, %82  : i64
    %88 = llvm.getelementptr %84[%87] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    llvm.store %4, %88 : f32, !llvm.ptr
    %89 = llvm.add %81, %0  : i64
    %90 = builtin.unrealized_conversion_cast %89 : i64 to index
    cf.br ^bb9(%90 : index)
  ^bb11:  // pred: ^bb9
    %91 = llvm.add %77, %0  : i64
    %92 = builtin.unrealized_conversion_cast %91 : i64 to index
    cf.br ^bb7(%92 : index)
  ^bb12:  // pred: ^bb7
    cf.br ^bb13(%3 : index)
  ^bb13(%93: index):  // 2 preds: ^bb12, ^bb17
    %94 = builtin.unrealized_conversion_cast %93 : index to i64
    %95 = builtin.unrealized_conversion_cast %93 : index to i64
    %96 = llvm.icmp "slt" %94, %1 : i64
    cf.cond_br %96, ^bb14, ^bb18
  ^bb14:  // pred: ^bb13
    cf.br ^bb15(%3 : index)
  ^bb15(%97: index):  // 2 preds: ^bb14, ^bb16
    %98 = builtin.unrealized_conversion_cast %97 : index to i64
    %99 = builtin.unrealized_conversion_cast %97 : index to i64
    %100 = llvm.icmp "slt" %98, %1 : i64
    cf.cond_br %100, ^bb16, ^bb17
  ^bb16:  // pred: ^bb15
    %101 = llvm.extractvalue %57[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %102 = llvm.mlir.constant(4 : index) : i64
    %103 = llvm.mul %95, %102  : i64
    %104 = llvm.add %103, %99  : i64
    %105 = llvm.getelementptr %101[%104] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    llvm.store %4, %105 : f32, !llvm.ptr
    %106 = llvm.add %98, %0  : i64
    %107 = builtin.unrealized_conversion_cast %106 : i64 to index
    cf.br ^bb15(%107 : index)
  ^bb17:  // pred: ^bb15
    %108 = llvm.add %94, %0  : i64
    %109 = builtin.unrealized_conversion_cast %108 : i64 to index
    cf.br ^bb13(%109 : index)
  ^bb18:  // pred: ^bb13
    call @matmul(%22, %40, %58) : (memref<4x4xf32>, memref<4x4xf32>, memref<4x4xf32>) -> ()
    %110 = llvm.mlir.constant(1 : index) : i64
    %111 = llvm.alloca %110 x !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> : (i64) -> !llvm.ptr
    llvm.store %57, %111 : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr
    %112 = llvm.mlir.constant(2 : index) : i64
    %113 = llvm.mlir.undef : !llvm.struct<(i64, ptr)>
    %114 = llvm.insertvalue %112, %113[0] : !llvm.struct<(i64, ptr)> 
    %115 = llvm.insertvalue %111, %114[1] : !llvm.struct<(i64, ptr)> 
    %116 = builtin.unrealized_conversion_cast %115 : !llvm.struct<(i64, ptr)> to memref<*xf32>
    call @printMemrefF32(%116) : (memref<*xf32>) -> ()
    %117 = llvm.extractvalue %21[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    llvm.call @free(%117) : (!llvm.ptr) -> ()
    %118 = llvm.extractvalue %39[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    llvm.call @free(%118) : (!llvm.ptr) -> ()
    %119 = llvm.extractvalue %57[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    llvm.call @free(%119) : (!llvm.ptr) -> ()
    return
  }
}

